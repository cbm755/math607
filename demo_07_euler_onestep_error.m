% A demonstration of forward Euler code
%
% Solve:  u' = a*u,  u(0) = 1;

a = 2;
f = @(t,u)  a*u;
u0 = 1;

Tf = 1.2;
k = 0.2;  % desired time step
numsteps = ceil(Tf / k)  % now adjust to have integer steps
k = Tf / numsteps        % modified time step

v = u0;

figure(1); clf;
plot(0, u0, 'ko');
hold on;
tt = linspace(0, Tf, 1000);
lw = 'linewidth';
plot(tt, exp(a*tt), 'k-', lw, 3);
xlabel('t'); ylabel('u'); grid on
yl = ylim();
pause

for n = 1:numsteps
  t = k*(n-1);
  %vnew = v + k*f(t, v);
  rhs = f(t, v);

  % plot the exact solution from this point
  if (n > 1)
    tt = linspace(t-0.2*k, t+1.1*k, 200);
    plot(tt, v*exp(a*(tt-t)), '-', 'color', 0.8*rand(3,1), lw, 2)
    ylim(yl)
    pause
  end

  vnew = v + k*rhs;
  plot([t t+k], [v vnew], 'r*-', lw, 2)
  pause
  v = vnew;
end

