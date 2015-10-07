%% this centered scheme is consistent
% but something goes wrong depending on if I take odd/even number
% of points...

h = 1/30

x = (0+h:h:1-h)';  % note endpts left out

N = length(x)

e = ones(N,1);
Dx = spdiags([-e  0*e  e], [-1 0 1], N, N);
Dx = Dx/(2*h);

f = sin(2*pi*x);
uexact = -1/(2*pi)*cos(2*pi*x);
u = Dx \ f;


lw = 'linewidth';
figure(1); clf;
plot(x, u, lw, 2);
hold on;
plot(x, uexact, 'r-', lw, 2);
xlabel('x'); ylabel('u')
legend('num soln', 'exact soln')
