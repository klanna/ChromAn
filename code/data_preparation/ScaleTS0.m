function [ ms, ss ] = ScaleTS0( m, s )
% scale data on the value at zero time point
    [Nt, N] = size(m);
    for i = 1:N
        w = abs(m(1, i));
        if ~w
            w = 1;
        end
        ms(:, i) = m(:, i) / w;
        ss(:, i) = s(:, i) / w;
    end
end

