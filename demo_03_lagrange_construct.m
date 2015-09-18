delay = 3;
lw = 'linewidth';
ms = 'markersize';
figure(1); clf;
figure(2); clf;



% big outer loop
for ii=1:20
set(0, 'CurrentFigure', 1); clf;
set(0, 'CurrentFigure', 2); clf;
%pause(delay)

%% define a function and a fine plotting grid
fcn = @(x) exp(x) + x.^2;
xx = linspace(-2, 2, 512);
ff = fcn(xx);

set(0, 'CurrentFigure', 1); clf;
plot(xx, ff, 'r-', lw, 4);
legend('function f');
xlabel('x');
hold on;
pause(delay);


%% choose some nodes
n = round(rand*10) + 2;
x = cumsum(randn(n,1) + 2);
x = sort(x);
x = (x - min(x)) / (max(x) - min(x));
x = 4*x - 2;

f = fcn(x);
set(0, 'CurrentFigure', 1);
plot(x, f, 'bo', lw, 2, ms, 12);
legend('function f', 'data');
pause(delay);

%% now plot the interp
p = lagrange_poly(x, f);
pp = polyval(p, xx);
plot(xx, pp, 'b--', lw, 2);
legend('function f', 'data', 'interp');
pause(delay);


%% now step through it one piece at a time.
pp2 = zeros(size(xx));
h = plot(xx, pp2, 'k-', lw, 2);
legend('function f', 'data', 'interp', 'construct');
for k=1:n
  g = zeros(size(x));
  g(k) = 1;
  p = lagrange_poly(x, g);
  pp = polyval(p, xx);
  set(0, 'CurrentFigure', 2); clf;
  plot(xx, pp, 'k-', lw, 2);
  hold on;
  xlabel('x');
  plot(x, g, 'k.', lw, 2, ms, 22);
  plot(x(k), g(k), 'ro', lw,2, ms,12);
  plot(xx, zeros(size(xx)), 'k--')
  title(sprintf('Cardinal L_{%d,%d}',n,k));

  
  pp2 = pp2 + f(k)*pp;
  set(0, 'CurrentFigure', 1);
  set(h, 'yData', pp2)
  pause(delay);  
end
pause(2*delay)

end