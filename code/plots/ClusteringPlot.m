function ClusteringPlot( ProteinNames, timepoints, data, h, p, clusteridx, legendflag, varargin)
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
    
    s(1) = ceil(Nc / 2);
    s(2) = 2;
%     s = SubplotDimSelection(Nc);
    t = 1:length(timepoints);
    
    x1 = min(t);
    x2 = max(t);
    
    y1 = min(min(data));
    y2 = max(max(data));
    
    for i = 1:Nc
        subplot(s(1), s(2), i)
        idx = find(clusteridx == i);
        m = data(:, idx);        
        
        plot(t, m, 'MarkerSize', MarkerSize, 'LineWidth', lwidth)
        
        hold on
        
        plot(t, mean(m, 2), ':black', 'MarkerSize', 1, 'LineWidth', lwidth*2)

        title(sprintf('cluster %u (h = %u, p = %.1e)', i, h(i), p(i)),'interpreter','none')
%         title(sprintf('cluster %u', i ),'interpreter','none')
        xlabel('time, h')
        xlim([x1 x2])
        ylim([y1 y2])
        axis square
        
        set(get(gca,'xlabel'),'FontSize', FSize);
        set(get(gca,'ylabel'),'FontSize', FSize);
        set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');
        if strcmp(legendflag, 'on')
            legend(ProteinNames(idx),'interpreter','none', 'location', 'southoutside')
        end
        set(gca,'XTick', t, 'XTickLabel', arrayfun(@num2str, timepoints, 'UniformOutput', false), 'FontSize', FSize)
    end
    
    if ~isempty(varargin)
        fname = varargin{1};
        size1 = 40;
        PDFprint(sprintf('%s_%s_%s', fname, figname, legendflag),  fig, size1, size1);
    end
end

