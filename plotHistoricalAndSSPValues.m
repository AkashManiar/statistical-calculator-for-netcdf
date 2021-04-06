function plotHistoricalAndSSPValues(variables, fetch_string, season)
    
    % It has cell array of historical and ssp colors in specified order, arranged according to input   
    historic_colors = {'#ff1ac6', '#0000e6', '#00e600', '#e60000'};
    historic_legends = {'css (historical)', 'ess (historical)', 'wss (historical)', 'gom (historical)'};
    
    ssp_colors = {'#ff4dd2', '#3333ff', '#33ff33', '#ff3333', '#e6e600', '#000000', '#404040', '#1affff'};
    ssp_legends = {'css (ssp245)' , 'ess (ssp245)' , 'wss (ssp245)' , 'gom (ssp245)' , 'css (ssp370)' , 'ess (ssp370)' , 'wss (ssp370)' , 'gom (ssp370)'};
    
    for i = 1:length(variables)
        
        tab = variables{i};
        if nargin == 3
            tab = tab(strcmp(tab.season, season), :);
        end
        ssp_data = tab(tab.start_year > 2014, :);
        if (i < 5)
            historical_data = tab(tab.start_year < 2015, :);
            plot(historical_data.start_year, historical_data.(fetch_string), 'Color', historic_colors{i}, 'DisplayName', historic_legends{i});
            hold on;
            plot([historical_data.start_year(end), ssp_data.start_year(1)], [historical_data.(fetch_string)(end), ssp_data.(fetch_string)(1)], 'Color', historic_colors{i}, 'HandleVisibility','off');
            hold on;
        end
       
        plot(ssp_data.start_year, ssp_data.(fetch_string), 'Color', ssp_colors{i}, 'LineStyle', '--', 'DisplayName', ssp_legends{i});
        hold on;
    end
end