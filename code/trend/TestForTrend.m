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
            for i = 1:Nrep
                dX(:, :, i) = diff(squeeze(X(:, :, i)));
            end
            for it = 1:Nt
                xx = reshape(squeeze(X(it, :, :)), [], 1);
                xx(xx <= -1) = [];
                xx(xx == 0) = [];
                mX{it} = xx;
            end
        else
            X = squeeze(dataRaw(:, idx, :)) - ones(Nt, Nrep);
            for i = 1:Nrep
                dX(:, i) = diff(squeeze(X(:, i)));
            end
            for it = 1:Nt
                xx = reshape(squeeze(X(it, :)), [], 1);
                xx(xx <= -1) = [];
                mX{it} = xx;
            end
        end
        
        
        dX(dX < 0) = -1;
        dX(dX > 0) = 1;
        X(1, :) = [];
                
        X = reshape(X, [], 1);
        X(X <= -1) = [];
        [h, p] = ttest(X);
%         [h1, p1] = swtest(X);
        
        figure('Name', 'test', 'visible', 'off')
        subplot(1, 2, 1)
        plot([1 Nt], [0 0], 'color', 'black')
        hold on
        for it = 1:Nt
            plot(it*ones(size(mX{it})), mX{it}, 'x')
            hold on
            h0(it) = ttest(mX{it}, 0.05/Nt);
        end
        h1 = max(h0);
        title(sprintf('h = %u, h1 = %u', h, h1))
        axis square
        subplot(1, 2, 2)
        hist(X)
        axis square
        
        hh(ci) = max(h, h1);
        pp(ci) = p;
        if ~h
            if abs(mean(X)) > 0.1
                h = 1;
            end            
        end
    end
end

