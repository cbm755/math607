%% instability of GE with partial pivoting
% An example from Jim Wilkinson.
%  "... anyone that unlucky has already been hit by a bus."
% Error is small for n = 10, but try 25, 50 and 100.

n = 10

A = eye(n) + tril(-1*ones(n,n),-1); A(:,end) = 1;

% build b for random exact solution x.  We try to recover x from b.
x = rand(n,1);
b = A * x;


%% Matlab's backslash
x2 = A \ b;

err1 = norm(x-x2,2) / (norm(x,2) * norm(A,'fro'))


%% LU decomp, with partial pivoting
% This is what matlab does anyway.  Note err2 grows with n
[L,U,P] = lu(A);
y = L \ (P*b);
x3 = U \ y;

err2 = norm(x-x3,2) / (norm(x,2) * norm(A,'fro'))


%% LU with complete pivoting
% Not built-in to Matlab, here we use the lucp() code by
% Nick Henderson (BSD license).  err3 does not grow with n.

[Lc, Uc, Pc, Qc] = lucp(A, [], 'matrix');
y = Lc \ (Pc*b);
z = Uc \ y;
x4 = Qc*z;

err3 = norm(x-x4,2) / (norm(x,2) * norm(A,'fro'))


%% Condition number: measures how hard the problem is
% note grows only slowly with n
cond(A)
