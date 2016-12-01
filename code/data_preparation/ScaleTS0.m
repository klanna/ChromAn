function [ dataIs ] = ScaleTS0( m )
% scale data on the value at zero time point
    [Nt, Nhi, N] = size(m);
    dataIs = m;
    for hi = 1:Nhi
        for i = 1:N
            w = abs(squeeze(m(1, hi, i)));
            dataIs(:, hi, i) = squeeze(m(:, hi, i)) / w;
        end
    end
end

