function ylimits = calculateYLimitsAnnual(annual_values, plot_details, column, mapLimit)
    ylimits = cell(1, mapLimit);
    diff = zeros(1, mapLimit);
    
    for i=1:mapLimit
        mean_val = filterValues(annual_values, plot_details, i);
        mean_val = mean_val.(column);
        ymin = min(mean_val);
        ymax = max(mean_val);
        ylimits{i} = [ymin, 0];
        diff(i) = ymax - ymin;
    end
    
    max_diff = max(diff);
    ylimits = cellfun(@(x) [x(1), x(1)+max_diff], ylimits, 'UniformOutput',false);
end