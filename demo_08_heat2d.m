% Backward Euler for  u_t = u_xx + u_yy on unit square
%    with periodic boundary data
%
%    xx, yy, uu represent data on a 2D mesh.
%
%    x, y, u represent the same data stretched to 1D vectors,
%            since that's what's needed to do linear algebra.

% Grid and initial condition in the form of a plus sign:
J = 60;
h = 1/J;
s = (h:h:1)';
%k = 0.2*h^2;
k = 0.1*h;
[xx,yy] = meshgrid(s,s);
x = xx(:); y = yy(:);
u = double( ...
    (abs(x-.5)<.4 & abs(y-.5)<.07) | (abs(x-.5)<.07 & abs(y-.5)<.4));

% The matrix L in 1D:
N = length(s);  e = ones(N,1);
L1d = spdiags([e  -2*e  e], [-1 0 1], N, N);
%L1d(1, end) = 1;  L1d(end, 1) = 1;  % periodic BCs
L1d = 1/h^2 * L1d;
I1d = speye(size(L1d));

L = kron(I1d, L1d) + kron(L1d, I1d);    % 2D Laplacian <- Magic!
I = speye(size(L));

figure(1); clf;
spy(L)
disp('paused'); pause

% Time-stepping:
Tf = 4;
% adjust either final time or time-step to have integer steps
numsteps = ceil(Tf / k);
%k = Tf / numsteps
Tf = k*numsteps;

A = I - k*L;

t =0
for n = 1:numsteps
  uu = reshape(u,size(xx));
  surfl(xx,yy,uu), colormap(hot)
  title(sprintf('t = %6.4f',t), 'fontsize',20)
  axis([0 1 0 1 0 2]), view(-20,30)
  drawnow()
  if 1 %(n==1)
    disp('paused'); pause
  end
  t = n*k;
  u = A \ u;
end

