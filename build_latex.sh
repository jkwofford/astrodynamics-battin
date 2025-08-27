#!/usr/bin/env bash
# build_latex.sh — compile LaTeX to PDF and clean aux files
# Usage:
#   ./build_latex.sh [main.tex] [--engine=pdflatex|xelatex|lualatex] [--bib=auto|bibtex|biber|none] [--out=build] [--clean]
#
# Examples:
#   ./build_latex.sh main-2.tex
#   ./build_latex.sh main.tex --engine=xelatex --bib=auto
#   ./build_latex.sh main-2.tex --clean
set -euo pipefail

FILE="${1:-main-2.tex}"

# Defaults (can be overridden by flags or env vars)
ENGINE="${ENGINE:-pdflatex}"
BIBTOOL="${BIBTOOL:-auto}"
OUTDIR="${OUTDIR:-build}"
CLEAN_ONLY="0"

# Parse flags
for arg in "${@:2}"; do
  case "$arg" in
    --engine=*) ENGINE="${arg#*=}";;
    --bib=*)    BIBTOOL="${arg#*=}";;
    --out=*)    OUTDIR="${arg#*=}";;
    --clean)    CLEAN_ONLY="1";;
    *) echo "Unknown flag: $arg" >&2; exit 2;;
  esac
done

BASENAME="${FILE%.tex}"

aux_globs=(
  "*.aux" "*.bbl" "*.bcf" "*.blg" "*.log" "*.out" "*.toc" "*.lof" "*.lot"
  "*.run.xml" "*.fls" "*.fdb_latexmk" "*.synctex.gz" "*.nav" "*.snm"
  "*.vrb" "*.xdv" "*.thm" "*.ilg" "*.ind" "*.idx" "*.acn" "*.acr" "*.alg"
)

clean_aux() {
  local dir="$1"
  shopt -s nullglob
  for g in "${aux_globs[@]}"; do
    rm -f "$dir"/$g || true
  done
  shopt -u nullglob
}

if [[ "$CLEAN_ONLY" == "1" ]]; then
  echo "Cleaning auxiliary files in '$OUTDIR'..."
  mkdir -p "$OUTDIR"
  clean_aux "$OUTDIR"
  echo "Cleaning auxiliary files in current directory..."
  clean_aux "."
  echo "Done."
  exit 0
fi

mkdir -p "$OUTDIR"

run_engine() {
  "$ENGINE" -interaction=nonstopmode -halt-on-error -output-directory "$OUTDIR" "$FILE" >/dev/null
}

run_bib() {
  case "$BIBTOOL" in
    biber)
      (cd "$OUTDIR" && biber "$BASENAME" >/dev/null)
      ;;
    bibtex)
      (cd "$OUTDIR" && bibtex "$BASENAME" >/dev/null)
      ;;
    auto)
      # Prefer biber if a .bcf is present (biblatex)
      if [[ -f "$OUTDIR/$BASENAME.bcf" ]]; then
        (cd "$OUTDIR" && biber "$BASENAME" >/dev/null)
      else
        # Fallback: run bibtex if a .aux exists or \bibliography is used
        if [[ -f "$OUTDIR/$BASENAME.aux" ]] || grep -q '\\bibliography{' "$FILE" 2>/dev/null; then
          (cd "$OUTDIR" && bibtex "$BASENAME" >/dev/null || true)
        fi
      fi
      ;;
    none)
      : ;;
    *)
      echo "Unknown --bib option: $BIBTOOL" >&2; exit 2;;
  esac
}

echo "Engine : $ENGINE"
echo "Bib    : $BIBTOOL"
echo "Outdir : $OUTDIR"
echo "Target : $FILE"

# First pass
run_engine || { echo "LaTeX failed on first pass. See log in '$OUTDIR/${BASENAME}.log'."; exit 1; }

# Bibliography (if any)
run_bib || { echo "Bibliography tool failed."; exit 1; }

# Two more passes to resolve refs
run_engine || { echo "LaTeX failed on second pass."; exit 1; }
run_engine || { echo "LaTeX failed on final pass."; exit 1; }

PDF="$OUTDIR/${BASENAME}.pdf"
if [[ -f "$PDF" ]]; then
  echo "Success: built $PDF"
else
  echo "Build completed but PDF not found: $PDF" >&2
  exit 1
fi

# Optional: tidy aux in current dir (keep OUTDIR aux to speed future builds)
clean_aux "."
