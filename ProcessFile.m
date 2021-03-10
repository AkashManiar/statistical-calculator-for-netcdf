function ProcessFile(netCDF_files, interval_len, map_container, inputCriterias)
%     disp(nargin);
    for i=1:length(netCDF_files)
        file = netCDF_files{i};
        file_details = GetNetCDF_FileDetails(file);
        end_year = file_details('end_year');
        start_year = file_details('start_year');
        time_series_length = end_year - start_year + 1;
        number_of_intervals = time_series_length / interval_len;
        disp(number_of_intervals);
        disp(start_year);
        
%         disp(mod(time_series_length, number_of_intervals));
%         disp(~isinteger(number_of_intervals));    
%         disp(minus(file_details('end_year'), file_details('start_year')));
    end
%     p = inputParser;
%     argName = 'output_dir';
%     defaultVal = '';
%     addOptional(p,argName,defaultVal);
%     fileName = FileNameGenerator;
%     cmip_var = struct('a', 'Akash', 'b', 'Brendan', 'z', 'Zeliang');
%     save(fileName, 'cmip_var');
end