% exact because its a power of two: we're just bit shifting the exponent
1/4096;
4096*ans;
ans - 1

% but here we make a small error of size 10^-16
1/49;
49*ans;
ans - 1

% size:
2^-53
% close to "machine epsilon":
eps

% exact square roots
sqrt(1/2)
ans^2 - 1/2
sqrt(1/4)
ans^2 - 1/4

% backward stability demo
sin(0)
sin(pi)
sin(1000*pi)
sin(1e20*pi)
