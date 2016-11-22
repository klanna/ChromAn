function DistanceMeasurePlot( d, legendname, titlenameset, varargin)
    
    if ~isempty(varargin)
        pic = 'off'; 
    else
        pic = 'off';
    end
    
    fig = figure('Name', 'clustring', 'visible', pic);
    SetMyFigProps
    MarkerSize = 1;
    lwidth = 2;
    
    Nmethods = length(titlenameset);
    
    for i = 1:Nmethods
        subplot(1, Nmethods, i)
        dd = d{i};        
        
        x = 1:size(dd, 1);
        plot(x, dd, 'MarkerSize', MarkerSize, 'LineWidth', lwidth)

        xlabel('# clusters')
        xlim([min(x) max(x)+1])
        
        title(titlenameset{i},'interpreter','none')
        
        legend(legendname)

        set(get(gca,'xlabel'),'FontSize', FSize);
        set(get(gca,'ylabel'),'FontSize', FSize);
        set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');

        set(gca,'XTick', x, 'XTickLabel', arrayfun(@num2str, x, 'UniformOutput', false), 'FontSize', FSize)
    end
    
    if ~isempty(varargin)
        fname = varargin{1};
        size1 = 10;
        PDFprint(sprintf('%s', fname),  fig, size1, size1);
    end
end

