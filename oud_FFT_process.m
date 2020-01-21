function [data] = oud_FFT_process(current, T, current2, T2)

fc = 0.5;
fs =  1/(T(2)-T(1));
fs2 =  1/(T2(2)-T2(1));

[current] = oud_butterworth((fs-1)/2, fs,'low', current);
[current] = oud_butterworth(fc, fs,'high', current);


[current2] = oud_butterworth((fs2-1)/2, fs2,'low', current2);
[current2] = oud_butterworth(fc, fs2,'high', current2);


[data] = oud_FFT(current,T,current2,T2);

end