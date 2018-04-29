function [data, tf] = oud_FFT_process(current, T, current2, T2)

fc = 0.5;
fs =  1/(T(2)-T(1));

[current] = oud_butterworth(fc, fs, current);

[data, tf] = oud_FFT(current,T,current2,T2);

end