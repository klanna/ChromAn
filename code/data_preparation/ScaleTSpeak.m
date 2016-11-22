function [ ms, ss ] = ScaleTSpeak( m, s )
% scale data on peak value
    [Nt, N] = size(m);
    for i = 1:N
        w = max(abs(m(:, i)));
        ms(:, i) = m(:, i) / w;
        ss(:, i) = s(:, i) / w;
    end
end

