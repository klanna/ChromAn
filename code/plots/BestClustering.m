function BestClustering( ProteinNames, DataFilePlotOut, k, timepoints, ms )
    dd = ms';
    
    [clusteridx, ~, r] = kmeans(dd,k);
    ClusteringPlot( ProteinNames, timepoints, ms, clusteridx, sprintf('%s_kmeans_%u', DataFilePlotOut, k ));

    [dtw_clusteridx, ~] = dtw_kmeans(dd, k);
    ClusteringPlot( ProteinNames, timepoints, ms, dtw_clusteridx, sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));

    [clusteridx, C, r] = kmeans(dd,k);
    [dtwK_clusteridx, ~] = dtw_kmeans(dd, k, C);
    ClusteringPlot( ProteinNames, timepoints, ms, dtwK_clusteridx, sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k));
end

