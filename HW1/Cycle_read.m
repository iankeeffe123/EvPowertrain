clear all
clc
close all

%==========================================================================
% Define Case numbers that correspond to a driving cycle:
% FUDS:     1
% FHDS:     2
%==========================================================================
% Define driving cycle (case):

cycle = input('Enter the desired driving cycle (1-FUDS, 2-FHDS):\n ');

if cycle==1
    load CYC_FUDS.mat       % FUDS
    fig_title ='Federal Urban Driving Schedule (FUDS)';
    fprintf(1,'\t\tCycle: %s\n\n',fig_title) 
elseif cycle==2
    load CYC_FHDS.mat      % FHDS
    fig_title ='Federal Highway Driving Schedule (FHDS)';
    fprintf(1,'\t\tCycle: %s\n\n',fig_title)
end

% Convert Data
t = cyc_mph(:,1);           % Time [s]
Vmph = cyc_mph(:,2);        % Velocity [mph]
V = Vmph.*(1609/3600);      % Velocity [m/s]

% Plot cycle
figure('color',[1 1 1])
h = plot(t,V);
grid
xlabel('Time (s)')
ylabel('Velocity (m/s)')
set(h,'linewidth',2)
title(fig_title)

