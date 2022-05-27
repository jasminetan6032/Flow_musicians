%Find PSI for all participants in FLOW

dbstop if error
parts = [];
parts{1} = 'AT';
parts{2} = 'CBC';
parts{3} = 'CC';
parts{4} = 'CC01';
parts{5} = 'CG';
parts{6} = 'CG01';
parts{7} = 'CP';
parts{8} = 'DB';
parts{9} = 'DG';
parts{10} = 'EB';
parts{11} = 'EB01';
parts{12} = 'EO';
parts{13} = 'ES';
parts{14} = 'GH';
parts{15} = 'JB';
parts{16} = 'JB01';
parts{17} = 'JC';
parts{18} = 'JL';
parts{19} = 'KC';
parts{20} = 'KH';
parts{21} = 'KJ';
parts{22} = 'LM';
parts{23} = 'LYL';
parts{24} = 'MH';
parts{25} = 'MK';
parts{26} = 'MM';
parts{27} = 'MRT';
parts{28} = 'MS';
parts{29} = 'MS01';
parts{30} = 'MZ';
parts{31} = 'NF';
parts{32} = 'NT';
parts{33} = 'OJ';
parts{34} = 'PS';
parts{35} = 'RC';
parts{36} = 'RN';
parts{37} = 'RS';
parts{38} = 'RT';
parts{39} = 'SNPH';
parts{40} = 'SS01';
parts{41} = 'SWS';
parts{42} = 'TG';
parts{43} = 'TL';
parts{44} = 'WPL';





% Find PSI in all participants in flow
filename_FLOW = '_PF_FLOW_80_select.set';

filedir_FLOW = 'E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Analysed EEG\Analysed Data (from lab computer)\InterpEpoch80\PF_FLOW_80_select';

addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Matlab workspace\Matlab scripts 25.7.14'));
%timevec = [0 200];
freqvec = [1 4;4 8;8 13;13 30;35 45];



for part_i = 1:length(parts)
	
	FLOW_filename = [];
	FLOW_filename = [parts{part_i} filename_FLOW];
	
    addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\EEGlab dl\eeglab13_3_2b'));
    
	EEG_FLOW = [];
	EEG_FLOW = pop_loadset('filename',FLOW_filename,'filepath',filedir_FLOW);
    EEG_FLOW = pop_select( EEG_FLOW,'channel',{'Fp1' 'AF7' 'AF3' 'F1' 'F3' 'F5' 'F7' 'FT7' 'FC5' 'FC3' 'FC1' 'C1' 'C3' 'C5' 'T7' 'TP7' 'CP5' 'CP3' 'CP1' 'P1' 'P3' 'P5' 'P7' 'P9' 'PO7' 'PO3' 'O1' 'Iz' 'Oz' 'POz' 'Pz' 'CPz' 'Fpz' 'Fp2' 'AF8' 'AF4' 'AFz' 'Fz' 'F2' 'F4' 'F6' 'F8' 'FT8' 'FC6' 'FC4' 'FC2' 'FCz' 'Cz' 'C2' 'C4' 'C6' 'T8' 'TP8' 'CP6' 'CP4' 'CP2' 'P2' 'P4' 'P6' 'P8' 'P10' 'PO8' 'PO4' 'O2'});
    
   			%WF_baseline_connectivity_EC1(part_i) = do_connectivity(EEG_EC1,freqvec);
	
	EEG_FLOW_ft = [];
	
	EEG_FLOW_ft = eeglab2fieldtrip(EEG_FLOW,'preprocessing','none');
   
	rmpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\EEGlab dl\eeglab13_3_2b'));
    
	EEG_FLOW_1 = [];
	addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\fieldtrip-20140401'));
    
    %this bit does the frequency analysis
    cfg           = [];
    cfg.method    = 'mtmfft';
    cfg.taper     = 'dpss';
    cfg.output    = 'fourier';
    cfg.foi = [1:1:70];
   cfg.tapsmofrq = cfg.foi*0.05;
    

    freqdata = ft_freqanalysis(cfg,EEG_FLOW_ft);


    % this bit estimates the connectivity
    cfg = [];
    cfg.method = 'psi';
    cfg.bandwidth = 1; % change here according to the frequency resolution 
    connectres_FLOW_select(part_i) = ft_connectivityanalysis(cfg,freqdata);
    
    freqdata = [];

    rmpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\fieldtrip-20140401'));
	
	FLOW_filename = [];
   
	EEG_FLOW = [];

	EEG_FLOW_ft = [];
    
	EEG_FLOW_1 = [];
    
	
end

%Find PSI in all participants in non-flow

filename_NF = '_PF_NF_80_select.set';

filedir_NF = 'E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Analysed EEG\Analysed Data (from lab computer)\InterpEpoch80\PF_NF_80_select';

addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Matlab workspace\Matlab scripts 25.7.14'));
%timevec = [0 200];
freqvec = [1 4;4 8;8 13;13 30;35 45];



for part_i = 1:length(parts)
	
	NF_filename = [];
	NF_filename = [parts{part_i} filename_NF];
	
    addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\EEGlab dl\eeglab13_3_2b'));
    
	EEG_NF = [];
	EEG_NF = pop_loadset('filename',NF_filename,'filepath',filedir_NF);
    EEG_NF = pop_select( EEG_NF,'channel',{'Fp1' 'AF7' 'AF3' 'F1' 'F3' 'F5' 'F7' 'FT7' 'FC5' 'FC3' 'FC1' 'C1' 'C3' 'C5' 'T7' 'TP7' 'CP5' 'CP3' 'CP1' 'P1' 'P3' 'P5' 'P7' 'P9' 'PO7' 'PO3' 'O1' 'Iz' 'Oz' 'POz' 'Pz' 'CPz' 'Fpz' 'Fp2' 'AF8' 'AF4' 'AFz' 'Fz' 'F2' 'F4' 'F6' 'F8' 'FT8' 'FC6' 'FC4' 'FC2' 'FCz' 'Cz' 'C2' 'C4' 'C6' 'T8' 'TP8' 'CP6' 'CP4' 'CP2' 'P2' 'P4' 'P6' 'P8' 'P10' 'PO8' 'PO4' 'O2'});
    
   			%WF_baseline_connectivity_EC1(part_i) = do_connectivity(EEG_EC1,freqvec);
	
	EEG_NF_ft = [];
	
	EEG_NF_ft = eeglab2fieldtrip(EEG_NF,'preprocessing','none');
   
	rmpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\EEGlab dl\eeglab13_3_2b'));
    
	EEG_NF_1 = [];
	addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\fieldtrip-20140401'));
    
    %this bit does the frequency analysis
    cfg           = [];
    cfg.method    = 'mtmfft';
    cfg.taper     = 'dpss';
    cfg.output    = 'fourier';
    cfg.foi = [1:1:70];
   cfg.tapsmofrq = cfg.foi*0.05;
    

    freqdata = ft_freqanalysis(cfg,EEG_NF_ft);


    % this bit estimates the connectivity
    cfg = [];
    cfg.method = 'psi';
    cfg.bandwidth = 1; % change here according to the frequency resolution 
    connectres_NF_select(part_i) = ft_connectivityanalysis(cfg,freqdata);
    
    freqdata = [];

    rmpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\fieldtrip-20140401'));
	
	NF_filename = [];
   
	EEG_NF = [];

	EEG_NF_ft = [];
    
	EEG_NF_1 = [];
    
	
end

%Get grand averages in flow condition
CON_flow = connectres_FLOW_select;

% do some grand averages by hacking
cfg.method = 'psispctrm';
CON_flow_ft =  hack_connect(CON_flow,cfg);

% make grand averages
name1 = [];

%group1 = [1 3 8 9 10 11]; %for creating two groups to compare

cfg = [];
for i = 1:length(CON_flow)
    name1 = [name1 ',CON_flow_ft(' num2str(i) ')'];
        
end

cfg.parameter = 'powspctrm';
cfg.keepindividual = 'no';

% this actually calculates the grand average (over participants in name1)
gavgCON_flow = eval(['ft_freqgrandaverage(cfg' name1 ')']);

%Get grand averages in non-flow condition
CON_nflow = connectres_NF_select;

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

addpath(genpath('F:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Matlab workspace\Matlab scripts 25.7.14'));

cfg.method = 'psispctrm';
cfg.pval = 0.05;
cfg.parts1 = 1:44;
cfg.parts2 = 1:44;
cfg.correct = 1;
cfg.dir = 'F:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Matlab workspace\Matlab scripts 25.7.14\Flow connectivity\psi_results'

flow_nflow_nocorrect = compare_connectivity(cfg,connectres_FLOW_select,connectres_NF_select);

load elec_biosemi64;
clear para; para.rot=180;
elec = elec_biosemi64.pnt(1:64,:);
locs_2D=mk_sensors_plane(elec);

cfg.ppt = 1;
cfg.title = 'Flow vs Non-flow';
cfg.method = 'PSI';

freqs = [0 3 4 5 6 8 9 10 11 13 16 19 23 24 26 29 33 36 39];
labels = connectres_FLOW_select(1).label;

cfg.cond = 'flow_';
cfg.method = 'powspctrm';
cfg.measure = 'powspctrm';

%this gets statitstics to find significant electrodes
elecs_F_NF = graph_eeg(cfg,flow_nflow_nocorrect,locs_2D,freqs,labels,[1:19],gavgCON_flow,gavgCON_nflow);

cfg.measure = 'psispctrm';
F_stats = extract_stats(cfg,elecs_F_NF, connectres_FLOW_select);
NF_stats = extract_stats(cfg,elecs_F_NF, connectres_NF_select);