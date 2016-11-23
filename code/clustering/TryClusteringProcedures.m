function [ score, dist_l2, ProcedureName ] = TryClusteringProcedures( DataFilePlotOut, Nclusters, ms )
% performs different ways of clustering
% Nclusters = maximal number of clusters
% ms data to cluster
    dd = ms';
    ProcedureName = {'kmeans', 'dtw_kmeans', 'dtw_kmeansC'};
    
    for k = 1:Nclusters
        [idx, C, r] = kmeans(dd,k);
        dist_l1(k, 1) = sum(r);
        dist_l2(k, 1) = sum(r.^2);
        score(k, 1) = ClusterScore(idx);
        
        [idx, distances] = dtw_kmeans(dd, k);
        dist_l1(k, 2) = sum(distances);
        dist_l2(k, 2) = sum(distances .^2);
        score(k, 2) = ClusterScore(idx);
        
        [~, distances] = dtw_kmeans(dd, k, C);
        dist_l1(k, 3) = sum(distances);
        dist_l2(k, 3) = sum(distances .^2);
        score(k, 3) = ClusterScore(idx);
    end
    
    for i = 1:length(ProcedureName)
        d{i} = [VertVect(dist_l1(:, i)), VertVect(dist_l2(:, i))];
    end
    
    DistanceMeasurePlot( d, {'l1', 'l2'}, ProcedureName, DataFilePlotOut);
    
end


