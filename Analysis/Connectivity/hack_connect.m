function Out = hack_connect(data,cfg)

% adds powspctrm for connectivity if you used wpli_debiased (change the
% field if you used other method



for part_i = 1:length(data)
    
    data(part_i).powspctrm = data(part_i).(cfg.method);  %wpli_debiasedspctrm;
    data(part_i).dimord = 'chan_freq_time'; % it was 'chan_chan_freq'
    data(part_i).time = data(part_i).freq;
    data(part_i).urfreq =data(part_i).freq;
    data(part_i).freq =[1:1:length(data(part_i).powspctrm(1,:,1))];
end

Out = data;