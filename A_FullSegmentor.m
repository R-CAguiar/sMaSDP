clear;

addpath('EMG');
addpath('KIN');

files_emg = dir(fullfile('EMG','*-emg.mat'));
files_kin = dir(fullfile('KIN','*-kin.mat'));

n_trials = 102;

% Width of the moving average window (filter)
window_width = 150;
% Threshold level for the signal energy
threshold = 0.009;

for i = 1:n_trials

    load(files_kin(i).name);
    load(files_emg(i).name);
    
    % Right Foot Acceleration in Forward Direction     
    rfa{i,1} = smooth(kin.data.acceleration.RightFoot(:,1));
        
    % Remove constant offset from data and normalize
    rfa{i,1} = rfa{i,1} - mean(rfa{i,1});
    rfa{i,1} = rfa{i,1}/max(rfa{i,1});
    % Calculate signal power
    signal_power = rfa{i,1}.^2;
    % filtered data
    filtered_signal_power = movmean(signal_power, window_width);
    % event detection
    event{i,1} = filtered_signal_power > threshold;
    interp_data{i,1} =  interp1(linspace(0,1, length(rfa{i,1})),...
        rfa{i,1}, linspace(0, 1, length(emg.right)))';
    rough_segments{i,1} = interp1(linspace(0,1, length(single(event{i,1}))),...
        single(event{i,1}), linspace(0, 1, length(emg.right)))';

        clearvars emg kin signal_power filtered_signal_power 
end 

save('RoughHalfTrialEstimator.mat','rough_segments');