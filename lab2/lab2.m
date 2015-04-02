close all;
clear;
clc;

% potential along the path O-E
a = csvread('pot_along_x.txt');

% potential along the circumference
b = csvread('pot_along_circ.txt');

% electric field magnitude along the path O-E
c = csvread('e_mag_along_x.txt');

% electric field magnitude along the circumference
d = csvread('e_mag_along_circ.txt');

% angular component of current density along the path O-E
e = csvread('j_ang_along_x.txt');

% normal component of current density along the circumference
f = csvread('j_norm_along_circ.txt');

analyt;


%figure;
%
%subplot(3,2,1)
%% potential along O-E:
%plot(a(:,1), a(:,2));
%ylabel('potential (mV)');
%title('Along the radius');
%
%subplot(3,2,2)
%% potential along circumference:
%plot(flipud(b(:,1)), b(:,2));
%ylabel('potential (mV)');
%title('Along the circumference');
%
%subplot(3,2,3)
%% |E| along the radius
%plot(c(:,1), c(:,2));
%ylabel('|E| (mV/cm)');
%
%subplot(3,2,4)
%% |E| along the circumference
%plot(flipud(d(:,1)), d(:,2));
%ylabel('|E| (mV/cm)');
%
%subplot(3,2,5)
%% Angular current density along the radius
%plot(e(:,1), e(:,2));
%ylabel('Jphi (uA/cm^2)');
%
%subplot(3,2,6)
%% Normal current density along the circumference
%plot(flipud(f(:,1)), f(:,2));
%ylabel('Jphi (uA/cm^2)');
%
%% run Wanda's script
%%figure;
%%analyt;
