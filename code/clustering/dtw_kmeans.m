function [idx, dd] = dtw_kmeans(data, k, varargin)
    N = size(data, 1);

    if ~isempty(varargin)
        centroids = varargin{1};
    else
        init_ind = randperm(N, k); % Q1.1
        centroids = data(init_ind, :);
    end
    

    % a vector containing the previous iteration's cluster indices
    % that will be used to check if the algorithm has converged.
    previous_idx = zeros(N, 1);

    iter = 1;
    while true
%         distances = pdist2(data, centroids, 'euclidean'); % Q1.2
        distances = mypdist2(data, centroids);
        
        [~, new_idx] = min(distances, [], 2); % Q1.3

        if all(previous_idx == new_idx)
            % cluster indices are the same as in the previous iteration -> convergence
            break; 
        else
            previous_idx = new_idx;
        end

        for j = 1:k
            centroids(j, :) = mean(data(new_idx==j, :), 1); % Q1.4
        end

        iter = iter + 1;
    end
%     fprintf('kmeans converged after %d iterations\n', iter)
    idx = new_idx;
    
    for i = 1:k
        dd(i) = var(distances(idx == i, i));
    end
end

function d = mypdist2(data, centroids)
    for i = 1:size(data, 1)
        for j = 1:size(centroids, 1)
            d(i, j) = dtw(data(i, :), centroids(j, :));
        end
    end
end