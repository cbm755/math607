% A demonstration of forward Euler code
%
% Solve:  u' = a*u,  u(0) = 1;

a = 2;
f = @(t,u)  a*u;
u0 = 1;

Tf = 1;
k = 0.1/8;  % desired time step
numsteps = ceil(Tf / k)  % now adjust to have integer steps
k = Tf / numsteps        % modified time step

v = u0;

figure(1); clf;
ms = 'markersize';
plot(0, u0, 'ko', ms, 12);
hold on;
tt = linspace(0, Tf, 1000);
plot(tt, exp(a*tt), 'k-');  % exact solution
grid on
xlabel('t'); ylabel('u');


for n = 1:numsteps
  t = k*(n-1);
  vnew = v + k*f(t, v);

  plot(t+k, vnew, 'r.', ms, 20)
  pause

  v = vnew;
end

