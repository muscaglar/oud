
function [fil_data] = oud_butterworth(fc, fs,type,data)

%fc= 100;%fc = 1.5; % Cut off frequency
%fs= 10000;%fs = 23.6407; % Sampling rate

[b,a] = butter(3,fc/(fs/2),type); % Butterworth filter of order 6

fil_data = filter(b,a,data); % Will be the filtered signal

% [res_x,res_y] = mySuperFFT(Vy,Vx,fil_y,x);
% B = smooth(res_y);
% [pks,locs]=findpeaks(res_y,'MINPEAKHEIGHT',3.5e-3);
% plot(res_x(locs), pks)
% [res_x,res_y] = mySuperFFT(Vy,Vx,fil_y,x);

end