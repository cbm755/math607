%% Follows the example from class...

x1d = [0:0.5:1];
y1d = [2:0.5:3.5];

[x,y] = meshgrid(x1d, y1d)

% stretch out the meshgrid
xx = x(:)
yy = y(:)


h = x1d(2)-x1d(1);
N = length(x1d);
e = ones(N,1);
Dxx1 = spdiags([e  -2*e  e], [-1 0 1], N, N);
%L1d(1, end) = 1;  L1d(end, 1) = 1;  % periodic BCs
Dxx1 = 1/h^2 * Dxx1;
Ix1 = speye(size(Dxx1));

full(Dxx1)*h^2
full(Ix1)


h = y1d(2)-y1d(1);
N = length(y1d);
e = ones(N,1);
Dyy1 = spdiags([e  -2*e  e], [-1 0 1], N, N);
%L1d(1, end) = 1;  L1d(end, 1) = 1;  % periodic BCs
Dyy1 = 1/h^2 * Dyy1;
Iy1 = speye(size(Dyy1));

full(Dyy1)*h^2
full(Iy1)

% so now we have 2 1D matrices

% "Magic" kronecker product
Dyy = kron(Ix1, Dyy1);
Dxx = kron(Dxx1, Iy1);

% look at these
full(Dxx)
full(Dyy)

L = Dxx + Dyy;
