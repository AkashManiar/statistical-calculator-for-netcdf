file_name = 'sob_Omon_ACCESS-CM2_historical_r1i1p1f1_gom_1950-2014.nc';
gregorian_date = date(1850, 1, 1);
decade_start_year = 1955;
decade_end_year = 2014;
time = ncread(file_name, 'time');
sob = ncread(file_name, 'sob');

time = gregorian_start_date + days(time);
time = time(year(time) >= decade_start_year & year(time) <= decade_end_year);


for decade_yr = decade_start_year:10:decade_end_year
    for yr = decade_yr:decade_yr+9
        each_yr = time(year(time) == yr);
        for mnth = 0:3:12
            
        end
    end
end



