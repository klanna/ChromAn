% data = [time, histone, replicate] 
% DataFileIn = '20082016'; % name of the folder with data
Start

DataFileIn = 'Dataset_MG20161118'; % name of the folder with data

FilterData( DataFileIn ); % including making diagnostic plots

PerformClustering( DataFileIn ); % analyse cell-lines individually

%% analyse motifs across cell-lines

AnalyseMotifs( DataFileIn );