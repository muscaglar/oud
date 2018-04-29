function [] = oud_process()

filepath = uigetdir;

if(ispc)
        files1 = rdir([filepath,'\*.dta']);
        files2 = rdir([filepath,'\*.DTA']);
        files = [files1, files2];
else
        files1 = rdir([filepath,'/*.dta']);
        files2 = rdir([filepath,'/*.DTA']);
        files = [files1, files2];
end

fileNames = [];
saveNames = [];

for i=1:size(files,1)
    
    if (ispc)
        split_result = strsplit(files(i).name,'\');
    else
        split_result = strsplit(files(i).name,'/');
    end
    
    split_result = fliplr(split_result);
    split_result = strsplit(split_result{1},'.dta');
    fileNames = [fileNames, split_result(1) ];
    
    save_path = strsplit(files(i).name,'.dta');
    save_path = save_path(1);
    save_path = strcat(save_path,'.mat');
    saveNames = [saveNames, save_path];
end

for i=1:size(files,1)
result = oud_txt2mat(files(i).name);
save(saveNames{i}, 'result');
end

end