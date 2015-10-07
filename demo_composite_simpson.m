f = @(x) sin(x)

a = 0
b = pi
n = 2*16*8;  % even

Iexact = 2;

h = (b-a)/n;

fa = f(a);
fb = f(b);

xeven = a + h*[2:2:(n-1)];
xodd = a + h*[1:2:n];

f_odd = f(xodd);
f_even = f(xeven);

%I = h/3 * sum([fa fb 4*f(xodd) 2*f(xeven)])
I = h/2 * sum([fa fb 2*f(xodd) 2*f(xeven)])

err = I - Iexact