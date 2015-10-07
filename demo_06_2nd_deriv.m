%% forward problem: calculate u_xx given u
% LTE says 2nd-order and we see that.

h = 2^-7;

x = (h:h:(1-h))';   % interior pts

m = length(x)

e = ones(1, m)';
Dxx = spdiags([e -2*e e], [-1 0 1], m, m);

%full(Dxx)

Dxx = Dxx/h^2;

% know u, want u_xx
u = sin(2*pi*x);

uxx_Exact = -4*pi^2*sin(2*pi*x);

uxx = Dxx * u;

% max-norm error:
err = max(abs(uxx - uxx_Exact))
