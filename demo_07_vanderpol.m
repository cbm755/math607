% solving van der Pol equation using Matlab's ode45 and ode15s commands

C = 10;

% the ODE rhs function as an "anonymous function".  Can also be an
% separate .m file.
f = @(t,u)  [u(2); ...
             -C*(u(1)^2 - 1).*u(2) - u(1)];

U0 = [2; -0.7];  % initial condition

% try both:
[tt,YY] = ode45(f, [0 5*C+50], U0);
%[tt,YY] = ode15s(f, [0 5*C+50], U0);

u1 = YY(:,1);
u2 = YY(:,2);
figure(1); clf;
plot(tt, u1, 'k*-', 'linewidth', 2);
xlabel('time');
figure(2); clf;
plot(u1, u2, 'b-', 'linewidth', 2);
title('phase plane')
