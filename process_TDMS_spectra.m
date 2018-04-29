function [] = process_TDMS_spectra(Paths)

%Paths = dir('C:\Users\mc934\Dropbox\PhD\Experimental\QDot_field_spectra\071217\run*');
Paths = rdir(Paths);

fileNames = {};

% for i=1:size(Paths,1)
%     if(Paths(i).isdir == 1)
%     fileNames = [fileNames, fullfile(Paths(i).folder,Paths(i).name)];
%     end
% end

% for fileName=fileNames
for k=1:length(Paths)
    fileName=Paths(k);
    total = strsplit(fileName.name,'.');
    extension = total{2};
    name = strsplit(total{1},'\');
    element = size(name,2);
    name = name{element};
    
    
    
    if(strcmpi(extension,'tdms'))%any(size(dir([fileName.name '\*.tdms' ]),1)))
        extended_name = [name,'.',extension];
        total = strsplit(fileName.name,extended_name);
        FolderPath = total{1};
        [ ChannelData, metaStruct, PathName, FileName ] = LoadTDMSData([4 5],extended_name, FolderPath);%ConcatentateRawData(fileName.name,[2 3]);%3 4
        i = 1;
        ind = 2;
        PL_Spectra(:,1) = ChannelData(1:1024,1);
        
        for i = 1025:1024:size(ChannelData,1)
            PL_Spectra(:,ind) = ChannelData(i:i+1023,2);
            ind = ind +1;
        end
        
        filename = strcat(name,' PL_Spectra.mat');
        savePath = strcat(FolderPath,filename);
        
        save(savePath, 'PL_Spectra');
    else
    end
end
end