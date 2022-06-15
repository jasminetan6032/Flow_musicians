% script for connectivity  - Jasmine


% STEPS

%% 1. Run the scripts to obtain a data structure with all participants
% connectivity (out of ft_connectivity analysis
% for example here, we'll call it CON(parts)


%% 2. Get the grand average but first fool fieldtrip

% do some grand averages by hacking
cfg.method = 'psispctrm';
CON_nflow_ft =  hack_connect(CON_nflow,cfg);

% make grand averages
name1 = [];

%group1 = [1 3 8 9 10 11]; %for creating two groups to compare

cfg = [];
for i = 1:length(CON_nflow)
    name1 = [name1 ',CON_nflow_ft(' num2str(i) ')'];
        
end

cfg.parameter = 'powspctrm';
cfg.keepindividual = 'no';

% this actually calculates the grand average (over participants in name1)
gavgCON_nflow = eval(['ft_freqgrandaverage(cfg' name1 ')']);


% 2. Choose electrodes of interest (for example, frontal right) to find the frequencies you'll be
% looking at, plot it as 

figure; % in this example we have electrodes 59 60 
plot(squeeze(mean(gavgCON_nflow.powspctrm([1 34],:,:),1))');title(['Non-Flow state']); %ylim([-0.08 0.07]);


%% 3. Plot the head-in-head using the heads-bio function

% this first bit is to load the needed locations
load elec_biosemi64; %load some eeg 3D-channels locations; 31 channels 
clear para; para.rot=180; %setting this rotates locations by 180 degrees
elec = elec_biosemi64.pnt(1:64,:);
locs_2D=mk_sensors_plane(elec); 

% define the y limits as
cfg.ylim = [-0.05 0.05];
cfg.freqband = [5 7.5];
% feed that in the heads_bio function
heads_bio(gavgCON_nflow,cfg.freqband,cfg.ylim,locs_2D,1);


% now you can write a function to give stats, let me know if you need help 










