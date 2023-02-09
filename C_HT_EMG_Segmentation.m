clear;

addpath('EMG');
addpath('KIN');

load('HalfTrialTimestamps.mat'); %Timestamps extracted from KIN, removing pauses and noise artifacts; 

files_emg = dir(fullfile('EMG','*-emg.mat'));
files_kin = dir(fullfile('KIN','*-kin.mat'));
n_trials = 102;

muscle_order = {'TA' 'GAST' 'VL' 'RF' 'SEM' 'BFL'};

saf_b = 1500; % Time safety margin for before trial start: 1.5 seconds
saf_e = 500; % Time safety margin for after trial start: 0.5 seconds

%% Raw signal segmentation
for i = 1:n_trials 
    load(files_emg(i).name);
    load(files_kin(i).name);
    aid_f = 1;
    aid_b = 1;

    if i < 58    
        kin_RLL = interp1(linspace(0,1, length(kin.data.position.RightFoot(:,2))),...
            kin.data.position.RightFoot(:,2), linspace(0, 1, length(emg.right)))';
    elseif i >= 58 
        kin_RLL = interp1(linspace(0,1, length(kin.data.position.RightFoot(:,1))),...
            kin.data.position.RightFoot(:,1), linspace(0, 1, length(emg.right)))';
    end
    
    acc_z_RF = interp1(linspace(0,1, length(kin.data.acceleration.RightFoot(:,3))),...
            kin.data.acceleration.RightFoot(:,3), linspace(0, 1, length(emg.right)))';
        
%     figure; plot(kin_RLL); title(files_kin(i).name);
    
    for j = 1:length(HalfTrialTimestamps{i})
        if j == 1 || j == 3
            segm_EMG{i,1}.left.f_dir{aid_f,1} = emg.left(:,...
                HalfTrialTimestamps{i}(1,j) - saf_b : HalfTrialTimestamps{i}(2,j) + saf_e)';
            segm_EMG{i,1}.right.f_dir{aid_f,1} = emg.right(:,...
                HalfTrialTimestamps{i}(1,j) - saf_b : HalfTrialTimestamps{i}(2,j)+ saf_e)';
            
            segm_EMG{i,2} = files_emg(i).name;
            
            segm_KIN{i,1}.f_dir{aid_f,1} = kin_RLL(HalfTrialTimestamps{i}(1,j) ...
                - saf_b : HalfTrialTimestamps{i}(2,j) + saf_e, :);
           
            segm_KIN{i,2} = files_kin(i).name;
            
            segm_GC{i,1}.f_dir{aid_f,1} = acc_z_RF(HalfTrialTimestamps{i}(1,j) ...
                - saf_b : HalfTrialTimestamps{i}(2,j) + saf_e, :);
            
            segm_GC{i,2} = files_kin(i).name;
            
            aid_f = aid_f + 1;
        elseif j == 2 || j == 4
            segm_EMG{i,1}.left.b_dir{aid_b,1} = emg.left(:,...
                HalfTrialTimestamps{i}(1,j) - saf_b : HalfTrialTimestamps{i}(2,j)+ saf_e)';
            segm_EMG{i,1}.right.b_dir{aid_b,1} = emg.right(:,...
                HalfTrialTimestamps{i}(1,j) - saf_b : HalfTrialTimestamps{i}(2,j)+ saf_e)';
            
            segm_KIN{i,1}.b_dir{aid_b,1} = kin_RLL(HalfTrialTimestamps{i}(1,j) ...
                - saf_b : HalfTrialTimestamps{i}(2,j) + saf_e, :);
                         
%             figure; plot(segm_KIN{i,1}.b_dir{aid_b,1});
                        
            segm_GC{i,1}.b_dir{aid_b,1} = acc_z_RF(HalfTrialTimestamps{i}(1,j) ...
                - saf_b : HalfTrialTimestamps{i}(2,j) + saf_e, :);
            
            aid_b = aid_b + 1;
        end
    end
    clearvars j aid_f aid_b emg kin kin_RLL acc_z_RF;
end

save('SegmentedKINs.mat','HalfTrialTimestamps','segm_KIN');
save('GaitC_AccelerationRF.mat','segm_GC');
save('SegmentedEMGs.mat','muscle_order','segm_EMG');
   