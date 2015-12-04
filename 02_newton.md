Lecture 02: Root Finding
========================

Part of "Numerical Methods for Differential Equations", Colin
Macdonald, <cbm@math.ubc.ca>.


Rooting Finding
===============

Iterative techniques for solving $f(x) = 0$ for $x$.

*Bisection*: start with an interval $[a, b]$ bracketing the root.
Evaluate the midpoint.  Replace one end, maintaining a root bracket.
Linear convergence.  Slow but **robust**. Error bound is defined by
$|x_{n}-{x}^*|<(b-a)/{2}^n$.

*Fixed-point iteration*: A number $p$ is a **fixed point** for a given 
function g if $g(p)=p$. so given a root-finding problem $f(p)=0$,we can
define function $g$ with a fixed point at $p$ in a number of ways, for 
example, as $g(x)=x-f(x)$ or as $g(x)=x+3f(x)$. Conversey, if the function
$g$ has a fixed point at $p$, then the function defined by $f(x)=x-g(x)$
has a zero at $p$.

*Newton's Method*: $x_{k+1} = x_k - f(x_k) / f'(x_k)$.  Faster,
quadratic convergence (number of correct decimals places doubles each
iteration).when $|p_{n}-p_{n-1}|<e$ or $|f(p_{n})|<e$, we can stop the
the iterations.

*Secant method*: Newton's method is an extremly powerful technique, but it
has a major weekness:the need to know the value of the derivative of $f$ at
each approximation. Frequently, $f(x)'$ is far more arithmetic operation to
calculate than $f(x)$. We introduce the **secant method**. 

  $$ p_{n}=p_{n-1}-f(p_{n-1})(p_{n-1}-p_{n-2})/(f(p_{n-1})-f(p_{n-2})) $$.

Downsides of Newton's Method: need derivative info, and additional
smoothness.  Convergence usually not guaranteed unless "sufficiently
close": not **robust**.



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



