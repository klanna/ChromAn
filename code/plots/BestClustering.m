function BestClustering( ProteinNames, DataFilePlotOut, k, timepoints, ms, dataRaw )
    dd = ms';
    
    [clusteridx, ~, r] = kmeans(dd,k);
    c = ClusterScore(clusteridx);
    [ h, p ] = TestForTrend( dataRaw, clusteridx );
    if c < 4
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, clusteridx, 'on', sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, clusteridx, 'off', sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
        
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, clusteridx, 'on', sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, clusteridx, 'off', sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
        
        save(sprintf('%s_kmeans_%u', DataFilePlotOut, k ), 'clusteridx')
%         ClusteringPlotHist( ProteinNames, timepoints, ms, clusteridx, 'off', sprintf('%s_kmeans_%u', DataFilePlotOut, k ));
    end
    
    
    [dtw_clusteridx, ~] = dtw_kmeans(dd, k);
    c = ClusterScore(dtw_clusteridx);
    [ h, p ] = TestForTrend( dataRaw,  dtw_clusteridx );
    if c < 4
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, dtw_clusteridx, 'on', sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, dtw_clusteridx, 'off', sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));
        
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, dtw_clusteridx, 'on', sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, dtw_clusteridx, 'off', sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));
        
        save(sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k ), 'clusteridx')
%         ClusteringPlotHist( ProteinNames, timepoints, ms, dtw_clusteridx, 'off', sprintf('%s_dtw_kmeans_%u', DataFilePlotOut, k));
    end
    
    [clusteridx, C, r] = kmeans(dd,k);
    [dtwK_clusteridx, ~] = dtw_kmeans(dd, k, C);
    [ h, p ] = TestForTrend( dataRaw,  dtwK_clusteridx );
    c = ClusterScore(dtwK_clusteridx);
    if c < 4
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, dtwK_clusteridx, 'on', sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k) );
        ClusteringPlot( ProteinNames, timepoints, ms, h, p, dtwK_clusteridx, 'off', sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k));
        
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, dtwK_clusteridx, 'on', sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k) );
        ClusteringPlotZoomin( ProteinNames, timepoints, ms, h, p, dtwK_clusteridx, 'off', sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k));
        
        save(sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k ), 'clusteridx')
%         ClusteringPlotHist( ProteinNames, timepoints, ms, dtwK_clusteridx, 'off', sprintf('%s_dtwK_kmeans_%u', DataFilePlotOut, k));

    end
end

