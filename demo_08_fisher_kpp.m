% explicit solution of Fisher-KPP equation
% u_t = eps*u_xx + u - u^2,  u(0)=1, u(10)=0   (nonlinear).

% Grid and initial data:
eps = 0.01;
h = .05;
k = .4*h^2/eps;                 % try .4 -> .51
x = (0+h:h:20-h)';
% initial data: wave front
u = exp(-2*x) + 0.1*(abs(x-3)<1);

% Set-up for plot:
figure(1); clf;
plt = plot(x, u, 'linewidth', 4);
axis([0 20 -.02 1.1]), grid
hold on;

% Sparse matrix for finite difference operation:
N = length(x);
a = -2/h^2;
b = 1/h^2;
main = a*sparse(ones(N,1));
off  = b*sparse(ones(N-1,1));
L = diag(main) + diag(off,1) + diag(off,-1);

% vector for boundary conditions
bc = b*[1; zeros(N-1,1)];


Tf = 42;
numsteps = ceil(Tf/k);
%k = Tf/numsteps
Tf = k*numsteps;

disp('press <enter> to start'); pause
% Time-stepping:
for n=1:numsteps
  t = n*k;
  unew = u + k*(  eps*(L*u + bc) + (u-u.^2)  );
  u = unew;
  set(plt, 'ydata', u)
  drawnow
  %pause
end



