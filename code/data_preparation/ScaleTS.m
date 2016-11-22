function [ ms, ss ] = ScaleTS( m, s )
    [Nt, N] = size(m);
    for i = 1:N
        w = max(abs(m(:, i)));
        ms(:, i) = m(:, i) / w;
        ss(:, i) = s(:, i) / w;
    end
end

