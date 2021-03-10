
file_name = 'sob_Omon_ACCESS-CM2_historical_r1i1p1f1_gom_1950-2014.nc';
gregorian_date = datetime(1850,1,1);
decade_start_year = 1955;
decade_end_year = 2014;
time = ncread(file_name, 'time');
sob = ncread(file_name, 'sob');
time = gregorian_date + days(time);
cond = year(time) >= decade_start_year & year(time) <= decade_end_year;
time = time(cond);
winter = zeros(1, 30);
spring = zeros(1, 30);
summer = zeros(1, 30);
autumn = zeros(1, 30);
seasonal_decadal_average = [];

for decade_yr = decade_start_year:10:decade_end_year
    for yr = decade_yr:decade_yr+9
        single_year = year(time) == yr;
        each_yr = time(single_year);
        each_sob = sob(single_year);
        w_sob = each_sob(month(each_yr) > 0 & month(each_yr) < 4);
        winter = write_seasonal_sob(winter, w_sob);
        
        sp_sob = each_sob(month(each_yr) > 3 & month(each_yr) < 7);
        spring = write_seasonal_sob(spring, sp_sob);
        
        su_sob = each_sob(month(each_yr) > 6 & month(each_yr) < 10);
        summer = write_seasonal_sob(summer, su_sob);
        
        aut_sob = each_sob(month(each_yr) > 9 & month(each_yr) < 13);
        autumn = write_seasonal_sob(autumn, aut_sob);
    end
    seasonal_average = [mean(winter) mean(spring) mean(summer) mean(autumn)];
    for j=1:length(seasonal_average)
        seasonal_decadal_average = [seasonal_decadal_average; [j seasonal_average(j) decade_yr decade_yr+9]];
    end
end



function season = write_seasonal_sob(season, each_yr_sob)
    [~, ind] = (min((abs(season)')));
    fill_arry_upto = ind+length(each_yr_sob)-1;
    season(ind:fill_arry_upto) = each_yr_sob;
end

