%reference: http://www.fieldtriptoolbox.org/tutorial/cluster_permutation_freq

%replace ft_FQ analysis with pwelch results (both normalised and
%non-normalised because I can't remember which one is relative)
for part_i = 1:44
    FQ_Flow(part_i).powspctrm = WF_FLOW_60s_1r(part_i).meanresults
    FQ_NF(part_i).powspctrm = WF_NFLOW_60s_1r(part_i).meanresults
end

for part_i = 1:44
    FQ_Flow(part_i).powspctrm = WF_FLOW_60s_1r(part_i).meanresultsNN
    FQ_NF(part_i).powspctrm = WF_NFLOW_60s_1r(part_i).meanresultsNN
end

addpath(genpath('F:\Jasmine\MSc_in_Music_Mind_and_Brain\fieldtrip-20140401'));
%write a loop that will do it for all frequency bands
%delta = 1 - 4Hz
%theta = 4 - 8Hz
%lower alpha = 8 - 10Hz
%upper alpha = 10 - 12Hz
%beta = 13 - 30Hz
%lower gamma = 30 - 45Hz
%upper gamma =  45 - 80Hz
% do grandaverage
Flowname = [];
NFname = [];
for i = 1:length(FQ_Flow)
    
    Flowname = [Flowname ',FQ_Flow(' num2str(i) ')']; 
    NFname = [NFname ',FQ_NF(' num2str(i) ')']; 
       
end

name = [];
cfg = [];
name = ['ft_freqgrandaverage(cfg' Flowname ')'];
cfg.parameter = 'powspctrm';
cfg.foilim = [1 80];
cfg.keepindividual = 'yes';
cfg.channel = 'all';
gavgFlow = eval(name);

name = [];
cfg = [];
name = ['ft_freqgrandaverage(cfg' NFname ')'];
cfg.parameter = 'powspctrm';
cfg.foilim = [1 80];
cfg.keepindividual = 'yes';
cfg.channel = 'all';
gavgNF = eval(name);

%Cluster permutation

load('elec_biosemi64.mat');
cfg = [];
cfg.elec = elec_biosemi64;
cfg.method = 'template';
cfg.template = 'biosemi64_neighb.mat';

neighbours = ft_prepare_neighbours(cfg,gavgFlow);
% specifies with which sensors other sensors can form clusters
cfg_neighb.method    = 'distance';
cfg_neighb.layout    = 'biosemi64.lay';
cfg.neighbours       = neighbours;

% %caro's
% cfg = [];
% cfg.neighbours = neighbours;
% cfg.method           =  'montecarlo';
% cfg.frequency        = [1 45];
% cfg.latency = [-0.2 1];
% cfg.statistic        = 'indepsamplesT';
% cfg.correctm         = 'cluster';
% cfg.clusteralpha     = 0.05;
% cfg.clusterstatistic = 'maxsum';
% cfg.minnbchan        = 1;
% cfg.tail             = 0;
% cfg.clustertail      = 0;
% cfg.alpha            = 0.05;
% cfg.numrandomization = 500;

cfg.avgoverchan      = 'no';
cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'yes'; 
cfg.method           =  'montecarlo';
cfg.frequency        = [4 4];
cfg.latency          = 'all';
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025; %two-tailed alpha
cfg.numrandomization = 500;

design = [];
parts = 44;
design  = zeros(2,2*parts);
design(1,1:parts) = 1;
design(1,parts+1:2*parts) = 2;
design(2,1:parts) = [1:parts];
design(2,parts+1:2*parts) = [1:parts];

cfg.design   = design;
cfg.ivar     = 1;
cfg.uvar     = 2;


FlowVSNonFlow = [];
FlowVSNonFlow = ft_freqstatistics(cfg, gavgFlow, gavgNF);
FlowVSNonFlow.powspctrm = FlowVSNonFlow.stat;

% %plot results
% cfg = [];
% cfg.zlim= [-4 4];
% %cfg.baseline      = [-1.6 1];
% %cfg.baselinetype  = 'relative';
% %cfg.colorbar ='no';
% cfg.interactive = 'yes';
% cfg.layout = 'biosemi64.lay';
% figure;ft_multiplotTFR(cfg,FlowVSNonFlow);

%online tutorial's visualisation
cfg = [];
cfg.alpha  = 0.05;
cfg.parameter = 'stat';
cfg.zlim   = [-4 4];
cfg.layout = 'biosemi64.lay';
ft_clusterplot(cfg, FlowVSNonFlow);

%extract significant electrodes
pos_elecs = logical(FlowVSNonFlow.posclusterslabelmat);
NF_alpha = mean(gavgNF.powspctrm(:,pos_elecs,4),2);%or perhaps sum?
F_alpha = mean(gavgFlow.powspctrm(:,pos_elecs,4),2);

pos_elecs = logical(FlowVSNonFlow.posclusterslabelmat);
NF_beta = mean(gavgNF.powspctrm(:,pos_elecs,5),2);%or perhaps sum?
F_beta = mean(gavgFlow.powspctrm(:,pos_elecs,5),2);

clusterstats = cat(2,F_alpha,NF_alpha,F_beta,NF_beta);
