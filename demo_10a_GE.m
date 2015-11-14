%% Gaussian Elimination
% done "by-hand" rather than loops

%% Problem
% $Ax = b$
A = [3 -1 2; 1 2 3; 2 -2 -1]
b = [12; 11; 2]

%% Matlab
% we could just ask Matlab
x_ml = A \ b
help slash    % note it does Gaussian Elimination

% augment
B = [A b]

%% Row operators
l21 = B(2,1)/B(1,1)

B(2,:) = B(2,:) - l21*B(1,:)

l31 = B(3,1)/B(1,1)

B(3,:) = B(3,:) - l31*B(1,:)

l32 = B(3,2)/B(2,2)

B(3,:) = B(3,:) - l32*B(2,:)

%% Now we have new problem
% $Ux = c$

B


%% Backsub:

x3 = B(3,4) / B(3,3)
x2 = (B(2,4) - B(2,3)*x3) / B(2,2)
x1 = (B(1,4) - B(1,3)*x3 - B(1,2)*x2) / B(1,1)

x = [x1; x2; x3]

%% compare to matlab
x - x_ml
% exactly zero?  So probably we did almost exactly what matlab did.

%% error:
xexact = [3; 1; 2]

err = x - xexact

%% stable?
% err was small so is this stable in general? we'll come back to that.
