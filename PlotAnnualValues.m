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
    alphabets = {"a", "b", "c", "d", "e"};
    model_len = length(plot_details('models'));
    
    t = annotation('textbox');
    t.String = ["Model (variant)", "", giveModelVariantString(plot_details, model_len, alphabets)];
    t.Position = [0.075 0.9 0.2 0.089];
    t.FontSize = 7;
    
    lx = 0.02; ly = 0.74; lw = 0.03; lh = 0.10; moveDown = 0.16;
    x = 0.075; y = 0.74; w = 0.895; h = 0.14; 
    
    for j=1:model_len
        ly = ly - 0.16;
        axes('position',[lx ly lw lh]);
        text(0.3,0.5,alphabets{j},'fontsize',10,'fontweight','bold','color','k')
        axis('off')
    end
    
%     Axis and plotting annual and seasonal values
    axes('position',[x y w h]);
    plotHistoricalAndSSPValues(filterValues(annual_values, plot_details, 1), 'mean');
    plotBidecadalLine(filterValues(bi_dec_ann, plot_details, 1), plot_details('bi_hist_stryr'), plot_details('bi_ssp_stryr'));
    grid on;
    grid minor;
    l = legend('show');
    l.Position = [0.8 0.92 0.02 0.05];
    l.Title.String = 'Region (Experiment)';
    l.Title.FontSize = 6;
    l.FontSize = 6;
    l.NumColumns = 2;
    hist_stryr = plot_details('hist_stryr');
    ssp_endyr = plot_details('ssp_endyr');
    title(["zos", "Historical, ssp245 & ssp370,",hist_stryr + "-" + ssp_endyr]);
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
    print('zos, 5 models','-dpng', '-r300');
end

function stringArry = giveModelVariantString(plot_details, model_len, alphabets)
    stringArry = cell(1, model_len);
    models = plot_details('models');
    variants = plot_details('variants');
    
    for i=1:model_len
        stringArry{i} = alphabets{i} + " - " +models{i} + " (" + variants{i} + ")";
    end
end