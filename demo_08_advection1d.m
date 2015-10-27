% explicit solution of advection eqn  u_t + a u_x, periodic BCs

% Grid and initial data:
a = 1;    % change between 1 and -1
h = .02;
k = .25*h/abs(a);
x = (-1+h:h:1)';
%v = abs(x-0.2)<.3;
v = sin(pi*x);

figure(1); clf;
plt = plot(x,v,'k.-', 'linewidth',4);
axis([-1 1 -1.01 1.01])
grid on

% Sparse matrices for finite differences
N = length(x);  e = ones(N,1);
Db = spdiags([-e  e], [-1 0], N, N);
Df = spdiags([-e  e], [0  1], N, N);
Db(1,end) = -1;   % periodic BCs
Df(end,1) = 1;
Db = 1/h * Db;
Df = 1/h * Df;

Tf = 5;
% adjust either final time or time-step to have integer steps
numsteps = ceil(Tf / k);
%k = Tf / numsteps
Tf = k*numsteps;

% Time-stepping:
for n=1:numsteps
  % Try these two first:
  %vnew = v + k*(-a*(Db*v));
  %vnew = v + k*(-a*(Df*v));
  vnew = v + k*(-a*(...
      (a > 0)*(Db*v) + (a <= 0)*(Df*v) ));
  v = vnew;
  set(plt,'ydata',v)
  drawnow
  %pause
end

