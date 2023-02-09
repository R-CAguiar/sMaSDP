clear;
load('SegmentedKINs.mat');

for i = 1:length(segm_KIN)
   for j = 1:length(segm_KIN{i,1}.f_dir)
       
       segm_KIN_n{i,1}.f_dir{j,1} = smooth(segm_KIN{i,1}.f_dir{j,1},0.1); 
       [~,m_ind{i,1}.f_dir{j,1}(1,1)] = findpeaks(segm_KIN_n{i, 1}.f_dir{j, 1},'MinPeakProminence',1);
       [~,m_ind{i,1}.f_dir{j,1}(2,1)] = findpeaks(-segm_KIN_n{i, 1}.f_dir{j, 1},'MinPeakProminence',1);
       m_ind{i,1}.f_dir{j,1} = sort(m_ind{i,1}.f_dir{j,1});
       
   end
end

clearvars i j k;

for i = 1:length(segm_KIN)
   for j = 1:length(segm_KIN{i,1}.b_dir)
       
       segm_KIN_n{i,1}.b_dir{j,1} = smooth(segm_KIN{i,1}.b_dir{j,1},0.1);
       [~,m_ind{i,1}.b_dir{j,1}(1,1)] = findpeaks(segm_KIN_n{i, 1}.b_dir{j, 1},'MinPeakProminence',1);
       [~,m_ind{i,1}.b_dir{j,1}(2,1)] = findpeaks(-segm_KIN_n{i, 1}.b_dir{j, 1},'MinPeakProminence',1);
       m_ind{i,1}.b_dir{j,1} = sort(m_ind{i,1}.b_dir{j,1});

   end
end

clearvars i j k;

% figure;plot(segm_KIN_n{1, 1}.f_dir{1, 1}); hold on; 
% findpeaks(segm_KIN_n{1, 1}.f_dir{1, 1},'MinPeakProminence',1); hold on; 
% findpeaks(-segm_KIN_n{1, 1}.f_dir{1, 1},'MinPeakProminence',1);

save('IdentifiedModalities.mat', 'm_ind');