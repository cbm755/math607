Numerical Methods for DEs: Topic 06: Intro to Finite Differences
================================================================

References: LeVeque 2007, Finite Difference Methods for ODE and PDE.
Particularly Chapters 1, 2, and 9.

Others: Morton and Mayers, Suli and Mayers.  Many specialized
textbooks.


Finite Differences
==================

Very general technique for differential equations, based on
approximating functions on a grid and replacing *derivatives* with
*differences*.

Example: definition of derivative.  Drop limit, take $h$ finite.

Somehow, everything we want to talk about is already present in this
example:

  * continuous --> discrete
  * differential --> algebraic
  * accuracy (Taylor series analysis, effect of terms dropped?)
  * division by small $h$
  * computational issues: want more accuracy?  use small $h$, more
    points, more work.


Approximating functions on a grid
---------------------------------

Notation: replace function $u(x)$ with some discrete $U_j$, $j = 0,
\ldots m$.  $U_j \approx u(x_j)$ on a discrete set of points $x_j$.

I reserve the right to also use both $u_j = U_j$ and to change index
variables at will ;-)

For multidimensional (e.g., time dep.) problem: $U_j^n \approx u(x_j, t_n)$.


A side note on interpolation
----------------------------

How to derive finite difference rules like the example?  One approach:
fit a polynomial $ax^2 + bx + c$ through the data, the differentiate
that polynomial.

Fitting such a polynomial is *interpolation*.  The monomial basis is
often a poor choice [sketch motivation], instead look at the "cardinal
polynomial":

  $$L_{m,j}(x) = L_j(x) := \frac{(x-x_0)\cdots(x-x_{j-1})(x-x_{j+1})\cdots(x-x_m)}
  {(x_j-x_0)\cdots(x_j-x_{j-1})(x_j-x_{j+1})\cdots(x_j-x_m)},$$

These are like the "$[0; 1; 0; 0]$" vectors: zero at all grid points
except $x_j$.

Polynomial interpolant of degree $m$:

  $$p(x) := \sum_{j=0}^m u_j L_j(x)$$

Very nice mathematical theory here---we've seen a bit of it---$!\exists$, etc.
Also useful in practice.


Analysis of the first-derivative
--------------------------------

When doing quadrature, we could do (rough) error analysis based on the error
formula for interpolant.  Can we do so here?

[Example: no, at least not in the most obvious way...]


Second derivative
-----------------

The derivative of the derivative: use backward difference of the
forward difference.

  $$ u_{xx}(x_j) \approx \frac{u_{j+1} - 2u_j + u_{j-1}}{h^2} $$

or we can say more with a few more symbols:

  $$ u_{xx}(x_j) = \frac{u_{j+1} - 2u_j + u_{j-1}}{h^2} + O(h^2) $$

This will be our "work-horse" method/example.

Note: **second-order accurate**: replace $h$ with $h/2$, error should
divide by four (for smooth enough function).


As a matrix
-----------

Suppose $x$ on interval $[a, b]$ and end values are $u(a) = u_0 =
\alpha$ and $u(b) = u_{m+1} = \beta$.  Applying the "1 -2 1" rule at
each point gives:

         u_{xx} \approx

               |-2    1              |  | u_1 |     | alpha/h^2 |
               | 1   -2    1         |  | u_2 |	    |     0     |
               |   .    .    .       |  |  .  |	    |     .     |
         1/h^2 |     .    .    .     |  |  .  |  +  |     .     |
               |       .    .    .   |  |  .  |	    |     .     |
               |         1   -2    1 |  |     |	    |     0     |
               |              1   -2 |  | u_m |	    | beta/h^2  |

(other ways to view this, e.g., as a rectangular matrix).

   -------------------------------------------------------
   Evaluating a differential operator on a scalar function
   is approximated by a matrix multiplying a vector.
   -------------------------------------------------------

   -------------------------------
   Calculus becomes linear algebra
   -------------------------------



Heat/Diffusion Equation
=======================

(All with initial conditions and boundary conditions as appropriate.)

Our primary example problem:  $u_t = u_{xx}$

Or with a forcing:  $u_t = \kappa u_{xx} + f$

Or the steady problem:  $u_{xx} = f$  (different $f$)

Example:

               |-2    1              |  | u_1 |     | f_1 - alpha/h^2 |
               | 1   -2    1         |  | u_2 |	    | f_2             |
               |   .    .    .       |  |  .  |	    |  .              |
         1/h^2 |     .    .    .     |  |  .  |  =  |  .              |
               |       .    .    .   |  |  .  |	    |  .              |
               |         1   -2    1 |  |     |	    | f_{m-1}         |
               |              1   -2 |  | u_m |	    | f_m -  beta/h^2 |

[discuss boundary conditions here].  That is

  $$ A U = F, $$

for vectors $U$ and $F$.  $U$ is unknown, $F$ is the data (here
RHS and boundary conditions).


Analysis of finite differences
==============================

Our "1 -2 1" rule was $O(h^2)$ accurate for evaluating the 2nd
derivative.  Will it still be so when $U$ is unknown, as in $A U = F$?
(Can think of this as an inverse problem.)

Need three concepts: *consistency*, *stability* and *convergence*.



Local truncation error
----------------------

Substitute the true solution of the PDE into the discrete problem.
Discrepancy is the *local truncation error (LTE)*.

symbol: $\tau$

Express LTE in "big Oh" notation in $h$.  (Exact solution unknown,
assumed smooth).

**Example**: steady state.

True solution $u(x)$, sub in:

  $$ \tau_j = \frac{1}{h^2} \left(u(x_{j-1}) - 2u(x_j) + u(x_{j+1})\right) - f(x_j) $$

Now Taylor expand each, and use the PDE:

  $$ \tau_j = \frac{1}{12} h^2 u''''(x_j) + O(h^4) $$

Thus $\tau_j = O(h^2)$ (if smooth enough)


Consistency
-----------

LTE to zero as $h \to 0$.


Convergence
-----------

Define $\hat{U} = [u(x_0); u(x_1); ... u(x_m)]$, exact solution
restricted to grid.

Global error: difference $E = U - \hat{U}$

Convergence: global error $E \to 0$ as $h \to 0$.

$LTE \to 0$ implies $E \to 0$?  No, often not.  The DE couples the LTE
together.  We need some notion that the error we make on each piece of
LTE does not grow too much when "fed into" another part of the
calculation.

**Example** Continue the steady state one.  Note: $\tau = A \hat{U} - F$

So

  $$ A E = -\tau $$

In this case, relationship between global error and LTE involves
properties of the matrix.




Stability
---------

Steady state problem:

**Defn 2.1** from LeVeque: Finite diff.\ applied to linear BVP gives
$A U = F$, where each depends on $h$ the mesh width.  The method is
*stable* if exists constant $C$ (indep.\ of $h$)
  $$||(A_h)^{-1}|| \le C.$$
for sufficiently small $h$ ($h < h_0$).

Time dependent: small errors (LTE) at one time should not increase too
much as they propagate.  (More later).


Fundamental Theorem of Finite Differences
-----------------------------------------

(Maybe even "... of Numerical Analysis".)

*Consistency plus Stability implies Convergence*

Stability is the hard one, often this "theorem" needs many
restrictions for particular classes of problems and methods.  Also,
often we play with what we mean by stability for problem/method.


Example: stability for BVP in the 2-norm
----------------------------------------

If matrix is symmetric (e.g., the one above) then 2-norm is spectral
radius (maximum magnitude eigenvalue).

Inverse $A^{-1}$ is has eigenvalues $\frac{1}{\lambda}$.

So we want smallest eigenvalue of $A$ bounded away from zero as
$h \to 0$.  (note: matrix gets larger as $h$ gets smaller).

E.g., [LeVeque pg21], can show for $h = 1/(m+1)$ with zero Dirichlet
conditions,

  $$ \lambda_p = \frac{2}{h^2} (\cos p \pi h - 1), \quad p = 1, 2, \ldots, m. $$

In particular, $\lambda_1 = -\pi^2 + O(h^2)$, via---you guessed
it---Taylor.
