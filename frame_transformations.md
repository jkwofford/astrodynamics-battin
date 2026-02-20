# Reference Frame Transformation Matrices

This note summarizes the standard Direction Cosine Matrices (DCMs) for the frame chain:

ECI → ECEF → NED (Navigation) → Body

**Convention used:**  
A DCM \( C_a^{\,b} \) maps vector components from frame **a** into frame **b**:

\[
\mathbf{v}^b = C_a^{\,b} \mathbf{v}^a
\]

All frames are right-handed.

---

# 1. **ECI → ECEF**

Ignoring precession/nutation/polar motion (basic model), the Earth-fixed frame rotates about the inertial \(z\)-axis:

\[
C_{ECI}^{ECEF} = R_3(\theta_g)
\]

where \(\theta_g\) is the Greenwich sidereal angle (Earth rotation angle).

\[
R_3(\psi) =
\begin{bmatrix}
\cos\psi & \sin\psi & 0 \\
-\sin\psi & \cos\psi & 0 \\
0 & 0 & 1
\end{bmatrix}
\]

\[
C_{ECI}^{ECEF} =
\begin{bmatrix}
\cos\theta_g & \sin\theta_g & 0 \\
-\sin\theta_g & \cos\theta_g & 0 \\
0 & 0 & 1
\end{bmatrix}
\]

Inverse:

\[
C_{ECEF}^{ECI} = (C_{ECI}^{ECEF})^T = R_3(-\theta_g)
\]

**Euler-angle interpretation:** single yaw rotation about \(z\).

---

# 2. **ECEF → NED (Local-Level Frame)**

Given geodetic latitude \(\phi\) and longitude \(\lambda\):

\[
C_{ECEF}^{NED} =
\begin{bmatrix}
-\sin\phi\cos\lambda & -\sin\phi\sin\lambda & \cos\phi \\
-\sin\lambda & \cos\lambda & 0 \\
-\cos\phi\cos\lambda & -\cos\phi\sin\lambda & -\sin\phi
\end{bmatrix}
\]

\[
\mathbf{v}^{NED} = C_{ECEF}^{NED} \mathbf{v}^{ECEF}
\]

Inverse:

\[
C_{NED}^{ECEF} = (C_{ECEF}^{NED})^T
\]

**Geometric interpretation:** longitude rotation + latitude tilt aligning Down with ellipsoid normal.

---

# 3. **NED → Body (3–2–1 Euler Angles)**

Euler angles:

- Yaw \(\psi\)
- Pitch \(\theta\)
- Roll \(\phi\)

Rotation sequence (3–2–1):

\[
C_{NED}^{B} = R_1(\phi) R_2(\theta) R_3(\psi)
\]

\[
R_1(\phi) =
\begin{bmatrix}
1 & 0 & 0 \\
0 & \cos\phi & \sin\phi \\
0 & -\sin\phi & \cos\phi
\end{bmatrix}
\]

\[
R_2(\theta) =
\begin{bmatrix}
\cos\theta & 0 & -\sin\theta \\
0 & 1 & 0 \\
\sin\theta & 0 & \cos\theta
\end{bmatrix}
\]

\[
R_3(\psi) =
\begin{bmatrix}
\cos\psi & \sin\psi & 0 \\
-\sin\psi & \cos\psi & 0 \\
0 & 0 & 1
\end{bmatrix}
\]

Expanded DCM:

\[
C_{NED}^{B} =
\begin{bmatrix}
c_\theta c_\psi & c_\theta s_\psi & -s_\theta \\
s_\phi s_\theta c_\psi - c_\phi s_\psi &
s_\phi s_\theta s_\psi + c_\phi c_\psi &
s_\phi c_\theta \\
c_\phi s_\theta c_\psi + s_\phi s_\psi &
c_\phi s_\theta s_\psi - s_\phi c_\psi &
c_\phi c_\theta
\end{bmatrix}
\]

Inverse:

\[
C_{B}^{NED} = (C_{NED}^{B})^T
\]

---

# 4. **Full Frame Chain Composition**

Vector transformation from ECI → Body:

\[
\mathbf{v}^{B} =
C_{NED}^{B} \, C_{ECEF}^{NED} \, C_{ECI}^{ECEF} \, \mathbf{v}^{ECI}
\]

Combined DCM:

\[
C_{ECI}^{B} =
C_{NED}^{B} \, C_{ECEF}^{NED} \, C_{ECI}^{ECEF}
\]

---

# 5. **Extracting Euler Angles from a DCM (3–2–1)**

Given \(C_{NED}^{B} = [c_{ij}]\):

\[
\theta = -\arcsin(c_{13})
\]

\[
\psi = \operatorname{atan2}(c_{12}, c_{11})
\]

\[
\phi = \operatorname{atan2}(c_{23}, c_{33})
\]

**Singularity (gimbal lock):** occurs when \(|\theta| = 90^\circ\).

---

# 6. **Navigation / Wander Azimuth Frame**

A wander frame \(W\) rotates relative to NED by wander angle \(\alpha\):

\[
C_{NED}^{W} = R_3(\alpha)
\]

\[
C_{W}^{NED} = R_3(-\alpha)
\]

Used to avoid polar singularities in inertial navigation.

---

# ✅ **Key Insight**

- A **DCM** is the fundamental rotation object.
- **Euler angles** are a parameterization of a DCM.
- Multiple rotations compose via matrix multiplication.
