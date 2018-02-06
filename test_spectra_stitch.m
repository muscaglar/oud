i=1;
low = 2;
high = 3291;

name = 'negative_control';

s = (high-low)+2;


for ii = low:high
    fn = strcat('/Users/Mus/Downloads/101117/negative_control/101117_',num2str(ii,'%4i'),'_',name,'_Aquire_1.txt');

 if exist(fn, 'file') == 2
    fid = fopen(fn);
    M = textscan(fid, '%f%f', 'Delimiter',' ','HeaderLines',12); % you will need to change the number   of values to match your file %f for numbers and %s for strings.
    M = cell2mat(M);
    if(ii==low)
        spectra(:,1)= M(:,1);
    else
        spectra(:,i) = M(:,2);
    end
    
    fclose (fid);
 end
    i=i+1;
end

filename = strcat(name,'.mat');
save(filename, 'spectra');
clear;
clc;