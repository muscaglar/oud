function [] = oud_summaryFigs()

filepath = uigetdir;

if(ispc)
    files = rdir([filepath,'\*\*.mat']);
else
    files = rdir([filepath,'/*/*.mat']);
end
fileNames = [];
saveNames = [];
fig_saveNames = [];

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
    save_path = strcat(save_path,'.png');
    fig_save_path = strcat(save_path,'.fig');
    saveNames = [saveNames, save_path];
    fig_saveNames = [fig_saveNames, fig_save_path];
end

IndexC = strfind(fileNames, 'PL_Spectra');
Index = find(not(cellfun('isempty', IndexC)));
saveNames(Index) = [];
fig_saveNames(Index) = [];
if((2*size(Index,2))==size(files,1))
    %loop
    loop = linspace(1,size(files,1)-1,size(Index,2));
    for i = loop
        load(files(i).name);
        load(files(i+1).name);
        [PL_res] = plot_PL(PL_Spectra);
        close all;
        trace = figure;
        plotyy(PL_res(:,3),PL_res(:,2),result(:,1),result(:,2),'plot');
       % saveas(trace,saveNames{(i+1)/2})
        savefig(fig_saveNames{(i+1)/2})
        close all;
    end
else
    display('Something is wrong or the file structure is too complex')
end

%% Very useful code to remove cells contaiing...
% IndexC = strfind(fileNames, 'PL_Spectra');
% Index = find(not(cellfun('isempty', IndexC)));
%
% fileNames(Index) = [];
% saveNames(Index) = [];
% files(Index) = [];


end