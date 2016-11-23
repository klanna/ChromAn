function BestClustering( ProteinNames, DataFilePlotOut, k, timepoints, ms )
    dd = ms';
    
    [clusteridx, ~, r] = kmeans(dd,k);
    c = ClusterScore(clusteridx);
    if c < 3
        ClusteringPlot( ProteinNames, timepoints, ms, clusteridx, sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
    end
    
    
    [dtw_clusteridx, ~] = dtw_kmeans(dd, k);
    c = ClusterScore(dtw_clusteridx);
    if c < 3
        ClusteringPlot( ProteinNames, timepoints, ms, dtw_clusteridx, sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));
    end
    
    [clusteridx, C, r] = kmeans(dd,k);
    [dtwK_clusteridx, ~] = dtw_kmeans(dd, k, C);
    c = ClusterScore(dtwK_clusteridx);
    if c < 3
        ClusteringPlot( ProteinNames, timepoints, ms, dtwK_clusteridx, sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k));
    end
end

