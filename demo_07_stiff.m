%% Example of a stiff problem
% forward Euler and backward Euler applied to:
%    u' = -100(u-cos(t)) - sin(t)
% The soln is slowly varying but the numerical time-step for FE is
% effected by the -100 ("fast scale" in the problem, not in the
% solution).

Hf = figure(1); clf;
%hold on
%H = get(Hf, 'children');  set(H, 'fontsize', 16);

ms = 'markersize';
tmax = 2; exact = cos(tmax);

%% First, use forward euler
logkset = 1:10;
for logk = logkset
  k = .5^logk
  nsteps = tmax/k;
  t = 0; v = cos(t); f = -sin(t);
  for n = 1:nsteps
    t = (n-1)*k;
    %% try this:
    %f = -sin(t);
    %% then this:
    f = -sin(t) -100*(v - cos(t));
    vnew = v + k*f;
    v = vnew;
  end
  error = abs(v(end) - exact);
  loglog(k,error,'.k',ms,34)

  H = get(Hf, 'children');  set(H, 'fontsize', 16);
  %axis([.5e-3 .5 1e-7 1e11]), grid on, hold on
  hold on;
  xlabel('step size k')
  ylabel('error')
  %pause
end

%% Next, backward Euler
for logk = logkset
  k = .5^logk;
  nsteps = tmax/k;
  t = 0; v = cos(t); f = -sin(t);
  for n = 1:nsteps
    t = (n-1)*k;
    % backward Euler: vnew = v + k*f(t+k, vnew)
    %% first problem
    %vnew = v + k*(-sin(t+k));
    %% 2nd problem
    vnew = (v + k*(-sin(t+k)  + 100*cos(t+k)))  / (1+k*100);
    v = vnew;
  end
  error = abs(v(end) - exact);
  loglog(k,error,'.r', ms, 24)
  %pause
end

title('FE: black, BE: red');