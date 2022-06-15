function Out= tfr_comparisonNN(data1,data2,cfg)

% this is used to compare two conditions with the same participants
for part_i = 1:length(data1)
    
    for freq_i = 1:length(data1(1).meanresultsNN(1,:,1))
        
        for ch_i = 1:length(data1(1).meanresultsNN(:,1,1))
            
            for time_i = 1:length(data1(1).meanresultsNN(1,1,:))
                
                output.newarray1(part_i,ch_i,freq_i,time_i) = data1(part_i).meanresultsNN(ch_i,freq_i,time_i);
                output.newarray2(part_i,ch_i,freq_i,time_i) = data2(part_i).meanresultsNN(ch_i,freq_i,time_i);
            end
            
        end
        
    end
    
end
    for freq_i = 1:length(data1(1).meanresultsNN(1,:,1))
        
        for ch_i = 1:length(data1(1).meanresultsNN(:,1,1))
            
            for time_i = 1:length(data1(1).meanresultsNN(1,1,:))
                
                [H,P,CI,STATS] = ttest(output.newarray1(:,ch_i,freq_i,time_i),output.newarray2(:,ch_i,freq_i,time_i));
                
                output.tvals(ch_i,freq_i,time_i) = STATS.tstat;
                 output.pvals(ch_i,freq_i,time_i) = P;
               STATS = [];
               P = [];
            end
            
        end
        
    end
  

    
% this is used to compare two conditions with the same participants


for part_i = 1:length(data1)
    
    for freq_i = 1:length(cfg.frequencyb.bands(:,1))
        
        for ch_i = 1:length(data1(1).meanresultsNN(:,1,1))
            
            for time_i = 1:length(data1(1).meanresultsNN(1,1,:))
                
                output.newarray1_f(part_i,ch_i,freq_i,time_i) = data1(part_i).meanresultsNN(ch_i,freq_i,time_i);
                output.newarray2_f(part_i,ch_i,freq_i,time_i) = data2(part_i).meanresultsNN(ch_i,freq_i,time_i);
            end
            
        end
        
    end
    
end
  % now do t tests


    
    
    
    
  
 Out = output;   
    