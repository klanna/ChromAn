function [ mdata, sdata, dataI] = InterpolateData( data, varargin)
% get rid of dropouts for particular replicates and estimate moments
% ScaleFactor = varargin (default = 2). Remove ouliers by this factor
    data(data == -1) = 0;
    dataI = data;
    
    if ~isempty(varargin)
        ScaleFactor = varargin{1};
    else
        ScaleFactor = 2;
    end
    
    [N_t, N_hi, N_rep] = size(data);

    for hi = 1:N_hi
        for t = 1:N_t
            x = squeeze(data(t, hi, :));
            imis = find(x == 0);
            
            imis0 = imis;
            
            if t > 1
                for i = 1:length(x)
                    if ((abs(x(i)) > ScaleFactor*abs(mdata(t-1, hi))) || (abs(x(i)) < 1/ScaleFactor*abs(mdata(t-1, hi)))) && x(i)
                        imis(end+1) = i;
                    end
                end                
            end
            
            if length(imis) == N_rep
                clear imis
                imis = find(x == 0);
            end
            
            x0 = x;
            x0(imis0) = [];
            x(imis) = [];
            if ~isempty(x)
                mdata(t, hi) = mean(x);
            else
                if (t > 1)
                    mdata(t, hi) = mdata(t-1, hi);
                else
                    mdata(t, hi) = 0;
                end
            end
            sdata(t, hi) = std(x0) / sqrt(length(x0));
            dataI(t, hi, imis) = mdata(t, hi);
        end
    end
end

