function DiagnosticPlotNormalized( ProteinNames, timepoints, data, mdata, sdata, varargin)
% Plots Distribution of the data
    figname = 'DiagnosticPlotNormalized';
    
    if ~isempty(varargin)
        pic = 'off'; 
    else
        pic = 'on';
    end
    
    fig = figure('Name', figname, 'visible', pic);
    SetMyFigProps
    MarkerSize = 1;
    lwidth = 2;
    
    N_hi = size(mdata, 2);
    s = SubplotDimSelection(N_hi);
    t = 1:length(timepoints);
    
    for i = 1:N_hi
        subplot(s(1), s(2), i)
        m = mdata(:, i);
        ss = sdata(:, i);
        if ~isempty(data)
            plot(t, squeeze(data(:, i, :)), 'color', [92,192,192] / 255, 'MarkerSize', 0.5, 'LineWidth', 0.5)
            hold on
        end
        plot(t, m, '-red', 'MarkerSize', MarkerSize*3, 'LineWidth', lwidth)
        hold on
        plot(t, m + ss, ':black', 'MarkerSize', MarkerSize, 'LineWidth', lwidth)
        hold on
        plot(t, m - ss, ':black', 'MarkerSize', MarkerSize, 'LineWidth', lwidth)
        title(ProteinNames{i},'interpreter','none')
        xlabel('time, h')
        xlim([min(t) max(t)])
        if isempty(data)
            ylim([min(min(mdata)) max(max(mdata))])
        end
        
        set(get(gca,'xlabel'),'FontSize', FSize);
        set(get(gca,'ylabel'),'FontSize', FSize);
        set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');
        
        set(gca,'XTick', t, 'XTickLabel', arrayfun(@num2str, timepoints, 'UniformOutput', false), 'FontSize', FSize)
    end
    
    if ~isempty(varargin)
        fname = varargin{1};
        size1 = 20;
        PDFprint(sprintf('%s_%s', fname, figname),  fig, size1, size1);
    end
end

