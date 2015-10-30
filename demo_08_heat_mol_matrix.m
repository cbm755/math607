% explicit solution of heat eq  u_t = u_xx, u(-1)=u(1)=0.
% Method-of-lines version

% Grid and initial data:
h = .025;                    % space step
k = .4*h^2;                  % time step (try .4 -> .51!)
x = (-1+h:h:1-h)';           % grid
%x = (-1+h:h:1)';            % grid, for periodic
v = abs(x-0.2)<.3;           % initial data: square wave


figure(1); clf;
plt = plot(x,v,'k.-', 'linewidth',4);
axis([-1 1 -.01 1.01])
grid on

pause

% Sparse matrix to execute finite difference operation:
N = length(x);
a = -2/h^2;
b = 1/h^2;
main = a*sparse(ones(N,1));
off  = b*sparse(ones(N-1,1));
L = diag(main) + diag(off,1) + diag(off,-1);
%L(1,end) = b; L(end,1) = b;  %  uncomment for periodic BCs

Tf = 1;
% adjust either final time or time-step to have integer steps
numsteps = ceil(Tf / k);
%k = Tf / numsteps
Tf = k*numsteps;

% Time-stepping:
for n=1:numsteps
  vnew = v + k*(L*v);      % (why brackets here?)
  v = vnew;
  set(plt,'ydata',v)
  xlabel('x');
  ylabel('u');
  drawnow
  %pause
end

