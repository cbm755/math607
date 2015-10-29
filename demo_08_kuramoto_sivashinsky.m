% Kuramoto-Sivashinsky equation
%
%         u_t = -u_xx - u_xxxx - (u^2/2)_x
%
% on [-16pi,16pi] with periodic boundary conditions.
% Long waves grow because of -u_xx;
% short waves decay because of -u_xxxx;
% the nonlinear term transfers energy from long to short.

% Grid, initial data, and plotting setup:
N = 400;
h = 32*pi/N;
x = -16*pi + (1:N)'*h;
u = cos(x/16).*(1+sin(x/16));

Hf = figure(1); clf; hold on;
Hc = get(Hf, 'children');  set(Hc, 'fontsize', 16);
plt = plot(x,u,'linewidth',4);
axis([-16*pi 16*pi -4 4]);
grid on;
xlabel('x'); ylabel('u');


% Laplacian with periodic BCs
N = length(x);  e = ones(N,1);
L = spdiags([e  -2*e  e], [-1 0 1], N, N);
L(1,end) = 1;  L(end,1) = 1;
L = 1/h^2 * L;

% Biharmonic
H = L^2;

% First derivative (centered differences)
D = spdiags([-e  e], [-1  1], N, N);
D(1,end) = -1;  D(end,1) = 1;
D = 1/(2*h) * D;

I = speye(size(L));

k = 0.2;  % step size

A = I + k*H + k*L;  % build LHS matrix


% Time-stepping:
disp('press <enter> to start'), pause
t = 0;
while 1
  % IMEX Euler: solve A*unew = u - k*(D*(u.^2/2));
  unew = A\(u - k*(D*(u.^2/2)));
  % explicit euler:
  %unew = u - k*(L*u) - k*(H*u) - k*(D*(u.^2/2));
  u = unew;
  t = t + k;

  set(plt, 'ydata', u)
  title(['t = ' num2str(t)])
  drawnow
end



