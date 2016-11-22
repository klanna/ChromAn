function PerformClustering( DataFileIn )
    fprintf('---------Clustering cell-lines---------\n');
    fpath = regexprep(pwd, 'FellerCol/.*', 'FellerCol/');
    [ dataCellLines, timepoints, MotifsNames, CellLineNames ] = ReadDataFromCSV( DataFileIn ); % load data in matlab format

    [ ms ] = FilterData( DataFileIn );
    
    for i = 1:length(CellLineNames)
        fprintf('Analysing %s cell line\n', CellLineNames{i});
        DataFolderPlot = sprintf('%s/plots/%s/%s/', fpath, DataFileIn, CellLineNames{i});
        if ~exist(DataFolderPlot, 'dir')
            mkdir(DataFolderPlot)
        end
        DataFilePlot = sprintf('%s/%s', DataFolderPlot, DataFileIn);

        DataFileOut = sprintf('%s_X_scale0tp', DataFileIn);
        DataFilePlotOut = sprintf('%s/%s', DataFolderPlot, DataFileOut);

        %%
        Nclusters = size(ms, 2) - 2;
        [ ~, l2dist ] = TryClusteringProcedures( sprintf('%s/clustering_%s', DataFolderPlot, DataFileOut), Nclusters, squeeze(ms(:, :, i)) );

%         prompt = 'Enter number of clusters. Press 0 to finish.\n';
%         k = input(prompt);
%         while k
        for i = 1:size(l2dist, 2)
            k0 = DefineNumberOfClusters(l2dist(:, i));
            for j = 0:2
                k = k0+j;
                BestClustering( MotifsNames, sprintf('%s/CLUSTERED_%s', DataFolderPlot, DataFileOut), k, timepoints, squeeze(ms(:, :, i)) );
            end
        end
%             k = input(prompt);
%         end
    end
end

function [k] = DefineNumberOfClusters(x)
    dx = -diff(x);
    eps = median(dx);
    k = min(find(dx < eps)) - 1;
end

