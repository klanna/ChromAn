function AnalyseTrend( DataFileIn )
    ts = tic;
    fprintf('---------Analyse Trend cell-lines---------\n');
    fpath = regexprep(pwd, 'ChromAn/.*', 'FellerCol/');

    FolderNameOut = sprintf('%s/plots/%s', fpath, DataFileIn);    

    load(sprintf('%s/dataset_filtered.mat', FolderNameOut))
    load(sprintf('%s/dataset.mat', FolderNameOut))
    
    [Nt, Nhist, Nrep, Nclines] = size(dataF);
    t = 1:length(timepoints);
%     MotifsNames
    for cline = 1:Nclines
        figname = CellLineNames{cline};
        fprintf('Analyse Trend %s cell line\n', figname);
        DataFolderPlot = sprintf('%s/plots/%s/%s/', fpath, DataFileIn, CellLineNames{cline});
        
        if ~exist(DataFolderPlot, 'dir')
            mkdir(DataFolderPlot)
        end
        
        DataFileOut = sprintf('%s/%s_trend', DataFolderPlot, DataFileIn);
        
        fig = figure('Name', figname, 'visible', 'off');
        SetMyFigProps
        MarkerSize = 1;
        lwidth = 2;
        size1 = 20;
        s = SubplotDimSelection(Nhist);
        y1 = min(min(min(dataFs(:, :, :, cline))));
        y2 = max(max(max(dataFs(:, :, :, cline))));
        for hi = 1:Nhist
            X0 = squeeze(dataFs(:, hi, :, cline));
            m0 = mean(X0, 2);
            for rep = 1:Nrep
                xx(:, rep) = X0(:, rep) - m0;
            end
            ss = std(reshape(xx, [], 1));
            X = squeeze(dataRaw(:, hi, :, cline)) - ones(Nt, Nrep); % data = [time, histone, replicate]
            X(1, :) = [];
            X = reshape(X, [], 1);
            X(X < -1) = [];
%             [h,p] = kstest(X);
            
%             [h,p] = swtest(X);
            [h,p] = ztest(X, 0, ss);
            
            subplot(s(1), s(2), hi)
            plot(t, X0, 'color', [92,192,192] / 255, 'MarkerSize', 0.5, 'LineWidth', 0.5)
            hold on
            
            title(MotifsNames{hi}, 'interpreter','none')
            xlabel('time, h')
            xlim([min(t) max(t)])
            ylim([y1 y2])
            
            legend(sprintf('h = %u (p = %.1e)', h, p), 'location', 'southoutside')
    %         if isempty(data)
    %             ylim([min(min(mdata)) max(max(data))])
    %         end

            set(get(gca,'xlabel'),'FontSize', FSize);
            set(get(gca,'ylabel'),'FontSize', FSize);
            set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');
            axis square

            set(gca,'XTick', t, 'XTickLabel', arrayfun(@num2str, timepoints, 'UniformOutput', false), 'FontSize', FSize)
        end
                
        PDFprint(sprintf('%s_%s', DataFileOut, figname),  fig, size1, size1);
    end
        %%
    timeMin = toc(ts) / 60;
    fprintf('Time: %.1f min\n', timeMin);
end


