function ylimits = calculateYLimits(annual_values, seasonal_values, plotsOf, column)
    ylimits = cell(1, 5);
    diff = zeros(1, 5);
    
    for i=1:length(plotsOf)
        if strcmp(plotsOf{i}, 'Annual')
            ymin = min(annual_values.(column));
            ymax = max(annual_values.(column));
            ylimits{i} = [ymin, 0];
            diff(i) = ymax - ymin;
        else 
            filter = strcmp(seasonal_values.season, plotsOf{i});
            fil_val = seasonal_values(filter, :);
            fil_val = fil_val.(column);
            ymin = min(fil_val);
            ymax = max(fil_val);
            ylimits{i} = [ymin, 0];
            diff(i) = ymax - ymin;
        end
    end
    
    max_diff = max(diff);
    ylimits = cellfun(@(x) [x(1), x(1)+max_diff], ylimits, 'UniformOutput',false);
end