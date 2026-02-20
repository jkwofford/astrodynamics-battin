# Dynamics Problem

## Given

Position expressed in the rotating **B-frame**:

\[
\mathbf{r}^B =
\begin{bmatrix}
r \\
0 \\
0
\end{bmatrix}
\]

Direction cosine matrix from inertial frame \(i\) to body frame \(B\):

\[
C_i^B =
\begin{bmatrix}
\cos\theta & \sin\theta & 0 \\
-\sin\theta & \cos\theta & 0 \\
0 & 0 & 1
\end{bmatrix}
\]

This represents a rotation about the \(z\)-axis by angle \(\theta(t)\).

---

# **(a) Inertial Acceleration of the Particle**

We seek the inertial acceleration resolved in the **B-frame**:

\[
\left[ \ddot{\mathbf{r}} \right]_B^{\,i}
=
C_i^B \left[ \ddot{\mathbf{r}} \right]^i
\]

The inertial position is related to the B-frame position via:

\[
\mathbf{r}^i = C_B^i \, \mathbf{r}^B
\]

where:

\[
C_B^i = (C_i^B)^T
\]

---

## First Derivative

Differentiate once:

\[
\dot{\mathbf{r}}^i =
\dot{C}_B^i \, \mathbf{r}^B +
C_B^i \, \dot{\mathbf{r}}^B
\]

---

## Second Derivative

Differentiate again:

\[
\ddot{\mathbf{r}}^i =
\ddot{C}_B^i \, \mathbf{r}^B +
2\dot{C}_B^i \, \dot{\mathbf{r}}^B +
C_B^i \, \ddot{\mathbf{r}}^B
\]

Transform back into B-frame components:

\[
\left[ \ddot{\mathbf{r}} \right]_B^{\,i}
=
C_i^B \ddot{\mathbf{r}}^i
\]

---

## Rotation-Rate Matrix

For a planar rotation about \(z\):

\[
\Omega =
C_i^B \dot{C}_B^i =
\begin{bmatrix}
0 & \dot{\theta} & 0 \\
-\dot{\theta} & 0 & 0 \\
0 & 0 & 0
\end{bmatrix}
\]

Useful identity:

\[
C_i^B \ddot{C}_B^i = \dot{\Omega} + \Omega^2
\]

---

## B-frame Kinematics

\[
\mathbf{r}^B =
\begin{bmatrix}
r \\
0 \\
0
\end{bmatrix},
\quad
\dot{\mathbf{r}}^B =
\begin{bmatrix}
\dot{r} \\
0 \\
0
\end{bmatrix},
\quad
\ddot{\mathbf{r}}^B =
\begin{bmatrix}
\ddot{r} \\
0 \\
0
\end{bmatrix}
\]

---

## Evaluate Terms

### Centripetal Term

\[
\Omega^2 \mathbf{r}^B =
\begin{bmatrix}
- r \dot{\theta}^2 \\
0 \\
0
\end{bmatrix}
\]

---

### Euler Term

\[
\dot{\Omega} \mathbf{r}^B =
\begin{bmatrix}
0 \\
r \ddot{\theta} \\
0
\end{bmatrix}
\]

---

### Coriolis Term

\[
2\Omega \dot{\mathbf{r}}^B =
\begin{bmatrix}
0 \\
2 \dot{r} \dot{\theta} \\
0
\end{bmatrix}
\]

---

## Final Acceleration

\[
\boxed{
\left[ \ddot{\mathbf{r}} \right]_B^{\,i}
=
\begin{bmatrix}
\ddot{r} - r \dot{\theta}^2 \\
r \ddot{\theta} + 2 \dot{r} \dot{\theta} \\
0
\end{bmatrix}
}
\]

---

# **(b) Applying Newton’s Second Law**

Assume gravity from a central mass \(M\):

\[
\mathbf{f}_B =
\begin{bmatrix}
-\dfrac{G M m_p}{r^2} \\
0 \\
0
\end{bmatrix}
\]

Newton’s law:

\[
\mathbf{f}_B = m_p \left[ \ddot{\mathbf{r}} \right]_B^{\,i}
\]

---

## Radial Equation

\[
m_p (\ddot{r} - r \dot{\theta}^2)
=
-\dfrac{G M m_p}{r^2}
\]

\[
\boxed{
\ddot{r} - r \dot{\theta}^2 = -\dfrac{G M}{r^2}
}
\]

---

## Transverse Equation

\[
m_p (r \ddot{\theta} + 2 \dot{r} \dot{\theta}) = 0
\]

\[
\boxed{
r \ddot{\theta} + 2 \dot{r} \dot{\theta} = 0
}
\]

---

## Angular Momentum Conservation

\[
r \ddot{\theta} + 2 \dot{r} \dot{\theta} = 0
\]

\[
\frac{d}{dt}(r^2 \dot{\theta}) = 0
\]

\[
\boxed{
r^2 \dot{\theta} = \text{constant}
}
\]

---

# **Final Equations of Motion**

\[
\boxed{
\ddot{r} - r \dot{\theta}^2 = -\dfrac{G M}{r^2}
}
\]

\[
\boxed{
r \ddot{\theta} + 2 \dot{r} \dot{\theta} = 0
}
\]

These are the standard **planar two-body equations in polar coordinates**.
