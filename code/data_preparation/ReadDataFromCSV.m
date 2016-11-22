function [ data, timepoints, MotifsNames, CellLineNames ] = ReadDataFromCSV( ModelName )
% reads data from csv-files in one folder
% OUTPUT:
% data = [time, histone, replicate]
     
    fpath = regexprep(pwd, 'FellerCol/.*', 'FellerCol/');
    FolderName = sprintf('%s/data/%s', fpath, ModelName);
    FileOut = sprintf('%s/dataset.mat', FolderName);    
%     if ~exist(FileOut, 'file')
        
        listing = dir(FolderName);
        ListOfFileNames = {listing.name};
        CellLineNames = {};
        for i = 1:length(ListOfFileNames)
            FileToRead = ListOfFileNames{i};
            clear X
            if regexp(FileToRead, '.csv')
                try
                    X = csvread(sprintf('%s/%s', FolderName, FileToRead));
                catch
                    fid = fopen(sprintf('%s/%s', FolderName, FileToRead));
                    X0 = textscan(fid,'%s','delimiter',',');
                    X = X0{1};
                    fclose(fid);
                end
                if strcmp(FileToRead, 'timepoints.csv')
                    timepoints = X(1, :);
                elseif strcmp(FileToRead, 'Motif_IDs.csv')
                    MotifsNames = X;
                else
                    CellLineName = FileToRead(1:regexp(FileToRead, '_')-1);
                    cl = strmatch(CellLineName, CellLineNames, 'exact');
                    if isempty(cl)
                        cl = length(CellLineNames) + 1;
                        CellLineNames{cl} = CellLineName;
                    end
                    startI = regexp(FileToRead, 'rep') + 3;
                    endI = regexp(FileToRead, '.csv') - 1;
                    rep = str2num(FileToRead(startI:endI));
                    data(:, :, rep, cl) = X';
                end
            end
        end
        save(FileOut, 'data', 'timepoints', 'MotifsNames', 'CellLineNames')
%     else
%         load(FileOut)
%     end
end

