%
%   Plots seasonal and annual data with multiple axis frame

%   @param, annual_values: It is the cell array of annual calculated variables (tables), which must be in a
%   specified order with ssp245 values first and then ssp370 values

%   @param, seasonal_values: It is the cell array of seasonal calculated variables (tables), which must be in a
%   specified order with ssp245 values followed by ssp370 variables

%   example = annual_values = {ann_r1i1p1f1css245, ann_r1i1p1f1ess245, ann_r1i1p1f1wss245, ann_r1i1p1f1gom245, ann_r1i1p1f1css370, ann_r1i1p1f1ess370, ann_r1i1p1f1wss370, ann_r1i1p1f1gom370 };
%

function PlotSeasonalAndAnnualValues(annual_values, seasonal_values, bi_dec_ann, bi_dec_ses)
    
    figure('Units', 'inches', 'rend','painters','pos',[0 0 8.25 11.75]);
    
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8.25 11.75])
%     set(gcf,'position',[0.10, 0.10,1300,800])
%     dim = [];
% Sumemr position [0.02 0.26 0.03 0.15]
%     dim = [0.848 0.26 0.03 0.03];
%     str = {'Note:','Solid horizontal line', 'shows bi-decadal mean,', 'from 1995-2014 & 2025-2044,', 'with their respective', 'region and experimets.'};
%     annotation('textbox',dim,'String',str,'FitBoxToText','on');
    % Axis titles
    axes('position',[0.02 0.74 0.03 0.10]);
    text(0.3,0.5,'Annual','fontsize',10,'fontweight','bold','color','k')
    axis('off')

    axes('position',[0.02 0.58 0.03 0.15]);
    text(0.3,0.5,'Winter','fontsize',10,'fontweight','bold','color','k')
    axis('off')

    axes('position',[0.02 0.42 0.03 0.15]);
    text(0.3,0.5,'Spring','fontsize',10,'fontweight','bold','color','k')
    axis('off')

    axes('position',[0.02 0.26 0.03 0.15]);
    text(0.3,0.5,'Summer','fontsize',10,'fontweight','bold','color','k')
    axis('off')
    
    axes('position',[0.02 0.10 0.03 0.15]);
    text(0.3,0.5,'Fall','fontsize',10,'fontweight','bold','color','k')
    axis('off')

%     Axis and plotting annual and seasonal values
    axes('position',[0.10 0.74 0.872 0.14]);
    plotHistoricalAndSSPValues(annual_values, 'mean');
    plotBidecadalLine(bi_dec_ann); 
    grid on;
    grid minor;
    l = legend('show');
    l.Position = [0.8 0.92 0.02 0.05];
    l.Title.String = 'Region (Experiment)';
    l.Title.FontSize = 6;
    l.FontSize = 6;
    l.NumColumns = 2;
    title(["TaiESM1 (r1i1p1f1)," , "Historical, ssp245 & ssp370,", "1955-2044"]);
    axP = get(gca,'Position');
    set(gca, 'Position', axP)
   
    xlim([1955, 2044]);
    ylim([9 22]);
    
    axes('position',[0.10 0.58 0.872 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Winter');
    plotBidecadalLine(bi_dec_ses, 'Winter'); 
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([3.5 16.5]);
    
    axes('position',[0.10 0.42 0.872 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Spring');
    plotBidecadalLine(bi_dec_ses, 'Spring'); 
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([7 20]);

    axes('position',[0.10 0.26 0.872 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Summer');
    plotBidecadalLine(bi_dec_ses, 'Summer'); 
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([15.5 28.5]);

    axes('position',[0.10 0.10 0.872 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Autumn');
    plotBidecadalLine(bi_dec_ses, 'Autumn'); 
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([9.5 22.5]);
    print('TaiESM1_r1i1p1f1_seasonal_bidecadal_and_annual_plots','-dpng', '-r300');
end