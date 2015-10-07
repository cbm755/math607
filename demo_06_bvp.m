%% solve a BVP on x \in [0, 1]
% Resulting error is 2nd-order (numerical evidence).
% But this does not follow directly from 2nd-order LTE.

h = 1/8;

x = (h:h:(1-h))';   % interior pts

m = length(x);

e = ones(1, m)';
Dxx = spdiags([e -2*e e], [-1 0 1], m, m);

%full(Dxx)

Dxx = Dxx/h^2;

% RHS function
%f = exp(x) .* sin(4*pi*x);
f = sin(2*pi*x);

% exact soln for comparing/plotting
uex = -1/(4*pi^2)*sin(2*pi*x);
xfine = linspace(0, 1, 512);
uexfine = -1/(4*pi^2)*sin(2*pi*xfine);

% solve Dxx*U = F for U
u = Dxx \ f;

figure(1); clf;
plot(xfine, uexfine, 'r-', 'linewidth', 3);
hold on;
plot(x, uex, 'ro', 'linewidth', 2);
plot(x, u, 'kx-', 'linewidth', 2);

xlabel('x'); ylabel('u');
legend('exact soln', 'sampled exact', 'num soln');


err = max(abs(u - uex))


figure(2); clf;
plot(x, u - uex, 'kx', 'linewidth', 3);
xlabel('x'); ylabel('error');
legend('error vector')
grid on
