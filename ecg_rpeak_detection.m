%% load the case names in the directory
clc
clear all
close 

%%
files = dir('training2017\A00\*.mat');
fs=300;
NumCases=length(files);
name={files.name};

ii=1;
AllBeats=[]; Rp=[]; Q=[]; T=[]; CaseNum=[]; Nrml=logical.empty;

%% 5a.
for i=1:NumCases
    h = waitbar(0,['Case No. ' num2str(i) ', gathering the appropriate beats, please wait ...']);
    load(['training2017\A00\' name{i}]);
    ecg=val(1,:)';
    hr=72/60;
%     peak_detector_params.saturate = 1;
%     peak_detector_params.hist_search_th = 0.9;
%     peak_detector_params.rpeak_search_wlen = 0.3; % MAX detectable HR (in BPM) = 60/rpeak_search_wlen
%     peak_detector_params.filter_type = 'MULT_MATCHED_FILTER';%'BANDPASS_FILTER', 'MATCHED_FILTER', 'MULT_MATCHED_FILTER'
%     peaks = PeakDetectionProbabilistic(ppecg, fs, peak_detector_params);
    peaks = find(PeakDetection20(ecg,hr/fs,.3));
%     figure
%     t=(1:length(ecg))/fs;
%     plot(t,ecg)
%     hold on 
%     plot(t(peaks),ecg(peaks),'r*')
    filename = [name{i}(1:end-4) '.csv'];
    writematrix(peaks,filename)
    
    
    
    
end

%% 5b. 
function hr = inst_hr(peaks,fs)
hr = 60.*fs./(peaks(2:end)-peaks(1:end-1));
end
% 
% function HR = smooth_hr(peaks, fs)
% hr = inst_hr(peaks,fs);
% 
% HR=zeros
% 










