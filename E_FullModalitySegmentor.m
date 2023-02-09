clear;

load('SegmentedEMGs.mat');
load('IdentifiedModalities.mat');
load('GaitC_AccelerationRF.mat');

mod_description = {'RD' 'LWF', 'SA', 'SD', 'LWB', 'RA'; 'Ramp Descent', 'Level Walking (Forward)', ...
    'Staircase Ascent', 'Staircase Descent', 'Level Walking (Back)', 'Ramp Ascent'}';

for i = 1:length(segm_EMG)
    for j = 1:length(segm_EMG{i,1}.left.f_dir)
        emg_mod.RD.left{i,j} = segm_EMG{i,1}.left.f_dir{j,1}(1 : m_ind{i,1}.f_dir{j,1}(1,1),:);
        emg_mod.LWF.left{i,j} = segm_EMG{i,1}.left.f_dir{j,1}(m_ind{i,1}.f_dir{j,1}(1,1)+1:m_ind{i,1}.f_dir{j,1}(2,1),:);
        emg_mod.SA.left{i,j} = segm_EMG{i,1}.left.f_dir{j,1}(m_ind{i,1}.f_dir{j,1}(2,1)+1:end,:);
        
        gc_mod.RD{i,j} = segm_GC{i,1}.f_dir{j,1}(1 : m_ind{i,1}.f_dir{j,1}(1,1),:);
        gc_mod.LWF{i,j} = segm_GC{i,1}.f_dir{j,1}(m_ind{i,1}.f_dir{j,1}(1,1)+1:m_ind{i,1}.f_dir{j,1}(2,1),:);
        gc_mod.SA{i,j} = segm_GC{i,1}.f_dir{j,1}(m_ind{i,1}.f_dir{j,1}(2,1)+1:end,:);
                
        emg_mod.RD.right{i,j} = segm_EMG{i,1}.right.f_dir{j,1}(1 : m_ind{i,1}.f_dir{j,1}(1,1),:);
        emg_mod.LWF.right{i,j} = segm_EMG{i,1}.right.f_dir{j,1}(m_ind{i,1}.f_dir{j,1}(1,1)+1:m_ind{i,1}.f_dir{j,1}(2,1),:);
        emg_mod.SA.right{i,j} = segm_EMG{i,1}.right.f_dir{j,1}(m_ind{i,1}.f_dir{j,1}(2,1)+1:end,:);
                
        emg_mod.RD.left{i,3} = segm_EMG{i,2};
        emg_mod.LWF.left{i,3} = segm_EMG{i,2};
        emg_mod.SA.left{i,3} = segm_EMG{i,2};
        
        emg_mod.RD.right{i,3} = segm_EMG{i,2};
        emg_mod.LWF.right{i,3} = segm_EMG{i,2};
        emg_mod.SA.right{i,3} = segm_EMG{i,2};
    end
    
    clearvars j;
    
    for j = 1:length(segm_EMG{i,1}.left.b_dir)
        emg_mod.SD.left{i,j} = segm_EMG{i,1}.left.b_dir{j,1}(1 : m_ind{i,1}.b_dir{j,1}(1,1),:);
        emg_mod.LWB.left{i,j} = segm_EMG{i,1}.left.b_dir{j,1}(m_ind{i,1}.b_dir{j,1}(1,1)+1:m_ind{i,1}.b_dir{j,1}(2,1),:);
        emg_mod.RA.left{i,j} = segm_EMG{i,1}.left.b_dir{j,1}(m_ind{i,1}.b_dir{j,1}(2,1)+1:end,:);
        
        gc_mod.SD{i,j} = segm_GC{i,1}.b_dir{j,1}(1 : m_ind{i,1}.b_dir{j,1}(1,1),:);
        gc_mod.LWB{i,j} = segm_GC{i,1}.b_dir{j,1}(m_ind{i,1}.b_dir{j,1}(1,1)+1:m_ind{i,1}.b_dir{j,1}(2,1),:);
        gc_mod.RA{i,j} = segm_GC{i,1}.b_dir{j,1}(m_ind{i,1}.b_dir{j,1}(2,1)+1:end,:);
                
        emg_mod.SD.right{i,j} = segm_EMG{i,1}.right.b_dir{j,1}(1 : m_ind{i,1}.b_dir{j,1}(1,1),:);
        emg_mod.LWB.right{i,j} = segm_EMG{i,1}.right.b_dir{j,1}(m_ind{i,1}.b_dir{j,1}(1,1)+1:m_ind{i,1}.b_dir{j,1}(2,1),:);
        emg_mod.RA.right{i,j} = segm_EMG{i,1}.right.b_dir{j,1}(m_ind{i,1}.b_dir{j,1}(2,1)+1:end,:);
        
        emg_mod.SD.left{i,3} = segm_EMG{i,2};
        emg_mod.LWB.left{i,3} = segm_EMG{i,2};
        emg_mod.RA.left{i,3} = segm_EMG{i,2};
        
        emg_mod.SD.right{i,3} = segm_EMG{i,2};
        emg_mod.LWB.right{i,3} = segm_EMG{i,2};
        
        emg_mod.RA.right{i,3} = segm_EMG{i,2};
    end
end

save('GaitCycleTimes.mat','gc_mod','emg_mod');