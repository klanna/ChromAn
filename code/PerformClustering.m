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
        
        DataFileOut = sprintf('%s_X_scale0tp', DataFileIn);

        %%
        Nclusters = size(ms, 2) - 2;
        [ score, l2dist ] = TryClusteringProcedures( sprintf('%s/clustering_%s', DataFolderPlot, DataFileOut), Nclusters, squeeze(ms(:, :, cline)) );

%         prompt = 'Enter number of clusters. Press 0 to finish.\n';
%         k = input(prompt);
%         while k
        for imethod = 1:size(l2dist, 2)
            k0 = max(5, DefineNumberOfClusters(l2dist(:, cline)));
            for j = -1:1
                k = k0+j;
                if (k < 9)
                    BestClustering( MotifsNames, sprintf('%s/CLUSTERED_%s', DataFolderPlot, DataFileOut), k, timepoints, squeeze(ms(:, :, cline)), dataRaw{cline} );
                end
            end
        end
%             k = input(prompt);
%         end
    end
    timeMin = toc(ts) / 60;
    fprintf('Time: %.1f min\n', timeMin);
end

function [k] = DefineNumberOfClusters(x)
    dx = -diff(x);
    eps = median(dx);
    k = min(find(dx < eps)) - 1;
end

