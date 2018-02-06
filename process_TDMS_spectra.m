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
    
    if(any(size(dir([fileName.name '/*.tdms' ]),1)))
        [ ChannelData, metaStruct, PathName, FileName, NoFiles ] = ConcatentateRawData(fileName.name,[4 5]);%3 4
        i = 1;
        ind = 2;
        PL_Spectra(:,1) = ChannelData(1:1024,1);
        
        for i = 1025:1024:size(ChannelData,1)
            PL_Spectra(:,ind) = ChannelData(i:i+1023,2);
            ind = ind +1;
        end
        
        filename = strcat('PL_Spectra.mat');
        savePath = strcat(fileName.name,'\',filename);
        
        save(savePath, 'PL_Spectra');
    else
    end
end
end