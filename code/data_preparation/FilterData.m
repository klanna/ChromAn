function [ ms, ss, mdata, sdata, dataF ] = FilterData( DataFileIn )
% reads data from csv-files in one folder
% OUTPUT:
% data = [time, histone, replicate]
    fprintf('---------Filter data---------\n');
    fpath = regexprep(pwd, 'ChromAn/.*', 'ChromAn/');
    
    FolderNameOut = sprintf('%s/plots/%s', fpath, DataFileIn);    
    FileOut = sprintf('%s/dataset_filtered.mat', FolderNameOut);    
    
    if exist(FolderNameOut, 'dir')
        rmdir(FolderNameOut, 's')
    end
    
    mkdir(FolderNameOut)
    
    if ~exist(FileOut, 'file')
        [ dataCellLines, timepoints, MotifsNames, CellLineNames ] = ReadDataFromCSV( DataFileIn ); % load data in matlab format

        for i = 1:length(CellLineNames)
            fprintf('Analysing %s cell line\n', CellLineNames{i});
            DataFolderPlot = sprintf('%s/plots/%s/%s/', fpath, DataFileIn, CellLineNames{i});
            if ~exist(DataFolderPlot, 'dir')
                mkdir(DataFolderPlot)
            end
            DataFilePlot = sprintf('%s/%s', DataFolderPlot, DataFileIn);

            data = squeeze(dataCellLines(:, :, :, i));
            [ mdatai, sdatai, dataI] = InterpolateData( data );

            %% plot diagnostic plot for the data
            DiagnosticPlot( MotifsNames, timepoints, dataI, mdatai, sdatai, sprintf('%s_filtered', DataFilePlot));
            DiagnosticPlot( MotifsNames, timepoints, data, mdatai, sdatai, sprintf('%s_original', DataFilePlot));
            DiagnosticPlot( MotifsNames, timepoints, [], mdatai, sdatai, sprintf('%s_clean', DataFilePlot));

            DataFileOut = sprintf('%s_X_scale0tp', DataFileIn);
            DataFilePlotOut = sprintf('%s/%s', DataFolderPlot, DataFileOut);

            [ msi, ssi ] = ScaleTS0( mdatai, sdatai ); %scale time series for clustering
            DiagnosticPlotNormalized( MotifsNames, timepoints, [], msi, ssi, sprintf('%s_scaled', DataFilePlotOut));
            
            mdata(:, :, i) = mdatai;
            sdata(:, :, i) = sdatai;
            ms(:, :, i) = msi;
            ss(:, :, i) = ssi;
            dataF(:, :, :, i) = dataI;
        end
        
        save(FileOut, 'dataF', 'ms', 'ss', 'mdata', 'sdata')
    else
        load(FileOut)
    end
end

