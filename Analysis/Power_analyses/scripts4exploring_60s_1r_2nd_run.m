% scripts to explore
% once the power analysis is ready (according to the
% scripts_absolute_combined), the baseline removed and the comparison done,
% you want to run the explore_data.m

% first load WF_FLOW and WF_NFLOW and the WF_baseline

% now get the time and frequency matrices exactly as it was input in the
% analysis
timevec = [0 60];
freqvec = [1 4;4 8;8 10;10 12;12 30;30 45;55 80];

% % now remove the baseline as: 
% cfg.norm=2; % 1 = decibel; 2 = ratio; 3 = subtraction (I myself prefer ratio)
% WF_FLOWn = remove_baseline(WF_FLOW, WF_baseline,cfg);
% WF_NFLOWn = remove_baseline(WF_NFLOW, WF_baseline,cfg);


%compare flow and non-flow
cfg = [];
cfg.frequencyb.bands = freqvec;
cfg.normalized = 0; % use here 0 if you want relative and 1 if you want absolute
flow_vs_nflow_60s_1r = tfr_comparison(WF_FLOW_60s_1r,WF_NFLOW_60s_1r,cfg); % here you can test baselined and no-baselined (explore)

% before you run this open power point and make sure you have all the
% functions on the path
cfg = [];
cfg.pval = 0.05;
cfg.selec = 2; % minimum number of electrodes required for plotting bars
cfg.stime = 1; % minimum number of time windows, set to 1 for now

cfg.freqlabels = {'Delta','Theta','Alpha 1', 'Alpha 2','Beta', 'Gamma 1','Gamma 2'}; % the same as in script_absolute_combined
cfg.freqbands = [1 4;4 8;8 10;10 12;12 30;30 45;55 80]; % the same as in script_absolute_combined
cfg.chanlocs = load('biosemilocs.mat'); % load the chanlocs, I'm sending you the file
cfg.title = 'Explore the data: Relative Power'; % here you can change to name the things you're tested. e.g. normalized to bla bla
cfg.dir = 'C:\Github\Flow_musicians\Data\Results with corrected relative power\Results_fixed_pictures'; % directory to save figure and ppt
cfg.conds = {'Flow','Non-flow'};
cfg.xlabel = ' each 10 s'; % distance of the time window

% now run it
stats_step1 = explore_data(WF_FLOW_60s_1r,WF_NFLOW_60s_1r,flow_vs_nflow_60s_1r,cfg);

% this stats will contain a stats data structure which has the data for
% stats for each of the cluster labels (the number of datasets (with all
% time windows), must be the same as the barplots in the ppt.


