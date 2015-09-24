Lecture 02: Root Finding
========================

Part of "Numerical Methods for Differential Equations", Colin
Macdonald, <cbm@math.ubc.ca>.


Rooting Finding
===============

Iterative techniques for solving $f(x) = 0$ for $x$.

*Bisection*: start with an interval $[a, b]$ bracketing the root.
Evaluate the midpoint.  Replace one end, maintaining a root bracket.
Linear convergence.  Slow but **robust**.

*Newton's Method*: $x_{k+1} = x_k - f(x_k) / f'(x_k)$.  Faster,
quadratic convergence (number of correct decimals places doubles each
iteration).

Downsides of Newton's Method: need derivative info, and additional
smoothness.  Convergence usually not guaranteed unless "sufficiently
close": not **robust**.

Quadratic convergence of Newton's method (by Frederic Paquin-Lefebvbre)
-----------------------------------------------------------------------

Let $e_k = x_k-y$, where $y$ is a root of a smooth function $f(x)$. If we pick the initial guess $x_0$ sufficiently close to the root $y$, then the convergence is guaranteed. We look for a constant $\alpha$ such that for large $k$, the following relation between successive errors is satisfied $e_{k+1} = \lambda e_k^\alpha$. For the derivation, we recall that Newton's method is a fixed point method with iteration function being $g(x) = x - f(x)/f'(x)$. This specific function has the additional property that its derivative vanishes at the root $y$ (one can easily verify it).

\begin{equation*}
|e_{k+1}| = |x_{k+1} - y| = |g(x_k) - g(y)|
\end{equation*}

The term $g(x_k) = g(y + e_k)$ on the righthand side can be Taylor expanded up to the second derivative of $f$.

\begin{align*}
|e_{k+1}| &= |g(y) + g'(y)e_k + \frac{1}{2}g''(\xi_k)e_k^2 - g(y)| \\
&= |\frac{1}{2}g''(\xi_k)e_k^2| \\
\end{align*}

Therefore, we have that

\begin{equation*}
\lim {k \to \infty} \frac{|e_{k+1}|}{|e_k^2|} = |\frac{1}{2}g''(y)|.
\end{equation*}

The convergence will be quadratic, unless the second derivative of the fixed point function $g(x)$ vanishes at the zero (which may happen for roots with multiplicity greater than 1).

Systems
-------

$f(x) = 0$, but now $f : \mathbb{R}^n \to \mathbb{R}^n$.

This is a system of nonlinear equations.  Denote a solution as $\alpha
\in \mathbb{R}^n$.

Derivation: Taylor expansion about $x$

  $$ 0 = f(\alpha) = f(x) + J(x) (\alpha - x) + \text{h.o.t.} $$

where $J(x)$ is the Jacobian matrix...

Pretend h.o.t. are 0, so instead of $\alpha$ we find $x_{k+1}$:

  $$ 0 = f(x_k) + J(x_k) (x_{k+1} - x_k) $$

In principle, can rearrange to solve for $x_k$ but better to solve

  $$ J_k \delta = -f(x_k) $$

That is, solve "$Ax = b$".  Then update:

  $$ x_{k+1} := x_k + \delta $$



