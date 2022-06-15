function Out = explore_data(data1,data2,contrast,cfg)
% this function can be used to explore clusters of electrodes in time and
% space. It also gives error bars with the significant stuff found.
% required inputs:
% data1 = tfr coming out of the do_pwelch (includes all participants)
% data2 = the same, but for the other condition
% contrast = comparison coming out of tfr_comparison
% cfg = data structure including the following fields

% cfg.pval = threshold for significance
% cfg.selec = minimum number of electrodes in a cluster
% cfg.stime = minimum number of time points to consider a cluster
% cfg.freqlabels = labels for the frequencies, 
% cfg.freqlabels = {'Delta','Theta','Alpha 1', 'Alpha 2','Beta', 'Gamma
% 1','Gamma 2'};

% open power point
% the output gives you the stats for the significant clusters

cd(cfg.dir);
significant = find(contrast.pvals<=cfg.pval);
ppt = PPT2007;
ppt = ppt.addTitleSlide('Exploring the data'); %adds a title slide

for freq_i = 1:length(contrast.pvals(1,:,1))
allelecs = [];
ppt = ppt.addTitleSlide([cfg.freqlabels{freq_i} 'Frequency Band']); %adds a title slide

    for time_i = 1:length(contrast.pvals(1,1,:))

        testelect = [];
        testsig = [];
 
% this will return the significant electrodes
testelec = find(contrast.pvals(1:64,freq_i,time_i)<=cfg.pval);
   testtime.channels{time_i} =testelec;
if length(testelec)>cfg.selec
allelecs = [allelecs;testelec];
end

    end

    testelec =[];
    testelec = unique(allelecs);
% now we have to check which ones survive our time windows
if length(testelec)>cfg.selec
      
    for ch_i = 1:length(testelec)
       
        for time_a = 1:length(contrast.pvals(1,1,:))
        testtime.chans{ch_i,time_a} = contrast.pvals(testelec(ch_i),freq_i,time_a)<=cfg.pval;
     
        end
        
    end
    
end


% now do the plotting with highlights
stats_i = 0;

figure; 
for time_i = 1:length(contrast.pvals(1,1,:))
veceeg = [];

   veceeg = squeeze(contrast.tvals(:,freq_i,time_i));
   mask = zeros(64,1);
   mask(testtime.channels{time_i}) = 1;
   
   elecsnew = find(mask==1);
   
   if isempty(elecsnew)~=1
       
   stats(1).elecs(freq_i).mask{time_i} = find(mask==1);
   
   else
    
     stats(1).elecs(freq_i).mask{time_i} = 0;   
   end
   %clear figure;
 figure;   topoplot(veceeg,cfg.chanlocs.biosemilocs,'plotrad',0.55,'maplimits',[-2.5 2.5],'emarker2', {testtime.channels{time_i},'o','k'}); 
%figname =  ['Flow higher than Non-flow ' cfg.freqlabels{freq_i} ' at time window ' num2str(time_i)];
figname = []
fignamesave =  [cfg.dir '/FvsNF' cfg.freqlabels{freq_i} 'tw' num2str(time_i) '.png'];

title(figname);

saveas(gca, fignamesave); %save the figure
 ppt = ppt.addImageSlide(figname, fignamesave);

 
 % now do the bar plots if there's a cluster
 
%  if length(testtime.channels{time_i})>=cfg.selec
%  stats_i = stats_i+1;
%      
%      to_plot1 =nanmean(squeeze(nanmean(contrast.newarray1(:,testtime.channels{time_i},freq_i,:),2)));
%      std_to_plot1 =nanstd(squeeze(nanmean(contrast.newarray1(:,testtime.channels{time_i},freq_i,:),2)))./sqrt(length(contrast.newarray1(:,1,1,1)));
%      
%       to_plot2 =nanmean(squeeze(nanmean(contrast.newarray2(:,testtime.channels{time_i},freq_i,:),2)));
%      std_to_plot2 =nanstd(squeeze(nanmean(contrast.newarray2(:,testtime.channels{time_i},freq_i,:),2)))./sqrt(length(contrast.newarray1(:,1,1,1)));
%  
%      % get stats - adapt this part for other projects
%      for twi = 1:length(to_plot1)
%         
%          % 1 is flow and 2 is non-flow
%          stats(1).clabel(stats_i).label{twi} = ['F_tw' num2str(twi) cfg.freqlabels{freq_i}]; 
%          stats(2).clabel(stats_i).label{twi} = ['NF_tw' num2str(twi) cfg.freqlabels{freq_i}]; 
%          
%      end
%      
%      stats(1).data{stats_i} = squeeze(nanmean(contrast.newarray1(:,testtime.channels{time_i},freq_i,:),2));
%       stats(2).data{stats_i} = squeeze(nanmean(contrast.newarray2(:,testtime.channels{time_i},freq_i,:),2));
%      
%   %clear figure;   
%    figure;barweb([to_plot1' to_plot2'] ,[std_to_plot2' std_to_plot2'], 0.8, [], [], [], [], jet, [],[], 2,[])
%   %  set(gca, 'XtickLabel', cfg.conds);
% 
% setmin = (min([to_plot1 to_plot2])-max([std_to_plot1 std_to_plot2]))-0.1;
% setmax = (max([to_plot1 to_plot2])+max([std_to_plot1 std_to_plot2]))+0.1;
% set(gca, 'FontSize',10);
% set(gca,'YLim',[setmin setmax]);
% %set(gca,'YTick',[0:0.05:1]);
% figname =  ['Flow higher than Non-flow ' cfg.freqlabels{freq_i} cfg.xlabel];
% fignamesave =  [cfg.dir '/FvsNF' cfg.freqlabels{freq_i} 'tw' num2str(time_i) '.png'];
% 
% title(figname);
% 
% saveas(gca, fignamesave); %save the figure
%  ppt = ppt.addImageSlide(figname, fignamesave);
% 
%  
%  end
%      
 
end

end % end for frequency

%ppt.saveAs(cfg.title); %save the presentation.
Out = stats;