% This function takes table as input and assumes table has average,
% maximum, minimum, and standard deviation values as their inputs

function plotSeasonalValues(css, ess, wss, gom, variant, model, sspName)
    seasons = {'Winter', 'Spring', 'Summer', 'Autumn'};    
    for i=1:length(seasons)

        ess_seasonal = ess(strcmp(ess.season, seasons{i}), :);
        css_seasonal = css(strcmp(css.season, seasons{i}), :);
        wss_seasonal = wss(strcmp(wss.season, seasons{i}), :);
        gom_seasonal = gom(strcmp(gom.season, seasons{i}), :);
%         title_str = char(strcat(seasons{i}, {' '}, 'Mean', )); 
        title_str = model + " (" + variant+ "), from historical & " + sspName + " experiments,";
        figure
        plot(ess_seasonal.start_year, ess_seasonal.mean, 'blue', 'DisplayName','ess');
        hold on;
        plot(css_seasonal.start_year, css_seasonal.mean, 'green', 'DisplayName','css');
        hold on;
        plot(wss_seasonal.start_year, wss_seasonal.mean, 'magenta', 'DisplayName','wss');
        hold on;
        plot(gom_seasonal.start_year, gom_seasonal.mean, 'cyan', 'DisplayName','gom');
        xline(2021, 'red', {'2021'}, 'HandleVisibility','off', 'LineWidth',2);
        xlabel('Year');
        ylabel("Sea Surface Temperature (C"+char(176)+")");
        title({seasons{i}+ " Mean, ", title_str, "1955-2044"});
        hold off;
        grid on;
        grid minor;
        l = legend('show');
        l.Title.String = model+ " (" + variant + ")";
    end
end
