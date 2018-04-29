function [data, data2] = oud_FFT(current, T, current2, T2)

sFreq = 1/(T(2)-T(1));

%T = 1/sFreq;
L = length(current);

n = 2^nextpow2(L);
dim = 1;
y = fft(current,n,dim);
P2 = abs(y/n);
P1 = P2(1:(n/2)+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);

rX = 0:(sFreq/n):(sFreq/2-sFreq/n);
rY = P1(1:n/2,1);
figure;
plot(rX,rY);

data = [rX',rY];

sFreq = 1/(T2(2)-T2(1));

%T = 1/sFreq;
L = length(current2);

n = 2^nextpow2(L);
dim = 1;
y = fft(current2,n,dim);
P2 = abs(y/n);
P1 = P2(1:(n/2)+1,:);
P1(2:end-1,:) = 2*P1(2:end-1,:);

rX = 0:(sFreq/n):(sFreq/2-sFreq/n);
rY = P1(1:n/2,1);
figure;
plot(rX,rY);
data2 = [rX',rY];
[dataAll, tf] = padcat(data(:,1),data(:,2),data2(:,1),data2(:,2));
dataAll(~tf) = ''; % change the padding value into 99

% ORG = Matlab2OriginPlot();
% ORG.MatrixToOrigin(data, 'FFT');

end


