% order of accuracy study for leap frog solution of
%   wave eq.  u_tt = u_xx, u(-1) = u(1) = 0.

% Compute solution for various grid sizes:
figure(1)
hh = []; kk = []; uu = [];
for logh = 8:-1:1
  h = 2^(-logh);
  %x = (-1+h:h:1-h)';
  x = (-1+h:h:1)';    % PERIODIC BCs
  k = .5*h;  % try switch to 1.02*h!
  uold = exp(-50*x.^2) + .3*exp(-20*(x-.2).^2);
  u = exp(-50*(x+k).^2) + .3*exp(-20*(x-.2-k).^2);
  % note exact initial value at t=k  (in general, use
  % forward Euler or something else).
  L = length(x);
  a = (2-2*k^2/h^2); b = k^2/h^2;
  main = a*sparse(ones(L,1));
  off  = b*sparse(ones(L-1,1));
  A = diag(main) + diag(off,1) + diag(off,-1);
  A(end,1) = b; A(1,end) = b;                   % PERIODIC BCs
  tmax = 2;
  nsteps = tmax/k;
  hold off, shg
  plt = plot(x,uold,'linewidth',4);
  axis([-1 1 -2 2]), grid;
  disp('paused'); pause
  for step = 2:nsteps
    unew = A*u - uold;                          % leap frog
    uold = u; u = unew;
    set(plt,'ydata',u)
    drawnow
  end
  hh = [hh; h]; kk = [kk; k]; uu = [uu; u(x==0)];
  %pause
end

% Plot deviations of u(x=0,t=2) from finest-grid value:
figure(2); clf;
I = 3:length(kk);
loglog(kk(I),10*kk(I).^2,'--r'), grid on
text(.03,.004,'k^2','fontsize',24,'color','r')
axis([.01 .3 4e-4 4]), grid on, hold on
loglog(kk(I),abs(uu(I)-uu(1)),'.-k','markersize',24)
xlabel('time step size k','fontsize',20)
ylabel('error at  t=0.1','fontsize',20)


figure(3); clf;
I = 3:length(hh);
loglog(hh(I),10*hh(I).^2,'--r'), grid on
text(.03,.004,'h^2','fontsize',24,'color','r')
axis([.01 .3 4e-4 4]), grid on, hold on
loglog(hh(I),abs(uu(I)-uu(1)),'.-k','markersize',24)
xlabel('space step h','fontsize',20)
ylabel('error at  t=0.1','fontsize',20)

