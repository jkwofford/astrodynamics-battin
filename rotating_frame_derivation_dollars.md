
# Rotating Frame Acceleration Derivation (DCM Method)

## Given

Position vector expressed in rotating **body frame \( B \):**

$$
\mathbf{r}^B =
\begin{bmatrix}
r \\
0 \\
0
\end{bmatrix}
$$

The inertial position is related via the direction cosine matrix (DCM):

$$
\mathbf{r}^{\,i} = C_B^{\,i}\,\mathbf{r}^{\,B},
\qquad
C_B^{\,i} = (C_i^{\,B})^T
$$

---

## Step 1 – Differentiate Once

Apply the product rule:

$$
\dot{\mathbf{r}}^{\,i}
= \dot{C}_B^{\,i}\,\mathbf{r}^{\,B}
+ C_B^{\,i}\,\dot{\mathbf{r}}^{\,B}
$$

---

## Step 2 – Differentiate Again

$$
\ddot{\mathbf{r}}^{\,i}
= \ddot{C}_B^{\,i}\,\mathbf{r}^{\,B}
+ 2\,\dot{C}_B^{\,i}\,\dot{\mathbf{r}}^{\,B}
+ C_B^{\,i}\,\ddot{\mathbf{r}}^{\,B}
$$

---

## Step 3 – Transform Back to Body Frame

Multiply by \( C_i^{\,B} \):

$$
\mathbf{a}_B^{\,i}
:= C_i^{\,B}\,\ddot{\mathbf{r}}^{\,i}
$$

$$
\mathbf{a}_B^{\,i}
= C_i^{\,B}\ddot{C}_B^{\,i}\,\mathbf{r}^{\,B}
+ 2\,C_i^{\,B}\dot{C}_B^{\,i}\,\dot{\mathbf{r}}^{\,B}
+ \ddot{\mathbf{r}}^{\,B}
$$

---

## Step 4 – Key DCM Identities

Define the skew‑symmetric cross‑product matrix \( [\omega \times] \):

$$
[\omega \times]\mathbf{x} = \boldsymbol{\omega} \times \mathbf{x}
$$

For a rotating frame:

$$
C_i^{\,B}\dot{C}_B^{\,i} = [\omega \times]
$$

Differentiate:

$$
C_i^{\,B}\ddot{C}_B^{\,i}
= [\dot{\omega} \times] + [\omega \times]^2
$$

---

## Step 5 – Substitute Identities

$$
\mathbf{a}_B^{\,i}
= \ddot{\mathbf{r}}^{\,B}
+ 2[\omega \times]\dot{\mathbf{r}}^{\,B}
+ [\dot{\omega} \times]\mathbf{r}^{\,B}
+ [\omega \times]^2 \mathbf{r}^{\,B}
$$

---

## Final Result (Transport Theorem)

$$
\boxed{
\mathbf{a}^{\,i}
= \mathbf{a}^{\,B}
+ 2\boldsymbol{\omega} \times \mathbf{v}^{\,B}
+ \dot{\boldsymbol{\omega}} \times \mathbf{r}
+ \boldsymbol{\omega} \times (\boldsymbol{\omega} \times \mathbf{r})
}
$$

---

## Special Case – Rotation About \( z \)-Axis

$$
\boldsymbol{\omega} =
\begin{bmatrix}
0 \\
0 \\
\dot{\theta}
\end{bmatrix},
\qquad
\dot{\boldsymbol{\omega}} =
\begin{bmatrix}
0 \\
0 \\
\ddot{\theta}
\end{bmatrix}
$$

$$
\mathbf{r}^B =
\begin{bmatrix}
r \\
0 \\
0
\end{bmatrix},
\qquad
\dot{\mathbf{r}}^B =
\begin{bmatrix}
\dot{r} \\
0 \\
0
\end{bmatrix}
$$

Resulting acceleration:

$$
\mathbf{a}_B^{\,i} =
\begin{bmatrix}
\ddot{r} - r\dot{\theta}^2 \\
r\ddot{\theta} + 2\dot{r}\dot{\theta} \\
0
\end{bmatrix}
$$

---

## Interpretation of Terms

| Term | Meaning |
|------|---------|
| \( \ddot{r} \) | Radial acceleration |
| \( -r\dot{\theta}^2 \) | Centrifugal acceleration |
| \( r\ddot{\theta} \) | Tangential acceleration |
| \( 2\dot{r}\dot{\theta} \) | Coriolis acceleration |
