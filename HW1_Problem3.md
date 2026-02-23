## 1. True/False
`1. "A reference frame is a fixed coordinate system used to measure positions and velocities of objects, while a coordinate system can change depending on the observer’s motion."`

False - A reference frame is not necessarily fixed

`2. "The transpose of a skew symmetric matrix representing a rotation rate is the negative of the rate vector."`
Technically false, but kind of true - The transpose is not literally the negative of the rate vector, but it is the skew matrix formed from the negative rate vector. Explanation:

The angular velocity or rotation rate vector
$$
\vec{\omega} =
\begin{bmatrix}
\omega_x \\[2pt]
\omega_y \\[2pt]
\omega_z
\end{bmatrix}
$$

We can form the skew-symmetric matrix

$$
\overleftrightarrow{\omega} =
\begin{bmatrix}
0 & -\omega_z & \omega_y \\[2pt]
\omega_z & 0 & -\omega_x \\[2pt]
-\omega_y & \omega_x & 0
\end{bmatrix}
$$

where multiplication operation between the matrix and a column vector represent the cross-product

$$
\overleftrightarrow{\omega} \vec{v} = \vec{\omega} \times \vec{v}
$$

For skew-symmetric matricies, the transpose is

$$
\overleftrightarrow{\omega}^{T} = -\overleftrightarrow{\omega}
$$

Explicitly this transpose is

$$
\overleftrightarrow{\omega}^T =
\begin{bmatrix}
0 & \omega_z & -\omega_y \\[2pt]
-\omega_z & 0 & \omega_x \\[2pt]
\omega_y & -\omega_x & 0
\end{bmatrix}
$$

Every off-diagonal term is flipped, which corresponds to the vector $-\vec{\omega}$

The statement is technically false because the transpose of the matrix is NOT literally the negative of the rate vector itself, but rather the transpose is the skew-symmetric matrix representing the negative angular veloctiy vector.

`"3. There are exactly 5 reference frames a navigation engineer concerns themself with."`

False. According to slide 21, there are 6 listed frames - ECI,
ECEF, NED, Geodetic, Nav/Wander Azimuth, and Body. After some quick research, there are more than these that engineers use such as Perifocal, TEME, GCRF etc.

---
## 2. Matlab Problem
See matlab.m

---
## 3. Dynamics Problem
Position expressed in the rotating frame "Body" frame $B$

$$
\vec{r}^B =
\begin{bmatrix}
r \\[2pt]
0 \\[2pt]
0
\end{bmatrix}
$$

It's given the direction‑cosine matrix from inertial frame $i$ to body frame $B$:

$$
\overleftrightarrow{C}_i^B =
\begin{bmatrix}
\cos\theta(t) & \sin\theta(t) & 0 \\[2pt]
-\sin\theta(t) & \cos\theta(t) & 0 \\[2pt]
0 & 0 & 1
\end{bmatrix}
$$

This represents a rotation about the $z$‑axis by angle $\theta(t)$, which is implied to be a function of time, $t$ because of the precense of the derivative $\dot{\theta}$ in the diagram. This is actually note explicitly stated in the homework slide

## 3a) Using inertial acceleration of B frame $\frac{d^2}{dt^2}\vec{r}^i = C_i^B \,\frac{d^2}{dt^2}\vec{r}^i $, show
$$
\ddot{\vec{r}}_B^{\,i}
=
\begin{bmatrix}
\ddot{r} - r \dot{\theta}^{2} \\[4pt]
r \ddot{\theta} + 2 \dot{r} \dot{\theta} \\[4pt]
0
\end{bmatrix}
$$
---
I'll use the Leibniz notation because all derivatives are all with respect to one variable. Re-writing the inertial acceleration of B frame:

$$
\ddot{\vec{r}^i}_B
=
\overleftrightarrow{C}_i^B \,\ddot{\vec{r}^i}
$$

The inertial position is related to the B‑frame position via the transformation matrix:

$$
\vec{r}^i = \overleftrightarrow{C}_B^i \, \vec{r}^B ,
\qquad
\overleftrightarrow{C}_B^i = \bigl(\overleftrightarrow{C}_i^B\bigr)^{\!T}
$$


Differentiate once with respect to time:

$$
\dot{\vec{r}^i} =
\dot{\overleftrightarrow{C}_B^i} \, \vec{r}^B +
\overleftrightarrow{C}_B^i \, \dot{\vec{r}}^B
$$

Note that when we take derivatives of multi-dimmensional objects such as vectors and matricies, it's done component wise

Differentiate again:

$$
\ddot{\vec{r}}^i =
\ddot{\overleftrightarrow{C}_B^i} \, \vec{r}^B +
2\,\dot{\overleftrightarrow{C}_B^i} \, \dot{\vec{r}}^B +
\overleftrightarrow{C}_B^i \, \ddot{\vec{r}}^B
$$

Transform back into B‑frame components:

$$
\ddot{\vec{r}}_B^{\,i}
=
\overleftrightarrow{C}_i^B \, \ddot{\vec{r}}^i
$$

$$
\ddot{\vec{r}}_B^{\,i}
=
\overleftrightarrow{C}_i^B \,(\ddot{\overleftrightarrow{C}_B^i} \, \vec{r}^B +
2\,\dot{\overleftrightarrow{C}_B^i} \, \dot{\vec{r}}^B +
\overleftrightarrow{C}_B^i \, \ddot{\vec{r}}^B)
$$

$$
\boxed{
\ddot{\vec{r}}_B^{\,i} =  \overleftrightarrow{C}_i^{\,B}\ddot{\overleftrightarrow{C}_B^{\,i}}\,\vec{r}^{\,B}
+ 2\,\overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}}\,\dot{\vec{r}}^{\,B}
+ \ddot{\vec{r}}^{\,B}
}
$$

On the last term, make use of the fact that

$$
 \overleftrightarrow{C}_i^{\,B}  \overleftrightarrow{C}_B^{\,i} = I
$$

We must now evaluate the terms involving the mulitplication of the DCM matricies.

The inverse (transpose) is the body-to-inertial DCM:

$$
\overleftrightarrow{C}_B^{\,i} = (\overleftrightarrow{C}_i^{\,B})^T =
\begin{bmatrix}
\cos\theta & -\sin\theta & 0\\
\sin\theta & \cos\theta & 0\\
0&0&1
\end{bmatrix}
$$

Differentiating

$$
\dot{\overleftrightarrow{C}_B^{\,i}}
=
\begin{bmatrix}
-\dot\theta\sin\theta & -\dot\theta\cos\theta & 0\\
\dot\theta\cos\theta & -\dot\theta\sin\theta & 0\\
0&0&0
\end{bmatrix}
$$

Now evaluate the term
$$
\overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}}= \begin{bmatrix}
\cos\theta & \sin\theta & 0\\
-\sin\theta & \cos\theta & 0\\
0&0&1
\end{bmatrix}
\begin{bmatrix}
-\dot\theta\sin\theta & -\dot\theta\cos\theta & 0\\
\dot\theta\cos\theta & -\dot\theta\sin\theta & 0\\
0&0&0
\end{bmatrix}
$$

Through some math it's easy to show

$$
\overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}}
=
\begin{bmatrix}
0 & -\dot\theta & 0\\
\dot\theta & 0 & 0\\
0&0&0
\end{bmatrix}
$$
This corresponds to the rotation about the z-axis


$$
\vec{\omega}=
\begin{bmatrix}
0\\
0\\
\dot\theta
\end{bmatrix}
$$

In skew-symmetric form, this can be written as

$$
[\omega]^\times =
\begin{bmatrix}
0 & -\omega_z & \omega_y\\
\omega_z & 0 & -\omega_x\\
-\omega_y & \omega_x & 0
\end{bmatrix}
=
\begin{bmatrix}
0 & -\dot\theta & 0\\
\dot\theta & 0 & 0\\
0&0&0
\end{bmatrix}
$$
So the multiplication can be written as
$$
\boxed{
    \overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}} = [\omega]^\times
}
$$

Take time derivative of both sides:
$$
\frac{d}{dt}\left(C_i^{\,B}\dot C_B^{\,i}\right)
=
\frac{d}{dt}\left([\omega]^\times\right)
$$

$$
\dot C_i^{\,B}\dot C_B^{\,i} + C_i^{\,B}\ddot C_B^{\,i}
=
[\dot\omega]^\times
$$

We want to isolate that second term. Taking the transpose
$C_i^{\,B} = (C_B^{\,i})^T$. Differtiating this

$$
\dot{C_i^{\,B}} = (\dot{C_B^{\,i}})^T
$$

Substituting this back into this first term, our equation becomes

$$
(\dot{C_B^{\,i}})^T\dot C_B^{\,i} + C_i^{\,B}\ddot C_B^{\,i}
=
[\dot\omega]^\times
$$


Using our result $\overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}} = [\omega]^\times$, but instead writing

$$
\dot{\overleftrightarrow{C}_B^{\,i}} = \overleftrightarrow{C}_B^{\,i}[\omega]^\times
$$

Taking the transpose

$$
(\dot{\overleftrightarrow{C}_B^{\,i}})^T = ([\omega]^\times)^T(\overleftrightarrow{C}_B^{\,i})^T
$$

which is equal to

$$
(\dot{\overleftrightarrow{C}_B^{\,i}})^T = -[\omega]^{\times}\overleftrightarrow{C}_i^{\,B}
$$

because of skew-symmetric matrix property

$$
([\omega]^\times)^T = -([\omega]^\times)
$$


Now, we just have to substitute in

$$
\dot C_i^{\,B}\dot C_B^{\,i} = (\dot C_B^{\,i})^T\dot C_B^{\,i}
$$

$$
\dot C_i^{\,B}\dot C_B^{\,i} = -[\omega]^{\times}\overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}}
$$

Using the fact that $\overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}} = [\omega]^\times$, we get

$$
\dot C_i^{\,B}\dot C_B^{\,i} = -([\omega]^{\times})^2
$$

Plug this back into our equation

$$
\dot C_i^{\,B}\dot C_B^{\,i} + C_i^{\,B}\ddot C_B^{\,i}
=
[\dot\omega]^\times
$$

$$
-([\omega]^{\times})^2 + C_i^{\,B}\ddot C_B^{\,i}
=
[\dot\omega]^\times
$$

and rearrange

$$
C_i^{\,B}\ddot C_B^{\,i}
=
[\dot\omega]^\times + ([\omega]^{\times})^2
$$


Now substitue in for $ \overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}}$ and $ \overleftrightarrow{C}_i^{\,B}\ddot{\overleftrightarrow{C}_B^{\,i}}$. The first term in our equation for $\vec{r}^i$ is

$$
\overleftrightarrow{C}_i^{\,B}\ddot{\overleftrightarrow{C}_B^{\,i}}\,\vec{r}^{\,B}
= ([\dot\omega]^\times + ([\omega]^\times)^2)\vec{r}^{\,B}
$$

$$
= [\dot\omega]^\times \vec{r}^{\,B}
+ ([\omega]^\times)^2 \vec{r}^{\,B}
$$

The second term is

$$
2 \overleftrightarrow{C}_i^{\,B}\dot{\overleftrightarrow{C}_B^{\,i}}\,\dot{\vec{r}}^{\,B}
= 2 [\omega]^\times \dot{\vec{r}}^{\,B}
$$

Combining all of the terms

$$
\boxed{
\vec{a}^{\,i}
= \ddot{\vec{r}}^{\,B}
+ 2 [\omega]^\times \dot{\vec{r}}^{\,B}
+ [\dot\omega]^\times \vec{r}^{\,B}
+ ([\omega]^\times)^2 \vec{r}^{\,B}
}
$$

which matches what's give on slide 42. We can write this in terms of cross-products instead of matricies

Using

$$
[\omega]^\times \vec{r} = \vec{\omega} \times \vec{r}
$$

and

$$
([\omega]^\times)^2 \vec{r}
= \vec{\omega} \times (\vec{\omega} \times \vec{r})
$$

to obtain

$$
\vec{a}^{\,i}
= \ddot{\vec{r}}^{\,B}
+ 2\vec{\omega} \times \dot{\vec{r}}^{\,B}
+ \dot{\vec{\omega}} \times \vec{r}^{\,B}
+ \vec{\omega} \times (\vec{\omega}\times \vec{r}^{\,B})
$$

which matches slide 38. Now we need to plug in what we're given

$$
\vec{r}^{\,B}=
\begin{bmatrix}
r\\
0\\
0
\end{bmatrix}
\qquad
\dot{\vec{r}}^{\,B}=
\begin{bmatrix}
\dot r\\
0\\
0
\end{bmatrix}
\qquad
\ddot{\vec{r}}^{\,B}=
\begin{bmatrix}
\ddot r\\
0\\
0
\end{bmatrix}
$$

Rotation about the \(z\)-axis:

$$
\vec{\omega}=
\begin{bmatrix}
0\\
0\\
\dot\theta
\end{bmatrix}
\qquad
\dot{\vec{\omega}}=
\begin{bmatrix}
0\\
0\\
\ddot\theta
\end{bmatrix}
$$

The first term for $\vec{a}_B^{\,i}$ is simply

$$
\ddot{\vec{r}}^{\,B}=
\begin{bmatrix}
\ddot r\\
0\\
0
\end{bmatrix}
$$

The second term is $2\,\vec{\omega}\times\dot{\vec{r}}^{\,B}$, so compute just the cross-product

$$
\vec{\omega}\times\dot{\vec{r}}^{\,B}
=
\begin{bmatrix}
0\\
0\\
\dot\theta
\end{bmatrix}
\times
\begin{bmatrix}
\dot r\\
0\\
0
\end{bmatrix}
=
\begin{bmatrix}
0\\
\dot\theta\,\dot r\\
0
\end{bmatrix}
$$

and then multiply by 2

$$
2\,\vec{\omega}\times\dot{\vec{r}}^{\,B}
=
\begin{bmatrix}
0\\
2\dot\theta\,\dot r\\
0
\end{bmatrix}
$$

The third term

$$
\dot{\vec{\omega}}\times\vec{r}^{\,B}
=
\begin{bmatrix}
0\\
0\\
\ddot\theta
\end{bmatrix}
\times
\begin{bmatrix}
r\\
0\\
0
\end{bmatrix}
=
\begin{bmatrix}
0\\
r\ddot\theta\\
0
\end{bmatrix}
$$

The last term. First compute the cross-product inside the parenthesis


$$
\vec{\omega}\times\vec{r}^{\,B}
=
\begin{bmatrix}
0\\
0\\
\dot\theta
\end{bmatrix}
\times
\begin{bmatrix}
r\\
0\\
0
\end{bmatrix}
=
\begin{bmatrix}
0\\
r\dot\theta\\
0
\end{bmatrix}
$$

Then thake the cross-prodcut of that

$$
\vec{\omega}\times(\vec{\omega}\times\vec{r}^{\,B})
=
\begin{bmatrix}
0\\
0\\
\dot\theta
\end{bmatrix}
\times
\begin{bmatrix}
0\\
r\dot\theta\\
0
\end{bmatrix}
=
\begin{bmatrix}
-r\dot\theta^2\\
0\\
0
\end{bmatrix}
$$


Sum all terms component-wise to get

$$
\vec{a}^{\,i}
=
\begin{bmatrix}
\ddot r\\
0\\
0
\end{bmatrix}
+
\begin{bmatrix}
0\\
2\dot\theta\,\dot r\\
0
\end{bmatrix}
+
\begin{bmatrix}
0\\
r\ddot\theta\\
0
\end{bmatrix}
+
\begin{bmatrix}
-r\dot\theta^2\\
0\\
0
\end{bmatrix}
$$

$$
\vec{a}^{\,i}
=
\begin{bmatrix}
\ddot r - r\dot\theta^2\\
r\ddot\theta + 2\dot r\,\dot\theta\\
0
\end{bmatrix}
$$

Which is what we were asked to show

## B. If we assume only force is a mass M at the origin and in comparison to platform mass $(m_p)$, $m_p \ll M$, the force vector is

---


Assume gravity from a central mass $M$:

$$
\vec{f}_B =
\begin{bmatrix}
-\dfrac{G M m_{p}}{r^{2}} \\[4pt]
0 \\[4pt]
0
\end{bmatrix}
$$

Newton’s 2nd law:

$$
\vec{f}_B = m_{p}\,\ddot{\vec{r}}^{\,i}
$$

---
We can examine this component-wise using our results from part A.

$$
m_{p}\bigl(\ddot{r} - r \dot{\theta}^{2}\bigr)
=
-\dfrac{G M m_{p}}{r^{2}}
$$

$$
\ddot{r} - r \dot{\theta}^{2} = -\dfrac{G M}{r^{2}}
$$

Which consists of the radial acceleration $\ddot{r}$, and the centripetal term $r\dot{\theta}^2$

Looking at our other component from part A. The equation becomes

$$
m_{p}\bigl(r \ddot{\theta} + 2 \dot{r} \dot{\theta}\bigr) = 0
$$

$$
r \ddot{\theta} + 2 \dot{r} \dot{\theta} = 0
$$

Note that the angular momentum is $h = r^2\dot{\theta}$. Taking the derivative

$$
\frac{d}{dt}(r^2\dot{\theta}) = 2r\dot{r}\dot{\theta} + r^2 \ddot{\theta}
$$

Multiplyin by $\frac{1}{r}$ gets us to our original equation. Thus, we can re-write the equation as

$$
r\ddot{\theta} + 2 \dot{r}\dot{\theta} = \frac{1}{r}\frac{d}{dt}(r^2\dot{\theta})
$$
From our equations of motion, we know that the left hand side is zero, thus
$$
r^{2}\dot{\theta} = \text{constant}
$$

to satisfy this equation. This means our angular momentum is constant which leads to the consequence that the motion is confined to one plane.
