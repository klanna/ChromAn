function [f, typef]= FindOutstandingMotifs( DataFilePlotOut, ms )
%FINDOUTSTANDINGMOTIFS Summary of this function goes here
%   Detailed explanation goes here
    Nclusters = 2;
    f = 0;
    dd = ms';
    typef = 'conserved';
    
    for k = 1:Nclusters
%         
        [C, ~, distances] = kmeans(dd,k);
        dist_l1(k) = sum(distances);
        dist_l2(k) = sum(distances .^2);
        d = [VertVect(dist_l2)];
        
        ClusterSize = [];
        for i = 1:k
            ClusterSize(i) = length(find(C == i));            
            if (ClusterSize(i) == 1) && (d(1) > 2*d(2))
                [Cdtw, distances] = dtw_kmeans(dd, k);
                ClusterSizeDTW = [];
                for j = 1:k
                    ClusterSizeDTW(j) = length(find(Cdtw == j));                     
                    if (ClusterSizeDTW(j) == 1)
                        f = find(Cdtw == j);
                        typef = 'completely';
                    else
                        f = find(C == i);
                        typef = 'time shift';
                    end
                end
                
            end
        end 
    end
%     DistanceMeasurePlot( {d}, {'l2'}, {'kmenas_dtw'}, DataFilePlotOut);
end

