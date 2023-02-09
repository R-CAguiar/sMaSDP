clear; 

load('GaitCycleTimes.mat');

rec_f = 1000; %1000 Hz

gc_mod.RD = vertcat(gc_mod.RD(:,1),gc_mod.RD(:,2));
gc_mod.RD = gc_mod.RD(~cellfun('isempty', gc_mod.RD));

gc_mod.RA = vertcat(gc_mod.RA(:,1),gc_mod.RA(:,2));
gc_mod.RA = gc_mod.RA(~cellfun('isempty', gc_mod.RA));

gc_mod.SD = vertcat(gc_mod.SD(:,1),gc_mod.SD(:,2));
gc_mod.SD = gc_mod.SD(~cellfun('isempty', gc_mod.SD));

gc_mod.SA = vertcat(gc_mod.SA(:,1),gc_mod.SA(:,2));
gc_mod.SA = gc_mod.SA(~cellfun('isempty', gc_mod.SA));

gc_mod.LWF = vertcat(gc_mod.LWF(:,1),gc_mod.LWF(:,2));
gc_mod.LWF = gc_mod.LWF(~cellfun('isempty', gc_mod.LWF));

gc_mod.LWB = vertcat(gc_mod.LWB(:,1),gc_mod.LWB(:,2));
gc_mod.LWB = gc_mod.LWB(~cellfun('isempty', gc_mod.LWB));

%Steps: HP 10Hz FIR, ABS(), LP 5HZ FIR

f_hp = 10/(rec_f/2);
f_lp = 5/(rec_f/2);

[b_hp,a_hp] = butter(3,f_hp, 'high');
[b_lp,a_lp] = butter(3,f_lp, 'low');

i = 1;
    figure;
    assist = gc_mod.LWF{i,1};
    subplot(4,1,1); plot(assist); xlim([0 length(assist)]);
    
    assist = filtfilt(b_hp,a_hp, assist);
    subplot(4,1,2); plot(assist); xlim([0 length(assist)]);
    for j = 1:length(assist)
        if assist(j) < 0
            assist(j) = 0;
        else 
            assist(j) = assist(j);
        end
    end
    
    subplot(4,1,3); plot(assist); xlim([0 length(assist)]);
    assist = filtfilt(b_lp,a_lp, assist);
  
    subplot(4,1,4); plot(assist); xlim([0 length(assist)]);
    hold on; findpeaks(assist,'MinPeakDistance',1000,'MinPeakProminence',0.15); xlim([0 length(assist)]);
    clearvars assist;


% %% Randomly selected trials with manual gait cycle extraction
% t_1.LWF = [945 2319 3568 4937 6214 7590 8809 10120];
% t_1.LWB = [1507 2795 4209 5570 6827 8131];
% t_1.SA = [2060 3524 4881 6346 7791 9346 10950 12390];
% t_1.SD = [3475 4723 6058 7320 8719 10090 11330 12770 14000];
% t_1.RA = [1327 2571 4091 5452 6858 8270 9628];
% t_1.RD = [3495 4875 6108 7314 8418 9768 11080];
% 
% t_20.LWF = [857 1949 3056 4224 5200 6315 7400 8597];
% t_20.LWB = [928 2131 3213 4376 5510 6600 7716 8817];
% t_20.SA = [1063 2213 3203 4526 5929 7275 8421 9892 11130 12270];
% t_20.SD = [3091 4370 5712 6766 7835 8969 10120 11230 12330 13990];
% t_20.RA = [1085 2217 3452 4742 5961 7104 8254];
% t_20.RD = [3161 4300 5420 6992 7460 8525 9759];
% 
% t_50.LWF = [812 2175 3404 4662 5809 7044 8311 9533];
% t_50.LWB = [1079 2553 3834 5095 6340 7554 8744 10020];
% t_50.SA = [730 2040 3362 4710 5908 7083 8200 9456 10690 11850];
% t_50.SD = [3191 4525 5819 6988 9147 10360 11600 12850];
% t_50.RA = [817 2100 3330 4645 5881 7181 8423];
% t_50.RD = [3336 4672 5767 6972 8079 9203 10410];
% 
% t_120.LWF = [1213 2236 3513 4548 5680 6918 7943 9091];
% t_120.LWB = [853 2013 3129 4258 5341 6500 7589 8680 9825];
% t_120.SA = [898 2020 3035 4244 5426 6810 8129 9375 10770 11850];
% t_120.SD = [4117 5335 6394 7458 8513 9652 10700];
% t_120.RA = [1039 2168 3299 4519 5768 6976 8262];
% t_120.RD = [3097 4346 5468 6511 7572 8658 9865];
% 
% t_200.LWF = [182 1346 2549 3688 4976 6067 7315 8494 9784];
% t_200.LWB = [951 2142 3412 4641 5826 7030 8219 9391 10170];
% t_200.SA = [973 2239 3464 4729 6037 7318 8738 10250 11690];
% t_200.SD = [2195 3426 4742 6006 72608443 9586 10900 12070 13280];
% t_200.RA = [64 1193 3423 3641 4975 6257 7559 8931 10270];
% t_200.RD = [2716 4036 5205 6361 7473 8673 9883 11010];

