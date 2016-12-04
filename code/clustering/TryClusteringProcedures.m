function [ score, dist_l2, ProcedureName, ClusterMatrix] = TryClusteringProcedures( DataFilePlotOut, Nclusters, ms )
% performs different ways of clustering
% Nclusters = maximal number of clusters
% ms data to cluster
    ProcedureName = {'kmeans', 'dtw_kmeans', 'dtw_kmeansC'};
    ClusterMatrix = zeros(size(ms, 2), Nclusters, 3);
    
    for k = 1:Nclusters
        [idx, C, r] = kmeans(ms',k);
        dist_l1(k, 1) = sum(r);
        dist_l2(k, 1) = sum(r.^2);
        score(k, 1) = ClusterScore(idx);
        ClusterMatrix(:, k, 1) = idx;
        
        [idx, distances] = dtw_kmeans(ms', k);
        dist_l1(k, 2) = sum(distances);
        dist_l2(k, 2) = sum(distances .^2);
        score(k, 2) = ClusterScore(idx);
        ClusterMatrix(:, k, 2) = idx;
        
        [idx, distances] = dtw_kmeans(ms', k, C);
        dist_l1(k, 3) = sum(distances);
        dist_l2(k, 3) = sum(distances .^2);
        score(k, 3) = ClusterScore(idx);
        ClusterMatrix(:, k, 3) = idx;
    end
    
    for i = 1:length(ProcedureName)
        d{i} = [VertVect(dist_l1(:, i)), VertVect(dist_l2(:, i))];
    end
    
    DistanceMeasurePlot( d, {'l1', 'l2'}, ProcedureName, DataFilePlotOut);
end


