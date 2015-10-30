%% A multistep method that is consistent but unstable
% and thus doesn't converge.  Demo explores different starting
% values as the method is not self starting.  The only way to get
% a bounded solution is to solve u'=0 and use the first step as 0.
% Even 1e-15 as first-step will lead to blow-up!

%% choose a problem
lambda = 2;
f = @(t,u) lambda*u;   u0 = 1;
uex = @(t) u0*exp(lambda*t);

%f = @(t,u) 0;   u0 = 0;
%uex = @(t) zeros(size(t));

Tf = 1;
k = 0.01;  % desired time step
numsteps = ceil(Tf / k)  % now adjust to have integer steps
k = Tf / numsteps        % modified time step

Hf = figure(1); clf;
hold on;
set(get(Hf, 'children'), 'fontsize', 16);
ms = 'markersize';


plot(0, u0, 'ko', ms, 12);
tt = linspace(0, Tf, 1000);
plot(tt, uex(tt), 'k-');  % exact solution
grid on; xlabel('t'); ylabel('u');

%% Initial condition
vold = u0;

%% this multistep method is not self starting
% try "k", compare to behaviour with 0
%v = 1e-15
%v = k
% try forward Euler
%v = vold + k*f(0,v);
% or use the exact soln
v = exp(lambda*k);


plot(k, v, 'b.', ms, 20)

% start at t_2 (because we used above to get t_1 soln)
for n = 2:numsteps
  t = k*(n-1);
  vnew = 3*v - 2*vold - k*f(t-k, vold);

  % here's another unstable method:
  %vnew = -4*v + 5*vold + k*( 4*f(t, v) + 2*f(t-k, vold) );

  plot(t+k, vnew, 'r.', ms, 20)
  %ylim([-1 1])
  drawnow
  pause

  vold = v;
  v = vnew;
end

