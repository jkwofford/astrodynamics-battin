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

# Explicit Derivation of DCM Identities

## Identity 1: \( C_i^{\,B}\dot{C}_B^{\,i} = [\omega \times] \)

### Orthogonality of a DCM

Because \(C_B^{\,i}\) is a rotation matrix:

$$
C_B^{\,i} (C_B^{\,i})^T = I
$$

Differentiate both sides:

$$
\dot{C}_B^{\,i} (C_B^{\,i})^T + C_B^{\,i} (\dot{C}_B^{\,i})^T = 0
$$

Rearrange:

$$
\dot{C}_B^{\,i} (C_B^{\,i})^T =
- \left[ \dot{C}_B^{\,i} (C_B^{\,i})^T \right]^T
$$

So

$$
\dot{C}_B^{\,i} (C_B^{\,i})^T
$$

is **skew-symmetric**.

---

### Any skew-symmetric matrix ↔ cross product

Any \(3\times 3\) skew-symmetric matrix corresponds to a unique vector
\(\boldsymbol{\omega}\) such that

$$
\dot{C}_B^{\,i} (C_B^{\,i})^T = [\omega \times]
$$

Now multiply on the left by \(C_i^{\,B} = (C_B^{\,i})^T\):

$$
C_i^{\,B} \dot{C}_B^{\,i} = [\omega \times]
$$

---

## Identity 2: \( C_i^{\,B}\ddot{C}_B^{\,i} = [\dot{\omega}\times] + [\omega\times]^2 \)

Differentiate Identity 1:

$$
\frac{d}{dt}(C_i^{\,B} \dot{C}_B^{\,i})
= \frac{d}{dt}([\omega \times])
$$

Apply product rule on the left:

$$
\dot{C}_i^{\,B} \dot{C}_B^{\,i}
+ C_i^{\,B} \ddot{C}_B^{\,i}
= [\dot{\omega} \times]
$$

---

### Derivative of the inverse DCM

Since \(C_i^{\,B} = (C_B^{\,i})^T\) and \(C_i^{\,B}C_B^{\,i}=I\),

$$
\frac{d}{dt}(C_i^{\,B}C_B^{\,i}) = 0
$$

So

$$
\dot{C}_i^{\,B}C_B^{\,i} + C_i^{\,B}\dot{C}_B^{\,i} = 0
$$

Multiply on the right by \(C_i^{\,B}\):

$$
\dot{C}_i^{\,B} + C_i^{\,B}\dot{C}_B^{\,i}C_i^{\,B} = 0
$$

Use Identity 1 (\(C_i^{\,B}\dot{C}_B^{\,i}=[\omega\times]\)):

$$
\dot{C}_i^{\,B} + [\omega\times]C_i^{\,B} = 0
\quad\Rightarrow\quad
\dot{C}_i^{\,B} = -[\omega\times]C_i^{\,B}
$$

---

Substitute into the differentiated identity:

$$
-[\omega\times]C_i^{\,B}\dot{C}_B^{\,i}
+ C_i^{\,B}\ddot{C}_B^{\,i}
= [\dot{\omega}\times]
$$

Use Identity 1 again (\(C_i^{\,B}\dot{C}_B^{\,i}=[\omega\times]\)):

$$
-[\omega\times][\omega\times]
+ C_i^{\,B}\ddot{C}_B^{\,i}
= [\dot{\omega}\times]
$$

Rearrange:

$$
C_i^{\,B}\ddot{C}_B^{\,i}
= [\dot{\omega}\times] + [\omega\times]^2
$$

---

# Substitute Back into Acceleration

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