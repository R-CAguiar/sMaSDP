%Load F_GaitCycleIdentifier.m prior to running this script
% F_GaitCycleIdentifier;

strides{1,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,1):t_1.LWF(1,2),:);
strides{2,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,2):t_1.LWF(1,3),:);
strides{3,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,3):t_1.LWF(1,4),:);
strides{4,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,4):t_1.LWF(1,5),:);
strides{5,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,5):t_1.LWF(1,6),:);
strides{6,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,6):t_1.LWF(1,7),:);
strides{7,1} = emg_mod.LWF.right{1,1}(t_1.LWF(1,7):t_1.LWF(1,8),:);

strides{8,1} = emg_mod.LWB.right{1,1}(t_1.LWB(1,1):t_1.LWB(1,2),:);
strides{9,1} = emg_mod.LWB.right{1,1}(t_1.LWB(1,2):t_1.LWB(1,3),:);
strides{10,1} = emg_mod.LWB.right{1,1}(t_1.LWB(1,3):t_1.LWB(1,4),:);
strides{11,1} = emg_mod.LWB.right{1,1}(t_1.LWB(1,4):t_1.LWB(1,5),:);
strides{12,1} = emg_mod.LWB.right{1,1}(t_1.LWB(1,5):t_1.LWB(1,6),:);

muscle_order = {'TA','mGAST','VL','RF','SEM','BFL'};
cat = categorical(muscle_order);
cat = reordercats(cat, muscle_order);


for i = 1:12    
    rms_mat_strides(i,:) = rms(strides{i,1});
end

rms_mean_strides = mean(rms_mat_strides);
rms_std_strides = std(rms_mat_strides);
rms_ste_strides = std(rms_mat_strides)/sqrt(size(strides,1));


figure;
set(gcf, 'Position',  [15, 15, 1280, 720])
bar(cat,rms_mean_strides); hold on;
errorbar(rms_mean_strides,rms_ste_strides, 'LineStyle','none','LineWidth',1.2,'Color','r','CapSize',10);
xlabel('Muscles');
ylabel('EMG (V)');
ylim([0 .4]);

figure;
for i = 1:12  
    
    for j = 1:6         
        scatter(cat(j),rms_mat_strides(i,j),'b','filled'); hold on; alpha(0.3);
        errorbar(rms_mean_strides,rms_std_strides,'x','LineStyle','none','LineWidth',1.2,'Color','k','CapSize',10);
    end
    
end
