function ClusteringPlotHist( ProteinNames, timepoints, data, clusteridx, legendflag, varargin)
    figname = 'ClusteringHist';
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
        hh = reshape(diff(m), [], 1);
        [h,p] = kstest(hh);
        
        hist(hh)
        hold on        

        title(sprintf('cluster %u (h = %u)', i, h),'interpreter','none')
        axis square
        
        set(get(gca,'xlabel'),'FontSize', FSize);
        set(get(gca,'ylabel'),'FontSize', FSize);
        set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');

        set(gca,'XTick', t, 'XTickLabel', arrayfun(@num2str, timepoints, 'UniformOutput', false), 'FontSize', FSize)
    end
    
    if ~isempty(varargin)
        fname = varargin{1};
        size1 = 40;
        PDFprint(sprintf('%s_%s_%s', fname, figname, legendflag),  fig, size1, size1*s(1)/2);
    end
end

