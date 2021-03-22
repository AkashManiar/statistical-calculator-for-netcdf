function aggregatedIntervals = caculateIntervalSeasonalValues(netcdfFile, start_year, end_year, interval)
    % Here it assumes that time is present in netcdf file, and all the time
    % values are caculate from days since 1850-01-01 (proleptic gregorian
    % calendar)
    if (interval < 1)
        error('Interval cannot be less than 1 year, it must be 1 or over');
    end
    
    gregorian_date = datetime(1850,1,1);
%     disp('---------------------------------');
%     disp(interval * 3);
    no_seasonal_months = interval * 3;
    file_details = getNetCDFFileDetails(netcdfFile);
    vr_name = char(file_details('variable_name'));
    
    % Time must be present in netcdf file
    time = ncread(netcdfFile, 'time');
    variable = ncread(netcdfFile, vr_name);
    time = gregorian_date + days(time);
    cond = year(time) >= start_year & year(time) <= end_year;
    time = time(cond);
    variable = variable(cond);
    seasons = {'Winter'; 'Spring'; 'Summer'; 'Autumn'};

    VariableNames = {'start_year', 'end_year', 'season', 'mean', 'standard_deviation', 'maximum', 'minimum'};
    aggregatedIntervals = table();
    
    for intv_start_yr = start_year:interval:end_year
        winter = zeros(1, no_seasonal_months);
        spring = zeros(1, no_seasonal_months);
        summer = zeros(1, no_seasonal_months);
        autumn = zeros(1, no_seasonal_months);
        
        for yr = intv_start_yr:intv_start_yr+interval-1
            single_year = year(time) == yr;
            
            each_yr = time(single_year);
            each_sob = variable(single_year);
%             disp('----------------------------');
%             disp(each_sob);
            
            win = each_sob(month(each_yr) >= 1 & month(each_yr) <= 3);
            winter = write_seasonal_valofyear(winter, win);
%             disp('----------------Winter-----------------');
%             disp(winter);
            
            sp = each_sob(month(each_yr) >= 4 & month(each_yr) <= 6);
            spring = write_seasonal_valofyear(spring, sp);

            su = each_sob(month(each_yr) >= 7 & month(each_yr) <= 9);
            summer = write_seasonal_valofyear(summer, su);

            aut = each_sob(month(each_yr) >= 10 & month(each_yr) <= 12);
            autumn = write_seasonal_valofyear(autumn, aut);

        end
        
        interval_start_yr = zeros(4,1);
        interval_start_yr(:) = intv_start_yr;
       
        interval_end_yr = zeros(4,1);
        interval_end_yr(:) = intv_start_yr+interval-1;
        
        seasonal_avg = [mean(winter); mean(spring); mean(summer); mean(autumn)];
        seasonal_std = [std(winter); std(spring); std(summer); std(autumn)];
        seasonal_max = [max(winter); max(spring); max(summer); max(autumn)];
        seasonal_min = [min(winter); min(spring); min(summer); min(autumn)];
        
        t = table(interval_start_yr, interval_end_yr, seasons, seasonal_avg, seasonal_std, seasonal_max, seasonal_min);
        aggregatedIntervals = [aggregatedIntervals; t];
    end
    
    % Adds property to table 
    aggregatedIntervals.Properties.VariableNames = VariableNames;

    function season = write_seasonal_valofyear(season, each_yr_sob)
        [~, ind] = (min((abs(season)')));
        fill_arry_upto = ind+length(each_yr_sob)-1;
        season(ind:fill_arry_upto) = each_yr_sob;
    end
   
end


