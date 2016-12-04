function PerformClustering( DataFileIn )
    ts = tic;
    fprintf('---------Clustering cell-lines---------\n');
    fpath = regexprep(pwd, 'ChromAn/.*', 'FellerCol/');

    FolderNameOut = sprintf('%s/plots/%s', fpath, DataFileIn);    

    load(sprintf('%s/dataset_filtered.mat', FolderNameOut))
    load(sprintf('%s/dataset.mat', FolderNameOut))
    
    Nclines = length(CellLineNames);
    
    for cline = 1:Nclines
        fprintf('Clustering %s cell line\n', CellLineNames{cline});
        DataFolderPlot = sprintf('%s/plots/%s/%s/', fpath, DataFileIn, CellLineNames{cline});
        
        if ~exist(DataFolderPlot, 'dir')
            mkdir(DataFolderPlot)
        end        
        %%
        Nclusters = size(ms, 2) - 2;
        [ score, l2dist, ProcedureName, ClusterMatrix ] = TryClusteringProcedures( sprintf('%s/%s', DataFolderPlot, DataFileIn), Nclusters, squeeze(ms(:, :, cline)) );

        for imethod = 1:length(ProcedureName)
            k0 = max(5, DefineNumberOfClusters(l2dist(:, cline)));
            for j = -1:1
                k = k0+j;
                DataFileOut = sprintf('%s_%s_%u', DataFileIn, ProcedureName{imethod}, k);
                BestClustering( MotifsNames, sprintf('%s/%s_%u', DataFolderPlot, DataFileOut, k), squeeze(ClusterMatrix(:, k, imethod)), timepoints, squeeze(ms(:, :, cline)), dataRaw{cline} );
            end
        end
    end
    timeMin = toc(ts) / 60;
    fprintf('Time: %.1f min\n', timeMin);
end

function [k] = DefineNumberOfClusters(x)
    dx = -diff(x);
    eps = median(dx);
    k = min(find(dx < eps)) - 1;
end

