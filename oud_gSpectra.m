function [] = oud_gSpectra(save)

filepath = uigetdir;
folders = dir(filepath);
% Get a logical vector that tells which is a directory.
dirFlags = [folders.isdir];
% Extract only those that are directories.
subFolders = folders(dirFlags);
% Print folder names to command window.
spectra_mat = 'PL_Spectra.mat';
chrono_mat = 'Chrono.mat';

z = [];
for k = 1 : length(subFolders)
    if(isequal(subFolders(k).name,'.') || isequal(subFolders(k).name,'..') )
        z=[z, k];
    end
end

z = sort(z, 'descend');

for i = z
    subFolders(i) = [];
end

if(isempty(subFolders))
    subFolders(1).name = '';
end


for k = 1 : length(subFolders)
    flag = 0;
    new_filepath = [filepath, '/', subFolders(k).name];
    fullpath_spectra = fullfile(new_filepath,spectra_mat);
    fullpath_chrono = fullfile(new_filepath,chrono_mat);
    
    if exist(fullpath_spectra, 'file')
        load(fullpath_spectra);
    else
        process_TDMS_spectra(new_filepath);
        load(fullpath_spectra);
    end
    
    if exist(fullpath_chrono, 'file')
        load(fullpath_chrono);
    else
        if(ispc)
            Files = strcat(new_filepath,'\*CHRONO*.DTA');
        else
            Files = strcat(new_filepath,'/*CHRONO*.DTA');
        end
        Files = dir(Files);
        
        if(isempty(Files))
            savename = oud_gamry(new_filepath);
            load(savename);
            flag = 1;
        else
            oud_chrono(new_filepath);
            load(fullpath_chrono);
            flag = 0;
        end
        
    end
    
    sol = exist('spectra','var');
    
    if(sol)
        [PL_res] = oud_PL(spectra);
    else
        [PL_res] = oud_PL(PL_Spectra);
    end
    
    close all;
    figure;
    
    if(flag)
        fig = plotyy(PL_res(:,3),PL_res(:,2),time,v,'plot');
    else
        fig = plotyy(PL_res(:,3),PL_res(:,2),time,vf,'plot');
    end
    
    if(save)
        save_path = [new_filepath,'/result.fig'];
        savefig(save_path);
    end
    
end

end