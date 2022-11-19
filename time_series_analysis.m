clc
clear
close all

%%%%%%
%% 4a.

files = dir('training2017\A00\*.mat');
name={files.name};
load(['training2017\A00\' name{5}]);
ecg = val;

%%% supose that the pover line frequency is known 

% method 1: using autocorrelation
samp_lag = 0:500; % time-lags in samples

%%% autocorrelation calculation ...
ECG = zeros(length(ecg)+length(samp_lag), length(samp_lag));
for i=1:length(samp_lag)
    ECG(1+samp_lag(i):length(ecg)+samp_lag(i), i) = ecg;
end
ac = ECG(:,1)'*ECG;

%%% find peaks
[~, peaks_loc] = findpeaks(ac);
peaks_loc = sort(peaks_loc);

%%% minimum distance of two neighbour peaks ...
min_d_peaks = min(peaks_loc(2:end)-peaks_loc(1:end-1), [], 'all');

%%% estimated fs
fs_1 = min_d_peaks*50;



% method 2: using PSD function of the signal
[pxx,w] = pwelch(ecg);
ind = find( (w>.3*pi) & (w<.4*pi));
pxx = pxx(ind);
w=w(ind);
[peaks_val, peaks_loc] = findpeaks(pxx);


% max jump in peaks --> sharp peaks
[~, psharp_ind] = max(peaks_val(2:end) - peaks_val(1:end-1));
peaks_sharp_w = w(psharp_ind)/pi;

fs_2=2*50/peaks_sharp_w;


%% 4b.

%%%% quantization level:
d=sort(ecg);
dd = d(2:end)-d(1:end-1);
dd=dd(dd~=0);
q_level = min(dd)/(max(d)-min(d));
n_bits = ceil(log2((max(d)-min(d))/q_level));


% 4c.












