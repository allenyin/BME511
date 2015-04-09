% make the sphere with electrode locations
close all; clear; clc;
R = 8;  % radius of cortex=8cm
[x y z] = sphere(128);
h = surfl(x.*R, y.*R, z.*R);
set(h, 'FaceAlpha', 0.5);
shading interp;

THETA = [3*pi/4, pi/4, -pi/4, -3*pi/4];
PHI = [pi/4, -pi/4, pi/4, -pi/4];
r = R/2;
[dipole_X, dipole_Y, dipole_Z] = sph2cart(THETA, PHI, r);
hold on;
plot3(dipole_X, dipole_Y, dipole_Z, 'o', ...
      'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10);

xlabel('x'); ylabel('y'); zlabel('z');

fprintf('coordinates of dipoles: \n');
[dipole_X.', dipole_Y.', dipole_Z.']

%% Get the electrode locations
R_scalp = 9.2 % cm
Fc1 = R_scalp*[0.3816, 0.3806, 0.84234];
Fc2 = R_scalp*[0.3816, -0.3806, 0.84234];
Cp1 = R_scalp*[-0.38156, 0.38063, 0.84234];
Cp2 = R_scalp*[-0.38156, -0.38063, 0.84234];
C3 = R_scalp*[0, 0.7432, 0.699];
C4 = R_scalp*[0, -0.74315, 0.699];

fprintf('Fc1: (%.3f, %.3f, %.3f)\n', Fc1(1), Fc1(2), Fc1(3));
fprintf('Fc2: (%.3f, %.3f, %.3f)\n', Fc2(1), Fc2(2), Fc2(3));
fprintf('Cp1: (%.3f, %.3f, %.3f)\n', Cp1(1), Cp1(2), Cp1(3));
fprintf('Cp2: (%.3f, %.3f, %.3f)\n', Cp2(1), Cp2(2), Cp2(3));
fprintf('C3: (%.3f, %.3f, %.3f)\n', C3(1), C3(2), C3(3));
fprintf('C4: (%.3f, %.3f, %.3f)\n', C4(1), C4(2), C4(3));
