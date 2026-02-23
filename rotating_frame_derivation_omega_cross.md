# Rotating Frame Acceleration Derivation (DCM Method)

## Direction Cosine Matrix Relation

The position vector in inertial and body frames is related by:

\[
\mathbf r^{\,i} = C_B^{\,i}\,\mathbf r^{\,B}
\]

Differentiate twice:

\[
\ddot{\mathbf r}^{\,i}
= \ddot C_B^{\,i}\,\mathbf r^{\,B}
+ 2\,\dot C_B^{\,i}\,\dot{\mathbf r}^{\,B}
+ C_B^{\,i}\,\ddot{\mathbf r}^{\,B}
\]

Define inertial acceleration expressed in the body frame:

\[
\mathbf a_B^{\,i} := C_i^{\,B}\,\ddot{\mathbf r}^{\,i}
\]

Substitute:

\[
\mathbf a_B^{\,i}
= C_i^{\,B}\ddot C_B^{\,i}\,\mathbf r^{\,B}
+ 2 C_i^{\,B}\dot C_B^{\,i}\,\dot{\mathbf r}^{\,B}
+ C_i^{\,B}C_B^{\,i}\,\ddot{\mathbf r}^{\,B}
\]

Using \( C_i^{\,B}C_B^{\,i} = I \):

\[
\mathbf a_B^{\,i}
= C_i^{\,B}\ddot C_B^{\,i}\,\mathbf r^{\,B}
+ 2 C_i^{\,B}\dot C_B^{\,i}\,\dot{\mathbf r}^{\,B}
+ \ddot{\mathbf r}^{\,B}
\]

---

## Cross‑Product Matrix Notation

Define the skew‑symmetric matrix \( [\omega]^\times \) such that:

\[
[\omega]^\times \mathbf x := \boldsymbol\omega \times \mathbf x
\]

---

## DCM Identities

**Identity 1**

\[
C_i^{\,B}\dot C_B^{\,i} = [\omega]^\times
\]

**Identity 2**

\[
C_i^{\,B}\ddot C_B^{\,i}
= [\dot\omega]^\times + ([\omega]^\times)^2
\]

---

## Substitute Identities

### First Term

\[
C_i^{\,B}\ddot C_B^{\,i}\,\mathbf r^{\,B}
= ([\dot\omega]^\times + ([\omega]^\times)^2)\mathbf r^{\,B}
\]

\[
= [\dot\omega]^\times \mathbf r^{\,B}
+ ([\omega]^\times)^2 \mathbf r^{\,B}
\]

---

### Second Term

\[
2 C_i^{\,B}\dot C_B^{\,i}\,\dot{\mathbf r}^{\,B}
= 2 [\omega]^\times \dot{\mathbf r}^{\,B}
\]

---

## Combine Terms

\[
\mathbf a_B^{\,i}
= \ddot{\mathbf r}^{\,B}
+ 2 [\omega]^\times \dot{\mathbf r}^{\,B}
+ [\dot\omega]^\times \mathbf r^{\,B}
+ ([\omega]^\times)^2 \mathbf r^{\,B}
\]

---

## Convert Back to Cross Products

Using

\[
[\omega]^\times \mathbf x = \boldsymbol\omega \times \mathbf x
\]

and

\[
([\omega]^\times)^2 \mathbf r
= \boldsymbol\omega \times (\boldsymbol\omega \times \mathbf r)
\]

we obtain

\[
\boxed{
\mathbf a_B^{\,i}
= \ddot{\mathbf r}^{\,B}
+ 2\boldsymbol\omega \times \dot{\mathbf r}^{\,B}
+ \dot{\boldsymbol\omega} \times \mathbf r^{\,B}
+ \boldsymbol\omega \times (\boldsymbol\omega \times \mathbf r^{\,B})
}
\]

---

## Final Transport Theorem Form

Let

\( \mathbf v^{\,B} := \dot{\mathbf r}^{\,B} \)

\( \mathbf a^{\,B} := \ddot{\mathbf r}^{\,B} \)

\[
\boxed{
\mathbf a_B^{\,i}
= \mathbf a^{\,B}
+ 2\boldsymbol\omega \times \mathbf v^{\,B}
+ \dot{\boldsymbol\omega} \times \mathbf r^{\,B}
+ \boldsymbol\omega \times (\boldsymbol\omega \times \mathbf r^{\,B})
}
\]
