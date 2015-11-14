%% Run Gaussian-elimination (partial pivoting) on many random matrices
% We expect to always see a small error of roughly 1e-16 to 1e-15: its
% very stable in practice, despite the warning example of Wilkinson.

n = 100;    % n x n matrix
M = 10000;  % how many matrices to try

s = sprintf('Ax = b on %d random %dx%d matrices', M, n, n);
disp(['Testing '  s  '...'])

resnorm = zeros(M,1);
tic
for i = 1:M
  A = rand(n, n);  b = rand(n, 1);  x = A \ b;
  rn = norm(b - A*x, 2) / (norm(A, 'fro') * norm(x, 2));
  resnorm(i) = rn;
end
toc

pow = log10(resnorm);
H = figure(1); clf;
hist(pow)
set(get(H, 'children'), 'fontsize', 16);
xlabel('log10 relative residual')
title(s);
