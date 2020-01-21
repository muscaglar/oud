function [] = oud_botch(path)

[ConvertedData,ConvertVer,ChanNames,GroupNames,ci]=simpleConvertTDMS(0,path);
spectra = [ConvertedData.Data.MeasuredData(4).Data, ConvertedData.Data.MeasuredData(5).Data];
PL_Spectra = [];
for i = 1:1024:length(spectra)
    PL_Spectra = [PL_Spectra, [spectra(i:i+1023,2),spectra(i:i+1023,1)]];
end

upto = size(PL_Spectra,2);
j=1;
for i=1:2:upto
    [value,index] = max(PL_Spectra(:,i));
    PL_res(j,1) = PL_Spectra(index,i+1);
    PL_res(j,2) = value;
    PL_res(j,3) = i*0.045;%i/45;%(i*0.005)+1;
    j=j+1;
end

plot(PL_res(:,3),PL_res(:,2));

t = strsplit(path,'/');
path = strsplit(path,t{length(t)});

% path = strsplit(path,'.tdms');
% path = path{1};
path = [path{1},'/fixed_PL.mat'];

save(path,'PL_res');

% time = (0:1/100:length(result)/100);
% time(length(time))=[];
% plotyy(time,result(:,1),PL_res(:,3),PL_res(:,2))
% plotyy(result(:,1),result(:,2),PL_res(:,3),PL_res(:,2))
end