function [ hh, pp ] = TestForTrend( dataRaw, clusteridx )
% h = 0 if there is data don't change
% 
    [Nt, ~, Nrep] = size(dataRaw);
    Nclusters = max(clusteridx);
    t = [1:Nt];
    
    for ci = 1:Nclusters
        clear dX
        idx = find(clusteridx == ci);
        if length(idx) > 1
            X = dataRaw(:, idx, :) - ones(Nt, length(idx), Nrep);
            for it = 2:Nt
                xx = reshape(squeeze(X(it, :, :)), [], 1);
                xx(xx <= -1) = [];
                xx(xx == 0) = [];
                mX{it-1} = xx;
            end
        else
            X = squeeze(dataRaw(:, idx, :)) - ones(Nt, Nrep);
            for it = 2:Nt
                xx = reshape(squeeze(X(it, :)), [], 1);
                xx(xx <= -1) = [];
                mX{it-1} = xx;
            end
        end

        X(1, :) = [];
                
        X = reshape(X, [], 1);
        X(X <= -1) = [];
        [h, p] = ttest(X);
        if length(idx) == 1
            h = 1;
        end
%         [h1, p1] = swtest(X);
        
        it = 1;
        while ~h && (it < Nt)
            h = ttest(mX{it}, 0.05/Nt);
            it = it + 1;
        end
        
        hh(ci) = h;
        pp(ci) = p;

    end
end

