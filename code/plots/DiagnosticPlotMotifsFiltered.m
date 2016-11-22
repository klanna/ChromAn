function DiagnosticPlotMotifsFiltered( MotifNames, timepoints, data, CellLineNames, SpecialList, varargin)
% Plots Distribution of the data
    figname = 'DiagnosticPlotMotifs';
    
    if ~isempty(varargin)
        pic = 'off'; 
    else
        pic = 'on';
    end
    
    fig = figure('Name', figname, 'visible', pic);
    SetMyFigProps
    MarkerSize = 1;
    lwidth = 2;
    
    N_motifs = size(data, 2);
    s = SubplotDimSelection(N_motifs+1);
    t = 1:length(timepoints);
    
    for i = 1:N_motifs
        subplot(s(1), s(2), i)
        for j = 1:size(data, 3)
            if j == SpecialList(i)
                plot(t, squeeze(data(:, i, j)), '--', 'color', MyColor(j, :), 'MarkerSize', 0.5, 'LineWidth', 0.5)
            else
                plot(t, squeeze(data(:, i, j)), 'color', MyColor(j, :), 'MarkerSize', 0.5, 'LineWidth', 0.5)
            end
            hold on 
                
        end
        
        title(MotifNames{i},'interpreter','none')
        xlabel('time, h')
        xlim([min(t) max(t)])
        
        set(get(gca,'xlabel'),'FontSize', FSize);
        set(get(gca,'ylabel'),'FontSize', FSize);
        set(get(gca,'title'),'FontSize', FSize, 'FontWeight', 'Bold');
        
        set(gca,'XTick', t, 'XTickLabel', arrayfun(@num2str, timepoints, 'UniformOutput', false), 'FontSize', FSize)
    end
    subplot(s(1), s(2), i+1)
    for j = 1:size(data, 3)
        plot([0 1], [0 1], 'color', MyColor(j, :), 'MarkerSize', 0.5, 'LineWidth', 0.5)
        hold on 
    end
%     plot([0 1], zeros(length(CellLineNames), 2), 'MarkerSize', 0.5, 'LineWidth', 0.5)
    xlabel('time, h')
    xlim([min(t) max(t)])

    legend(CellLineNames)
    
    
    if ~isempty(varargin)
        fname = varargin{1};
        size1 = 20;
        PDFprint(sprintf('%s_%s', fname, figname),  fig, size1, size1);
    end
end

