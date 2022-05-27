function heads_bio(data,freq,zlims,locs_2D,grandavg)

% this function plots the heads-in-head in a determined frequency range
% data is grandaveraged (hacked) data coming from fieldtrip;
% freq is the frequency range you want to plot (e.g. [6 8])
% the hacked data has the freq and time fields swapt, it relies on that.
addpath('E:\Jasmine\MSc_in_Music_Mind_and_Brain\Research Project\EEG\Matlab workspace\Matlab scripts 25.7.14\Scripts connectivity\headinhead');

load elec_biosemi64; %load some eeg 3D-channels locations; 31 channels 
clear para; para.rot=180; %setting this rotates locations by 180 degrees
elec = elec_biosemi64.pnt(1:64,:);

if nargin<4
locs_2D=mk_sensors_plane(elec); 
end

if grandavg==1
freqpoints = find(data.time>=freq(1) & data.time<=freq(2));
else
    freqpoints = find(data.freq>=freq(1) & data.freq<=freq(2));
end
    
cs = mean(data.powspctrm(:,:,freqpoints),3);

findthenan = isnan(cs);
deletenan = find(findthenan==1);
cs(deletenan) = 0;

para.scale=zlims;
figure;showcs(cs,locs_2D,para);

%rmpath('C:\Users\Caro\Documents\MATLAB\connectivity\headinhead');

end
