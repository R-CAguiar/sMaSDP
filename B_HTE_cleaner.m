clear;
load('RoughHalfTrialEstimator.mat');

for t = 1:length(rough_segments)

    active_times = find(rough_segments{t});
    aid = 1;

    % Separates, from the entire array, each column of activity during the
    % trials (a single column corresponds to one direction or a half trial)
    for i = 1:length(active_times)-1
        HT{aid}(i,1) = active_times(i,1); 
        if active_times(i+1) ~= active_times(i) + 1
            HT{aid}(HT{aid} == 0) = []; 
            aid = aid + 1;
        end   
    end
    HT{aid}(HT{aid} == 0) = [];
    clearvars aid;

    aid = 1;

    % Filter for columns under 6000 datapoints, referring to signal errors or
    % participant turns (undesireable data)
    for i1 = 1:size(HT,2)
        if length(HT{i1}) > 6000
            HT_c{aid} = HT{i1};
            aid = aid + 1;
        end
    end
    
    HT_total{t,1} = HT_c;
   
    clearvars active_times aid i i1 HT HT_c;
    
end

for j = 1:length(HT_total)
    for k = 1:size(HT_total{j},2)
        HalfTrialTimestamps{j,1}(1,k) = HT_total{j}{1,k}(1,1);
        HalfTrialTimestamps{j,1}(2,k) = HT_total{j}{1,k}(end,1);
    end
end
   
save('HalfTrialTimestamps.mat')