function [] = process_Chrono_Gamry(Files)

%Files =  dir('C:\Users\mc934\Dropbox\PhD\Experimental\QDot_field_spectra\071217\run28_dye\CHRONOA*.DTA')
fPath = Files;
if(ispc)
    Files = strcat(Files,'\*CHRONO*.DTA');
else
    Files = strcat(Files,'/*CHRONO*.DTA');
end
Files = dir(Files);

fileNames = {};
time = [];
vf = [];
im = [];
vu = [];

for i=1:size(Files,1)
    if(ispc)
        fileNames = [fileNames,strcat(fPath,'\',Files(i).name)];
    else
        fileNames = [fileNames,strcat(fPath,'/',Files(i).name)];
    end
end

for file=fileNames
    
    fid = fopen(file{1}, 'r');
    if fid == -1, error('Cannot open %s for reading.', file{1}); end
    
    for i=1:62
        s = fgetl(fid);
    end
    
    if isempty(time)
        adder = 0;
    else
        adder = time(end);
    end
    
    while ~feof(fid)
        C = strsplit(fgetl(fid));
        new_time = str2num(C{3})+adder;
        time = [time; new_time];
        vf = [vf; str2num(C{4})];
        im = [im; str2num(C{5})];
        vu = [vu; str2num(C{6})];
    end
    
    fclose(fid);
end

if(ispc)
    filename = strcat(fPath,'\Chrono.mat');
else
    filename = strcat(fPath,'/Chrono.mat');
end

save(filename, 'time','vf','im','vu');

end