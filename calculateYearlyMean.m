function aggregatedIntervals = calculateYearlyMean(netcdfFile, start_year, end_year, interval)
    if (interval < 1)
        error('Interval cannot be less than 1 year, it must be 1 or over');
    end
    
    gregorian_date = datetime(1850,1,1);
%     disp('---------------------------------');
%     disp(interval * 3);
    no_of_months = interval * 12;
    file_details = GetNetCDF_FileDetails(netcdfFile);
    vr_name = char(file_details('variable_name'));
    
    % Time must be present in netcdf file
    time = ncread(netcdfFile, 'time');
    variable = ncread(netcdfFile, vr_name);
    time = gregorian_date + days(time);
    cond = year(time) >= start_year & year(time) <= end_year;
    time = time(cond);
    variable = variable(cond);

    VariableNames = {'start_year', 'end_year', 'Annual mean'};
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
        t = table(intv_start_yr, interval_end_yr, yearly_mean);
        aggregatedIntervals = [aggregatedIntervals; t];
    end
    
    % Adds property to table 
    aggregatedIntervals.Properties.VariableNames = VariableNames;

end