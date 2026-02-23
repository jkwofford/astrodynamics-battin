# Rotating Frame Acceleration Derivation (DCM Method)

## Given

Position vector expressed in rotating **body frame ( B ):**

\[ `\mathbf{r}`{=tex}\^B =
```{=tex}
\begin{bmatrix}
r \\
0 \\
0
\end{bmatrix}
```
\]

The inertial position is related via the direction cosine matrix (DCM):

\[ `\mathbf{r}`{=tex}\^{,i} = C_B^{,i},`\mathbf{r}`{=tex}^{,B},
`\qquad`{=tex} C_B\^{,i} = (C_i^{,B})^T \]

------------------------------------------------------------------------

## Step 1 -- Differentiate Once

Apply the product rule:

\[ `\dot{\mathbf{r}}`{=tex}\^{,i} =
`\dot{C}`{=tex}\_B^{,i},`\mathbf{r}`{=tex}^{,B} +
C_B^{,i},`\dot{\mathbf{r}}`{=tex}^{,B} \]

------------------------------------------------------------------------

## Step 2 -- Differentiate Again

\[ `\ddot{\mathbf{r}}`{=tex}\^{,i} =
`\ddot{C}`{=tex}\_B^{,i},`\mathbf{r}`{=tex}^{,B} +
2,`\dot{C}`{=tex}\_B^{,i},`\dot{\mathbf{r}}`{=tex}^{,B} +
C_B^{,i},`\ddot{\mathbf{r}}`{=tex}^{,B} \]

------------------------------------------------------------------------

## Step 3 -- Transform Back to Body Frame

Multiply by ( C_i\^{,B} ):

\[ `\mathbf{a}`{=tex}\_B\^{,i} :=
C_i^{,B},`\ddot{\mathbf{r}}`{=tex}^{,i} \]

\[ `\mathbf{a}`{=tex}\_B\^{,i} =
C_i\^{,B}`\ddot{C}`{=tex}\_B^{,i},`\mathbf{r}`{=tex}^{,B} +
2,C_i\^{,B}`\dot{C}`{=tex}\_B^{,i},`\dot{\mathbf{r}}`{=tex}^{,B} +
`\ddot{\mathbf{r}}`{=tex}\^{,B} \]

------------------------------------------------------------------------

## Step 4 -- Key DCM Identities

Define the skew‑symmetric cross‑product matrix (
\[`\omega `{=tex}`\times`{=tex}\] ):

\[ \[`\omega `{=tex}`\times`{=tex}\]`\mathbf{x}`{=tex} =
`\boldsymbol{\omega}`{=tex} `\times `{=tex}`\mathbf{x}`{=tex} \]

For a rotating frame:

\[ C_i\^{,B}`\dot{C}`{=tex}\_B\^{,i} = \[`\omega `{=tex}`\times`{=tex}\]
\]

Differentiate:

\[ C_i\^{,B}`\ddot{C}`{=tex}\_B\^{,i} = \[`\dot{\omega}`{=tex}
`\times`{=tex}\] + \[`\omega `{=tex}`\times`{=tex}\]\^2 \]

------------------------------------------------------------------------

## Step 5 -- Substitute Identities

\[ `\mathbf{a}`{=tex}\_B\^{,i} = `\ddot{\mathbf{r}}`{=tex}\^{,B} +
2\[`\omega `{=tex}`\times`{=tex}\]`\dot{\mathbf{r}}`{=tex}\^{,B} +
\[`\dot{\omega}`{=tex} `\times`{=tex}\]`\mathbf{r}`{=tex}\^{,B} +
\[`\omega `{=tex}`\times`{=tex}\]\^2 `\mathbf{r}`{=tex}\^{,B} \]

------------------------------------------------------------------------

## Final Result (Transport Theorem)

\[ `\boxed{
\mathbf{a}^{\,i}
= \mathbf{a}^{\,B}
+ 2\boldsymbol{\omega} \times \mathbf{v}^{\,B}
+ \dot{\boldsymbol{\omega}} \times \mathbf{r}
+ \boldsymbol{\omega} \times (\boldsymbol{\omega} \times \mathbf{r})
}`{=tex} \]

------------------------------------------------------------------------

## Special Case -- Rotation About ( z )-Axis

\[ `\boldsymbol{\omega}`{=tex} =
```{=tex}
\begin{bmatrix}
0 \\
0 \\
\dot{\theta}
\end{bmatrix}
```
, `\qquad`{=tex} `\dot{\boldsymbol{\omega}}`{=tex} =
```{=tex}
\begin{bmatrix}
0 \\
0 \\
\ddot{\theta}
\end{bmatrix}
```
\]

\[ `\mathbf{r}`{=tex}\^B =
```{=tex}
\begin{bmatrix}
r \\
0 \\
0
\end{bmatrix}
```
, `\qquad`{=tex} `\dot{\mathbf{r}}`{=tex}\^B =
```{=tex}
\begin{bmatrix}
\dot{r} \\
0 \\
0
\end{bmatrix}
```
\]

Resulting acceleration:

\[ `\mathbf{a}`{=tex}\_B\^{,i} =
```{=tex}
\begin{bmatrix}
\ddot{r} - r\dot{\theta}^2 \\
r\ddot{\theta} + 2\dot{r}\dot{\theta} \\
0
\end{bmatrix}
```
\]

------------------------------------------------------------------------

## Interpretation of Terms

  Term                                       Meaning
  ------------------------------------------ --------------------------
  ( `\ddot{r}`{=tex} )                       Radial acceleration
  ( -r`\dot{\theta}`{=tex}\^2 )              Centrifugal acceleration
  ( r`\ddot{\theta}`{=tex} )                 Tangential acceleration
  ( 2`\dot{r}`{=tex}`\dot{\theta}`{=tex} )   Coriolis acceleration
