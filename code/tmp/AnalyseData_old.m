% ReadData
% data = [time, histone, replicate] 

DataFileIn = 'datatest'; % name of the file with data
DataFolderPlot = sprintf('plots/%s/', DataFileIn);
if ~exist(DataFolderPlot, 'dir')
    mkdir(DataFolderPlot)
end
DataFilePlot = sprintf('%s/%s', DataFolderPlot, DataFileIn);

load(sprintf('%s.mat', DataFileIn))

[ data, timepoints ] = ParseData( Names, ReplicateList, RelativeTimeSeriesRaw ); % data = [time, histone, replicate] 
[ mdata, sdata, dataI] = InterpolateData( data );

%% plot diagnostic plot for the data
DiagnosticPlot( ProteinNames, timepoints, dataI, mdata, sdata, sprintf('%s_filtered', DataFilePlot));
DiagnosticPlot( ProteinNames, timepoints, data, mdata, sdata, sprintf('%s_original', DataFilePlot));
DiagnosticPlot( ProteinNames, timepoints, [], mdata, sdata, sprintf('%s_clean', DataFilePlot));

%%
DataFileOut = sprintf('%s_X_scale0tp', DataFileIn);
DataFilePlotOut = sprintf('%s/%s', DataFolderPlot, DataFileOut);
%%
[ ms, ss ] = ScaleTS0( mdata, sdata ); %scale time series for clustering
DiagnosticPlot( ProteinNames, timepoints, [], ms, ss, sprintf('%s_scaled', DataFilePlotOut));
%%
Nclusters = 10;
[ ProcedureName ] = TryClusteringProcedures( sprintf('%s/clustering_%s', DataFolderPlot, DataFileOut), Nclusters, ms );
%%
for k = [6 7]
    BestClustering( ProteinNames, sprintf('%s/CLUSTERED_%s', DataFolderPlot, DataFileOut), k, timepoints, ms );
end