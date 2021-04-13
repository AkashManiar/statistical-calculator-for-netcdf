function plotHistoricalAndSSPValues(table_data, column)
    polygons = {'css', 'ess', 'wss', 'gom'};
    experimets = {'historical', 'ssp245', 'ssp370'};
    all_colors = containers.Map({'historical', 'ssp245', 'ssp370'}, {{'#ff1ac6', '#0000e6', '#00e600', '#e60000'}, {'#ff4dd2', '#3333ff', '#33ff33', '#ff3333'}, {'#e6e600', '#000000', '#404040', '#1affff'}});
    all_legends = containers.Map({'historical', 'ssp245', 'ssp370'}, {{'css (historical)', 'wss (historical)', 'wss (historical)', 'gom (historical)'}, {'css (ssp245)', 'ess (ssp245)', 'wss (ssp245)', 'gom (ssp245)'}, {'css (ssp370)', 'ess (ssp370)', 'wss (ssp370)', 'gom (ssp370)'}});
    hist_data = cell(1, 4);
    for i=1:length(experimets)
        exp_color = all_colors(experimets{i});
        legend = all_legends(experimets{i});
        
        for j=1:length(polygons)
            filter = strcmp(table_data.experiment, experimets{i}) & strcmp(table_data.polygon, polygons{j});    
            results = table_data(filter, :);
            color = exp_color{j};
            x = results.start_year;
            y = results.(column);
            if contains(experimets{i}, 'historical')
                plot(x, y, 'Color', color, 'DisplayName', legend{j});
                hist_data{j} = [x(end), y(end)];
                hold on;
            else
                plot(x, y, 'Color', color, 'LineStyle', '--', 'DisplayName', legend{j});
                hold on;
                h_data = hist_data{j};
                plot([h_data(1), x(1)], [h_data(2), y(1)], 'Color', color, 'HandleVisibility','off');
            end
            
        end
    end
end