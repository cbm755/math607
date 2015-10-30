%  2D advection
%    xx, yy, uu represent data on a 2D mesh.
%
%    x, y, u represent the same data stretched to 1D vectors,
%            since that's what's needed to do linear algebra.

% Grid and initial condition in the form of a plus sign:
J = 140;
h = 1/J;
s = (h:h:1)';

[xx,yy] = meshgrid(s,s);
x = xx(:); y = yy(:);
u = exp(-80*((x-0.7).^2 + (y-0.5).^2));
%u = double( ...
%    (abs(x-.5)<.4 & abs(y-.5)<.07) | (abs(x-.5)<.07 & abs(y-.5)<.4));

% Sparse matrices for 1D finite differences
N = length(s);  e = ones(N,1);
D1b = spdiags([-e  e], [-1 0], N, N);
D1f = spdiags([-e  e], [0  1], N, N);
D1b(1,end) = -1;
D1f(end,1) = 1;
D1b = 1/h * D1b;
D1f = 1/h * D1f;
I1 = speye(size(D1b));

% Kronecker magic: see also demo_08_heat2d.m
Dyb = kron(I1, D1b);
Dyf = kron(I1, D1f);
Dxb = kron(D1b, I1);
Dxf = kron(D1f, I1);

%% velocity field
%wx = ones(size(x));
%wy = 0.5*ones(size(y));
% more interesting field, round and round we go
[th,r] = cart2pol(x-0.5,y-0.5);
wx = -r.*sin(th);
wy = r.*cos(th);


%figure(2); clf
%pcolor(xx,yy,reshape(wy,size(xx)));
%figure(3); clf
%pcolor(xx,yy,reshape(wx,size(xx)));
figure(1); clf

% Time-stepping:
maxspeed = max(max(abs(wx)),max(abs(wy)));
k = 0.5*1/maxspeed*h;
Tf = 2*pi;
% adjust either final time or time-step to have integer steps
numsteps = ceil(Tf / k);
%k = Tf / numsteps
Tf = k*numsteps;

for n = 1:numsteps
  n = n + 1;
  t = n*k;
  u = u - k*( ...   % note minus sign (from PDE)
      wx.*((wx >= 0).*(Dxb*u) + (wx < 0).*(Dxf*u)) + ...
      wy.*((wy >= 0).*(Dyb*u) + (wy < 0).*(Dyf*u)) ...
      );
  if mod(n,10) == 0
    uu = reshape(u,size(xx));
    surf(xx,yy,uu); shading interp; camlight left;
    %pcolor(xx,yy,uu)
    title(sprintf('t = %6.4f',t), 'fontsize',20)
    xlabel('x'); ylabel('y');
    drawnow();
  end
end

