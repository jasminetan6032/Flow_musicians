dbstop if error
load Participants.mat
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



%getting WF_FLOW and WF_NFLOW
filename_flow = '_PF_FLOW.set';
filename_nflow= '_PF_NF.set';

filedir = 'E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Analysed EEG\Analysed Data (from lab computer)';
filedir_flow = 'E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Analysed EEG\Analysed Data (from lab computer)\InterpEpoch\PF_FLOW';
filedir_nflow = 'E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Analysed EEG\Analysed Data (from lab computer)\InterpEpoch\PF_NF';

addpath(genpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Matlab workspace'));
timevec = [0 60];
freqvec = [1 4;4 8;8 10;10 12;12 30;30 45;55 80];



for part_i = 1:length(parts)
	
	flow_filename = [];
	flow_filename = [parts{part_i} filename_flow];
    
    addpath('D:\eeglab_sml_v3\eeglab_sml_v3');
	
	EEG_flow = [];
	EEG_flow = pop_loadset('filename',flow_filename,'filepath',filedir_flow);
	
	
			WF_FLOW_60s_1r(part_i) = do_pwelch_sum(EEG_flow,timevec,freqvec);
	
	EEG_FLOW_ft = [];
    EEG_FLOW_ft = eeglab2fieldtrip(EEG_flow,'preprocessing','none');
	
	rmpath('D:\eeglab_sml_v3\eeglab_sml_v3');
	
    EEG_FLOW1 = [];
	
    addpath(genpath('D:\fieldtrip-20111223\fieldtrip-20111223'));
	
    cfg = [];
	cfg.toilim = [0 60];
	EEG_FLOW1 = ft_redefinetrial(cfg,EEG_FLOW_ft);
	
	cfg = [];
	cfg.method = 'mtmfft';
	cfg.output = 'pow';
	%cfg.pad =32;
	cfg.tapsmofrq ='maxperlen';
	%cfg.foilim = [1 45];
	cfg.foi = 1:1:7;
	cfg.taper = 'hanning';
	cfg.keeptrials = 'no';
	
	FQ_Flow(part_i) = ft_freqanalysis(cfg,EEG_FLOW1);
    
    rmpath(genpath('D:\fieldtrip-20111223\fieldtrip-20111223'));
	
	FLOW_filename = [];
	EEG_FLOW = [];
	EEG_FLOW_ft = [];
	EEG_FLOW1 = [];
	
	%% do the same for non-flow
	nflow_filename = [];
	nflow_filename = [parts{part_i} filename_nflow];
    
    	addpath('D:\eeglab_sml_v3\eeglab_sml_v3');
	
	EEG_nflow = [];
	EEG_nflow = pop_loadset('filename',nflow_filename,'filepath',filedir_nflow);
		
		WF_NFLOW_60s_1r(part_i) = do_pwelch_sum(EEG_nflow,timevec,freqvec);
	
	EEG_nflow_ft = [];
	EEG_nflow_ft = eeglab2fieldtrip(EEG_nflow,'preprocessing','none');
    
    rmpath('D:\eeglab_sml_v3\eeglab_sml_v3');
	
	EEG_nflow1 = [];
	addpath(genpath('D:\fieldtrip-20111223\fieldtrip-20111223'));
	cfg = [];
	cfg.toilim = [0 60];
	EEG_nflow1 = ft_redefinetrial(cfg,EEG_nflow_ft);
	
	cfg = [];
	cfg.method = 'mtmfft';
	cfg.output = 'pow';
	%cfg.pad =32;
	cfg.tapsmofrq ='maxperlen';
	%cfg.foilim = [1 45];
	cfg.foi = 1:1:7;
	cfg.taper = 'hanning';
	cfg.keeptrials = 'no';
	
	FQ_NF(part_i) = ft_freqanalysis(cfg,EEG_nflow1);
    
    rmpath(genpath('D:\fieldtrip-20111223\fieldtrip-20111223'));
    
	nflow_filename = [];
	EEG_nflow = [];
	EEG_nflow_ft = [];
	EEG_nflow1 = [];
	
end
