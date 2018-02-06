function [savename] = temp_process_Gamry(file)

    time = [];
    vf  = [];
    im  = [];
    vu  = [];


split = strsplit(file,'/');
last_ele=split(:,end);
path = strsplit(file,last_ele);
path = path(1);

saveFile =  strcat(path,'Chrono','.mat');


fid = fopen(file, 'r');
if fid == -1, error('Cannot open %s for reading.', file{1}); end

for i=1:3
  s = fgetl(fid);
end

C = strsplit(fgetl(fid));
frequency = str2num(C{3});
frequency = 1/frequency;

for i=5:151
  s = fgetl(fid);
end

while ~feof(fid)
    C = strsplit(fgetl(fid));
    time = [time; str2num(C{3})];
    vf = [vf; str2num(C{4})];
    im = [im; str2num(C{5})];
    vu = [vu; str2num(C{6})];
end

time = (0:frequency:(size(time,1)-1)*frequency)';

fclose(fid);

savename = saveFile{1};

save(saveFile{1}, 'vf','im','vu','time');

end