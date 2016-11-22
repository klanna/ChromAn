function [ data, timepointsUnique, ReplicateListUnique ] = ParseData( Names, ReplicateList, RelativeTimeSeriesRaw )
% Parses data into appropriate structure:
% data = [time, histone, replicate] 
    ReplicateListUnique = unique(ReplicateList);
    Nreps = length(ReplicateListUnique);
    
    for i = 1:length(Names)
        CurName = Names{i};
        tp = CurName(regexp(CurName, '[0-9]*h'):regexp(CurName, 'h')-1);
        if isempty(tp)
            tp = '0';
        end
        timepoints(i) = str2num(tp);
    end
    timepointsUnique = unique(timepoints);
    N_T = length(timepointsUnique);
    
    for i = 1:length(Names)
        t = find(timepointsUnique == timepoints(i));
        r = find(strcmp(ReplicateListUnique, ReplicateList{i}));
        data(t, :, r) = RelativeTimeSeriesRaw(i, :);
    end

end

