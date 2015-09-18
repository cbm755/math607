%% Run the examples from the notes:
% Uses lagrange.m and lagrange_poly.m (downloadable from course
% materials site)

lagrange([1 2 3], [2 4 8])

pause

lagrange([1 1.2 1.3 1.4], [3 3.5 3 0])

pause


%% Show if you put binary data, you get the L_{n,k} back

figure(1);
lagrange([1 2 3 4], [1 0 0 0])
title('L_{3,0}(x)')

figure(2);
lagrange([1 2 3 4], [0 1 0 0])
title('L_{3,1}(x)')

figure(3);
lagrange([1 2 3 4], [0 0 1 0])
title('L_{3,2}(x)')

figure(4);
lagrange([1 2 3 4], [0 0 0 1])
title('L_{3,3}(x)')
