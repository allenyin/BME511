close all;
clear;
clc;

% potential along O-E
a = csvread('pot_along_x.txt');
a_homo = csvread('homo_pot_along_x.txt');

% tangential electric field along O-E
b = csvread('eField_tan_along_x.txt');
b_homo = csvread('homo_eField_tan_along_x.txt');

% tangentail current density along O-E
c = csvread('j_tan_along_x.txt');
c_homo = csvread('homo_j_tan_along_x.txt');

% normal current density along O-C
d = csvread('j_norm_along_y.txt');
d_homo = csvread('homo_j_norm_along_y.txt');

figure;
R = 9 % 9cm

% potential along O-E
subplot(4,2,1)
plot(a_homo(:,1), a_homo(:,2));
ylabel('Potential (mV)'); grid on;
title(sprintf('Homogeneous\n (a)'));
axis([0 R -inf inf]);

subplot(4,2,2)
plot(a(:,1), a(:,2)); grid on;
title(sprintf('Inhomogeneous\n (b)'));
axis([0 R -inf inf]);

% tan field along O-E
subplot(4,2,3)
plot(b_homo(:,1), b_homo(:,2)); grid on;
ylabel('|E| (mV/cm)')
title('(c)');
axis([0 R -inf inf]);

subplot(4,2,4)
plot(b(:,1), b(:,2)); grid on;
axis([0 R -inf inf]); title('(d)');

% tan CD along O-E
subplot(4,2,5)
plot(c_homo(:,1), c_homo(:,2));
ylabel('|I| (uA/cm^2)'); grid on;
axis([0 R -inf inf]);
title('(e)');

subplot(4,2,6)
plot(c(:,1), c(:,2)); grid on;
axis([0 R -inf inf]);
title('(f)');

% nomral CD along O-C
subplot(4,2,7)
plot(d_homo(:,1), d_homo(:,2)); grid on;
ylabel('|I| (uA/cm^2)');
xlabel('Distance (cm)');
axis([0 R -inf inf]);
title('(g)');

subplot(4,2,8)
plot(d(:,1), d(:,2)); grid on;
xlabel('Distance (cm)');
axis([0 R -inf inf]);
title('(h)');



