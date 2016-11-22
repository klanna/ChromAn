function RunDiagnosticPlots( DataFileIn )
% prepares all diagnosti plots
    [ dataCellLines, timepoints, MotifsNames, CellLineNames ] = ReadDataFromCSV( DataFileIn ); % load data in matlab format
    [ msCellLines, ssCellLines, mdataCellLines, sdataCellLines, dataFCellLines ] = FilterData( DataFileIn );
    
    for i = 1:length(CellLineNames)
        fprintf('Analysing %s cell line\n', CellLineNames{i});
        DataFolderPlot = sprintf('plots/%s/%s/', DataFileIn, CellLineNames{i});
        if ~exist(DataFolderPlot, 'dir')
            mkdir(DataFolderPlot)
        end
        DataFilePlot = sprintf('%s/%s', DataFolderPlot, DataFileIn);

        data = squeeze(dataCellLines(:, :, :, i));
        dataI = squeeze(dataFCellLines(:, :, :, i));
        mdata = squeeze(mdataCellLines(:, :, i));
        sdata = squeeze(sdataCellLines(:, :, i));
        ms = squeeze(msCellLines(:, :, i));
        ss = squeeze(ssCellLines(:, :, i));

        %% plot diagnostic plot for the data
        DiagnosticPlot( MotifsNames, timepoints, dataI, mdata, sdata, sprintf('%s_filtered', DataFilePlot));
        DiagnosticPlot( MotifsNames, timepoints, data, mdata, sdata, sprintf('%s_original', DataFilePlot));
        DiagnosticPlot( MotifsNames, timepoints, [], mdata, sdata, sprintf('%s_clean', DataFilePlot));
        DataFileOut = sprintf('%s_X_scale0tp', DataFileIn);
        DataFilePlotOut = sprintf('%s/%s', DataFolderPlot, DataFileOut);
        DiagnosticPlot( MotifsNames, timepoints, [], ms, ss, sprintf('%s_scaled', DataFilePlotOut));
        
    end
end

