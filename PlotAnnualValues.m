%
%   Plots seasonal and annual data with multiple axis frame

%   @param, annual_values: It is the cell array of annual calculated variables (tables), which must be in a
%   specified order with ssp245 values first and then ssp370 values

%   @param, seasonal_values: It is the cell array of seasonal calculated variables (tables), which must be in a
%   specified order with ssp245 values followed by ssp370 variables

%   example = annual_values = {ann_r1i1p1f1css245, ann_r1i1p1f1ess245, ann_r1i1p1f1wss245, ann_r1i1p1f1gom245, ann_r1i1p1f1css370, ann_r1i1p1f1ess370, ann_r1i1p1f1wss370, ann_r1i1p1f1gom370 };
%

function PlotAnnualValues(annual_values, bi_dec_ann, plot_details)
   
    
    figure('Units', 'inches', 'rend','painters','pos',[0 0 8.25 11.75]);
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8.25 11.75]);
%     alphabets = {"a", "b", "c", "d", "e"};
    model_len = length(plot_details('models'));
    models = plot_details('models');
    variables = plot_details('variables');
    t = annotation('textbox');
    t.String = plot_details('letter');
    t.Position = [0.03 0.95 0.05 0.036];
    t.FontSize = 17;

    lx = 0.02; ly = 0.9; lw = 0.03; lh = 0.10; moveDown = 0.16;
    x = 0.145; y = 0.74; w = 0.836; h = 0.14; 
    
    for j=1:model_len
        ly = ly - 0.16;
        axes('position',[lx ly lw lh]);
        text(0.3,0.5, getAdjustedString(models{j}, 7),'fontsize',10,'fontweight','bold','color','k');
        axis('off');
    end
    
%     Axis and plotting annual and seasonal values
    axes('position',[x y w h]);
    plotHistoricalAndSSPValues(filterValues(annual_values, plot_details, 1), 'mean');
    plotBidecadalLine(filterValues(bi_dec_ann, plot_details, 1), plot_details('bi_hist_stryr'), plot_details('bi_ssp_stryr'));
    grid on;
    grid minor;
    l = legend('show');
    l.Position = [0.81 0.92 0.017 0.05];
    l.Title.String = 'Region (Experiment)';
    l.Title.FontSize = 6;
    l.FontSize = 6;
    l.NumColumns = 2;
    hist_stryr = plot_details('hist_stryr');
    ssp_endyr = plot_details('ssp_endyr');
    t = title(["sob", "Historical, ssp245 &", "ssp370," + hist_stryr + "-" + ssp_endyr]);
    t.FontSize = 11;
    ylimits = calculateYLimitsAnnual(annual_values, plot_details, 'mean', model_len);
    axP = get(gca,'Position');
    set(gca, 'Position', axP);
   
    xlim([hist_stryr, ssp_endyr]);
    ylim(ylimits{1});
    
    if model_len > 1
        for i=2:model_len
            y = y - moveDown; 
            axes('position',[x y w h]);
            plotHistoricalAndSSPValues(filterValues(annual_values, plot_details, i), 'mean');
            plotBidecadalLine(filterValues(bi_dec_ann, plot_details, i), plot_details('bi_hist_stryr'), plot_details('bi_ssp_stryr'));
            grid on;
            grid minor;
            xlim([hist_stryr, ssp_endyr]);
            ylim(ylimits{i});
        end
    end
    
    print(variables{1}+ "_" + plot_details('letter'), '-dpng', '-r300');
end

function adjStr=getAdjustedString(string, line_length)
    strLen = strlength(string);
    if strLen > line_length
        itr = ceil(strLen/line_length);
        strArry = [];
        strPos = 1;
        for i=1:itr
            endPos = strPos + line_length - 1;
            if endPos > strLen
                endPos = strLen;
            end
            subStr = extractBetween(string, strPos, endPos);
            strArry = [strArry, subStr];
            strPos = endPos+1;
        end
        adjStr = strArry;
    else
        adjStr = string;
    end
end