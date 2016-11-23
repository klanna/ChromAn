function c = ClusterScore(idx)
    tbl = tabulate(idx);
    freq = tbl(:, 2);
    c = length(find(freq == 1));
end
