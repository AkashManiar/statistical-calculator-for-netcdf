%
%   Plots seasonal and annual data with multiple axis frame

%   @param, annual_values: It is the cell array of annual calculated variables (tables), which must be in a
%   specified order with ssp245 values first and then ssp370 values

%   @param, seasonal_values: It is the cell array of seasonal calculated variables (tables), which must be in a
%   specified order with ssp245 values followed by ssp370 variables

%   example = annual_values = {ann_r1i1p1f1css245, ann_r1i1p1f1ess245, ann_r1i1p1f1wss245, ann_r1i1p1f1gom245, ann_r1i1p1f1css370, ann_r1i1p1f1ess370, ann_r1i1p1f1wss370, ann_r1i1p1f1gom370 };
%

function PlotSeasonalAndAnnualValues(annual_values, seasonal_values)
    
    figure
    
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

    % Axis and plotting annual and seasonal values
    axes('position',[0.10 0.74 0.79 0.13]);
    plotHistoricalAndSSPValues(annual_values, 'Annual mean');
    grid on;
    grid minor;

    
    l = legend('show');
    l.Position = [0.848 0.21 0.2 0.8];
    l.Title.String = 'Region (Experiment)';
    l.Title.FontSize = 9;
    l.FontSize = 8;
    title(["ACCESS-CM2 (r1i1p1f1)", "Historical, ssp245 & ssp370 Experiments,", "1955-2044"]);
%     ylabel("SST (C"+char(176)+")");
    xlim([1955, 2044]);
    ylim([7.5 15.5]);
    
    % Bi-decadal value
    line([]);
    
    axes('position',[0.10 0.58 0.79 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Winter');
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([3 12]);
    
    axes('position',[0.10 0.42 0.79 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Spring');
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([4.5 13.5]);

    axes('position',[0.10 0.26 0.79 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Summer');
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([12 21]);

    axes('position',[0.10 0.10 0.79 0.14]);
    plotHistoricalAndSSPValues(seasonal_values, 'mean', 'Autumn');
    grid on;
    grid minor;
    xlim([1955, 2044]);
    ylim([8 17]);
    
end