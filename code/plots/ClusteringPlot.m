function ClusteringPlot( ProteinNames, timepoints, data, clusteridx, varargin)
    figname = 'Clustering';
    Nc = max(clusteridx);
    
    if ~isempty(varargin)
        pic = 'off'; 
    else
        pic = 'on';
    end
    
    fig = figure('Name', figname, 'visible', pic);
    SetMyFigProps
    MarkerSize = 1;
    lwidth = 2;
    
    s = SubplotDimSelection(Nc);
    t = 1:length(timepoints);
    
    for i = 1:Nc
        subplot(s(1), s(2), i)
        idx = find(clusteridx == i);
        m = data(:, idx);

        plot(t, m, 'MarkerSize', MarkerSize, 'LineWidth', lwidth)
        
        hold on
        
        plot(t, mean(m, 2), ':black', 'MarkerSize', 1, 'LineWidth', lwidth*2)

        title(sprintf('cluster %u', i),'interpreter','none')
        xlabel('time, h')
        xlim([min(t) max(t)])
        
        set(get(gca,'xlabel'),'FontSize', FSize);
        set(get(gca,'ylabel'),'FontSize', FSize);
        set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');
        
        legend(ProteinNames(idx),'interpreter','none', 'location', 'bestoutside')
        
        set(gca,'XTick', t, 'XTickLabel', arrayfun(@num2str, timepoints, 'UniformOutput', false), 'FontSize', FSize)
    end
    
    if ~isempty(varargin)
        fname = varargin{1};
        size1 = 40;
        PDFprint(sprintf('%s', fname),  fig, size1, size1/4);
    end
end

