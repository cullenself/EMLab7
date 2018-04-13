%% Lab 7
% Cullen Self

%% Variables
close all; clear; clc;
g = 9.81; % m/s^2

%% Calibration of Load Cell
cal = cal_load('LoadCellCalibration.xlsx','CalData', g);

%% Leading Edge
process_shake('leadingedge.csv',cal,'lead');
process_shake('trailingedge.csv',cal,'trail');