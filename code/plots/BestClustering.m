function BestClustering( ProteinNames, DataFilePlotOut, clusteridx, timepoints, ms, dataRaw )
    c = ClusterScore(clusteridx);
    [ h, p ] = TestForTrend( dataRaw, clusteridx );
    if c < 4
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, clusteridx, 'on', DataFilePlotOut);
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, clusteridx, 'off', DataFilePlotOut);
        
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, clusteridx, 'on', DataFilePlotOut);
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, clusteridx, 'off', DataFilePlotOut);
        
        save(sprintf('%s.mat', DataFilePlotOut), 'clusteridx')
%         ClusteringPlotHist( ProteinNames, timepoints, ms, clusteridx, 'off', sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
    end
end

