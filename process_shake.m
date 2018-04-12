function [  ] = process_shake( fn , cal, out_prefix)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% Input
data = csvread(fn,1,0);
f = data(:,1); % Hz
V_accel = data(:,2); % m/s^2 (TODO: Check units)
V_force = data(:,3); % N
arg_accel = data(:,4); % deg
arg_force = data(:,5); % deg

%%Calculations
force = cal(1)*V_force + cal(2);
accel = V_accel/.206 * 9.81; % TODO: remove gravity?
displacement = accel./((2*pi*f).^2); %
displacement = displacement / 1e-6; % micrometer

%% Plots
% Acceleration vs Freq Plot
figure();
plot(f,accel);
xlabel('Frequency (Hz)');
ylabel('Acceleration (m/s^2)');
title('Acceleration vs Excitation Frequency');
print(strcat(out_prefix,'_acc'),'-dpng');

% Displacement vs Freq Plot
figure();
plot(f,displacement);
xlabel('Frequency (Hz)');
ylabel('Displacement ({\mu}m)');
title('Displacement vs Excitation Frequency');
print(strcat(out_prefix,'_disp'),'-dpng');

% Force vs Freq Plot
figure();
plot(f,force);
xlabel('Frequency (Hz)');
ylabel('Force (N)');
title('Excitation Force vs Excitation Frequency');
print(strcat(out_prefix,'_force'),'-dpng');

% Freq Response vs Freq Plot
figure();
plot(f,displacement./force);
xlabel('Frequency (Hz)');
ylabel('Response (s^2/kg)');
title('Frequency Response vs Excitation Frequency');
print(strcat(out_prefix,'_resp'),'-dpng');
end

