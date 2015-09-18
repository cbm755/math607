%% Newton's Method demo: system of nonlinear equations
% Example problem using two equations, each function of x, y

f1 = @(x,y) x*y + y^2 - 2
f2 = @(x,y) x^3*y - 3*x - 1


x0 = [0; 1]
xn = x0

% our initial guess is not great
f1(0, 1)
f2(0, 1)


% form RHS
RHS = - [f1(0,1); f2(0,1)]

% Jacobian matrix (function) as worked out by
% hand (note lot of work in general!)
J = @(x,y) [y  x + 2*y; 3*x^2*y - 3  x^3]
% and evaluate at xn
MAT = J(xn(1),xn(2))

% solve: MAT*delta = RHS in Octave/Matlab:
delta = MAT \ RHS

% update using delta
xn = xn + delta

% do it again
RHS = - [f1(xn(1),xn(2)); f2(xn(1),xn(2))]
MAT = J(xn(1),xn(2))
delta = MAT \ RHS
xn = xn + delta

% ... and again
RHS = - [f1(xn(1),xn(2)); f2(xn(1),xn(2))]
MAT = J(xn(1),xn(2))
delta = MAT \ RHS
xn = xn + delta

% ... and again
RHS = - [f1(xn(1),xn(2)); f2(xn(1),xn(2))]
MAT = J(xn(1),xn(2))
delta = MAT \ RHS
xn = xn + delta

% note RHS (function value) is already small
