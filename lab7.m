%% Lab 7
% Cullen Self

%% Variables
close all; clear; clc;
g = 9.81; % m/s^2

%% Calibration of Load Cell
% Read Data
cal = xlsread('LoadCellCalibration.xlsx','CalData');
mass = cal(:,1)/1000; % kilograms
v_out = cal(:,2); % Volts
v_out_std = cal(:,3); % Volts

% Calculate Forces and Response Curve
force = mass*g; % Newtons
[calibration,S] = polyfit(v_out,force,1);
x = linspace(min(v_out),max(v_out),1000);
y = calibration(1).*x+calibration(2);
r2 = 1 - S.normr^2/sum((mean(force)-force).^2);

% Output
fprintf('The Load Cell Response is: F (N) = %.3f V (Volts) + %.3f, with R2 = %.4f\n',calibration(1),calibration(2),r2);
figure();
errorbar(v_out,force,v_out_std,'horizontal','*');
hold on;
plot(x,y);
xlabel('V_{out} (Volts)');
ylabel('F (Newtons)');
title('Load Cell Calibration');
legend('Observed Data','Calibration Curve','Location','northwest');
grid on;
print('Calibration','-dpng');

%% Leading Edge
process_shake('leadingedge.csv',calibration,'lead');
process_shake('trailingedge.csv',calibration,'trail');