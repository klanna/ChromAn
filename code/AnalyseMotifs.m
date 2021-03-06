function AnalyseMotifs( DataFileIn )
    fprintf('AnalyseMotifs\n');
    
    fpath = regexprep(pwd, 'ChromAn/.*', 'ChromAn/');
    
    FolderNameOut = sprintf('%s/plots/%s', fpath, DataFileIn);    

    load(sprintf('%s/dataset_filtered.mat', FolderNameOut))
    load(sprintf('%s/dataset.mat', FolderNameOut));
    msCellLines = ms;
    
    [N_t, N_motifs, N_celllines] = size(msCellLines);
    
    DataFolderPlot = sprintf('%s/plots/%s/', fpath, DataFileIn);
    if ~exist(DataFolderPlot, 'dir')
        mkdir(DataFolderPlot)
    end
    
    DataFilePlot = sprintf('%s/%s_motifs', DataFolderPlot, DataFileIn);
    DiagnosticPlotMotifs( MotifsNames, timepoints, ms, CellLineNames, sprintf('%s', DataFilePlot));
    
    DataFolderPlot = sprintf('%s/plots/%s/cluster_motifs/', fpath, DataFileIn);
    if ~exist(DataFolderPlot, 'dir')
        mkdir(DataFolderPlot)
    end
    
    msCellLinesFitered = [];
    MotifsNamesFitered = {};
    SpecialList = [];
    for i = 1:N_motifs
        DataFilePlotOut = sprintf('%s_%s', DataFolderPlot, MotifsNames{i});
        ms = squeeze(msCellLines(:, i, :));
        [f, t] = FindOutstandingMotifs( DataFilePlotOut, ms );
        if f
            fprintf('Special (%s): %s (%s)\n', t, MotifsNames{i}, CellLineNames{f});
            msCellLinesFitered(:, end+1, :) = ms;
            MotifsNamesFitered{end+1} = sprintf('%s (%s %s)', MotifsNames{i}, CellLineNames{f}, t );
            SpecialList(end+1) = f;
        end
    end
    
    DiagnosticPlotMotifsFiltered( MotifsNamesFitered, timepoints, msCellLinesFitered, CellLineNames, SpecialList, sprintf('%s_filtered', DataFilePlot));
end

