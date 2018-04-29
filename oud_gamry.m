function [savename] = oud_gamry(Files)

fPath = Files;
    if(ispc)
        Files = strcat(Files,'\*.DTA');
    else
        Files = strcat(Files,'/*.DTA');
    end
Files = dir(Files);

fileNames = {};
v = [];
a = [];

for i=1:size(Files,1)
    temp_name = strsplit(Files(i).name,'.DTA');
    %if strcmp(temp_name{1}, 'CHRO')
    if strfind(temp_name{1},'CHRONO') %changed from Contains function for backward compat
    else
       fileNames = [fileNames, fullfile(Files(i).folder,Files(i).name)];
       if(ispc)
           saveFile =  strcat(Files(i).folder,'\',temp_name,'.mat');
       else
           saveFile =  strcat(Files(i).folder,'/',temp_name,'.mat');
       end
    end
end

for file=fileNames

fid = fopen(file{1}, 'r');
if fid == -1, error('Cannot open %s for reading.', file{1}); end

for i=1:3
  s = fgetl(fid);
end

C = strsplit(fgetl(fid));
frequency = str2num(C{3});
frequency = 1/frequency;

for i=5:7
  s = fgetl(fid);
end

while ~feof(fid)
    C = strsplit(fgetl(fid));
    new_time = str2num(C{3});
    v = [v; str2num(C{2})];
    a = [a; str2num(C{3})];
end

time = (0:frequency:(size(v,1)-1)*frequency)';

fclose(fid);
end

savename = saveFile{1};

save(saveFile{1}, 'v','a','time');

end