function aggregatedIntervals = calculateYearlyMean(netcdfFile, start_year, end_year, interval)
    if (interval < 1)
        error('Interval cannot be less than 1 year, it must be 1 or over');
    end
    
%     first_date = datetime(0001, 01, 01);
%     days_from = datetime(1850,01,01);
    no_of_months = interval * 12;
    file_details = getNetCDFFileDetails(netcdfFile);
    vr_name = file_details('variable_name');
    polygon = file_details('polygon');
    model = file_details('model_name');
    experiment = file_details('experiment');
    variant = file_details('variant');
    
    % Time must be present in netcdf file
    time = ncread(netcdfFile, 'time');
    time = getDateVector(time);
    
    variable = ncread(netcdfFile, char(vr_name));
%     if (contains(experiment{1}, 'ssp'))
%         days_from = datetime(2015, 01, 01);
%     end
%     time = days_from + days(time);
    
%     time = first_date + days(time);
    cond = year(time) >= start_year & year(time) <= end_year;
    time = time(cond);
    variable = variable(cond);

    VariableNames = {'start_year', 'end_year', 'mean', 'variable', 'polygon', 'experiment', 'model', 'variant', 'interval'};
    aggregatedIntervals = table();
    
    for intv_start_yr = start_year:interval:end_year
       
        months = zeros(1, no_of_months);
        start_month = 1;
        for yr = intv_start_yr:intv_start_yr+interval-1
            single_year = year(time) == yr;
            each_yearly_val = variable(single_year);
            months(start_month:start_month+12-1) = each_yearly_val;
            start_month = start_month + 12;
        end
        
        interval_end_yr =  intv_start_yr+interval-1;
        yearly_mean = [mean(months)];
        t = table(intv_start_yr, interval_end_yr, yearly_mean, vr_name, polygon, experiment, model, variant, interval);
        aggregatedIntervals = [aggregatedIntervals; t];
    end
    
    % Adds property to table 
    aggregatedIntervals.Properties.VariableNames = VariableNames;

end