close all;
clear;
clc;

% path for all the data files
addpath(genpath('./3shell_head_model'));

% dipole locations:
% (-2, 2, 2.8284), (2, -2, 2.8284)
% (-2, -2, -2.8284), (2, 2, -2.8284)
% This is also the order of the values in grad_matrix
n_dipoles = 4;
n_electrodes = 6;
n_pairs = 12;   % skipping Pair 9 and use Pair 13 instead
max_pair = 13;
g_axes = {'dx', 'dy', 'dz'};
z_lvl = {'2_8284', '-2_8284'};


grad_matrix = nan(max_pair, n_dipoles*3);
%size(grad_matrix)
for pair = 1:max_pair,
    if pair == 9,
        continue;
    end
    for z = 1:length(z_lvl),
        for axe = 1:3,
            % fname in format: Pair1_dx_z=2_8284.txt
            a = csvread(sprintf('Pair%d_%s_z=%s.txt', pair, g_axes{axe}, z_lvl{z}), 9);
            grad_matrix(pair, 6*(z-1)+axe) = a(1, 3);       % (-2, 2, 2.8284) | (-2, -2, -2.8284)
            grad_matrix(pair, 6*(z-1)+axe+3) = a(end, 3);   % (2, -2, 2.8284) | (2, 2, -2.8284)
        end
    end
end
grad_matrix = grad_matrix(all(~isnan(grad_matrix),2),:);

%% read the data from eeglab
fname = 'eeglab_data_epochs_avgERP_pos1.txt';
fid = fopen(fname);
header_str = repmat('%s ', 1, 33);
data_str = repmat('%f ', 1, 33);
headers = textscan(fid, header_str, 1);
datas = textscan(fid, data_str);
fclose(fid);
datas(2:end) = cellfun(@(s) s./1000, datas(2:end), 'UniformOutput', false); % convert from mV to V.

time_vec = datas{1};    % first column is the time vector
electrodes = {'Fc1', 'Fc2', 'Cp1', 'Cp2', 'C3', 'C4'};
e_cols = nan(n_electrodes, 1);
for i=1:n_electrodes,
    e_cols(i) = find(cellfun(@(s) strcmpi(s, electrodes{i}), headers));
end

pairs = {'Fc1', 'Fc2';
         'Fc1', 'Cp1';
         'Fc1', 'Cp2';
         'Fc1', 'C3';
         'Fc1', 'C4';
         'Fc2', 'Cp1';
         'Fc2', 'Cp2';
         'Fc2', 'C3';
         'Cp1', 'Cp2';
         'Cp1', 'C3';
         'Cp1', 'C4';
         'C3', 'C4';
         };
pair_data = nan(length(time_vec), rows(pairs));
% make the pair_data
for pair = 1:n_pairs,
    p1 = pairs{pair, 1};
    p2 = pairs{pair, 2};
    col_p1 = e_cols(find(strcmpi(p1, electrodes)));
    col_p2 = e_cols(find(strcmpi(p2, electrodes)));
    pair_data(:, pair) = datas{col_p1} - datas{col_p2};
end
pair_data = pair_data./1000;    % conver from mV to V.

% solve the equation at each time point for dipole vectors
dipole_vec = nan(3*n_dipoles, rows(time_vec));
for t=1:rows(time_vec),
    dipole_vec(:,t) = inv(grad_matrix)*pair_data(t,:).';
end
dipole_vec = dipole_vec; % mA*cm

% 3d plot the vectors
% Make th sphere first
[sx, sy, sz] = sphere(128);
R = 8;  % raidus of brain=8cm;
dipole_loc_x = [-2; 2; -2; 2];
dipole_loc_y = [2; -2; -2; 2];
dipole_loc_z = [2.8284; 2.8284; -2.8284; -2.8284];

% make movie for the dipole moments
h = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
aviobj = avifile('movie1.avi', 'compression', 'None');
%h = figure;
for t=1:rows(time_vec),
    subplot(2,1,1);
    multiwaveplot(time_vec, 1:12, pair_data.');
    xlabel('Time from stimulus (ms)');
    ylabel('Electrode pair');
    hold on;
    line([time_vec(t),time_vec(t)],[0,12]);

    subplot(2,1,2);
    hsphere = surfl(sx.*R, sy.*R, sz.*R);
    set(hsphere, 'FaceAlpha', 0.5);
    shading interp;
    hold on;
    quiver3(dipole_loc_x, dipole_loc_y, dipole_loc_z,...
            dipole_vec([1,4,7,10],t), dipole_vec([2,5,8,11],t), dipole_vec([3,6,9,12],t));
    axis([-10 10 -10 10 -10 10]);
    xlabel('x (A*cm)'); ylabel('y (A*cm)'); zlabel('z (A*cm)');
    axesHandles = findobj(get(h, 'Children'), 'flat', 'Type', 'axes');
    axis(axesHandles, 'square');
    M(t) = getframe(h);
    aviobj = addframe(aviobj, M(t));
    clf('reset');
end
aviobj = close(aviobj);
% movie(gcf, M, 1, 5, [0 0 1 1]);
