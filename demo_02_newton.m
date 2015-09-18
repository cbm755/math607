%% Newton's Method demo
% this one just "by-hand", should use loops, stopping criteria etc...

% f and f'
f = @(x) x.^5 - 3*x + 1/2
fp = @(x) 5*x.^4 - 3;

% initial guess
x0 = 0

% set xn to initial guess
xn = x0

% see more digits
format long g

% Newton step
xnew = xn - f(xn) / fp(xn);  xn = xnew

% then repeat a few times
xnew = xn - f(xn) / fp(xn);  xn = xnew
xnew = xn - f(xn) / fp(xn);  xn = xnew
xnew = xn - f(xn) / fp(xn);  xn = xnew
xnew = xn - f(xn) / fp(xn);  xn = xnew

% check f(xn) is indeed small
f(xn)


% try a different initial guess and make a plot
xx = linspace(-2,7);
clf;
plot(xx,f(xx))
hold on
grid on

x0 = 0.8
xn = x0

% note this on jumps around quite a bit before settling down and
% converging
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')
xn = xn - f(xn) / fp(xn),  plot(xn,f(xn),'ro')

