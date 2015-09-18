%% Newton's Method demo: high-multiplicity root
% note slow (linear) convergence

f = @(x) x.^4
fp = @(x) 4*x.^3

x0 = 1
xn = x0

xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
xn = xn - f(xn) / fp(xn)
