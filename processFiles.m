function [hist_and_ssp245, hist_and_ssp370] = processFiles(netCDF_files, interval_len)
    [ind_hist, ind_ssp245, ind_ssp370] = checkFileNames(netCDF_files);
    
    if (ind_hist == 0 || (ind_ssp245 == 0 && ind_ssp370 == 0))
        error('Provided files must have at least one historical and one ssp file, for concatenation of datasets to happen.');
    end
    f_hist = char(netCDF_files(ind_hist));
    
    % At this time starting year and ending year are given as static input
    % based on requirement
    
%     hist_table = caculateIntervalSeasonalValues(f_hist, 1955, 2014, interval_len);
    hist_table = calculateYearlyMean(f_hist, 1955, 2014, interval_len);
    f_hist = stripFileExtension(f_hist);
    
    if (ind_ssp245 ~= 0)
        ssp_file = char(netCDF_files(ind_ssp245));
        res = processSSP_Historic(ssp_file, f_hist, hist_table, interval_len);
        hist_and_ssp245 = res;
    end
    
    if (ind_ssp370 ~= 0)
        ssp_file = char(netCDF_files(ind_ssp370));
        res = processSSP_Historic(ssp_file, f_hist, hist_table, interval_len);
        hist_and_ssp370 = res;
    end
end

% This function can be used to call function calculating annual mean as well as seasonal
% mean
function results = processSSP_Historic(ssp_file, hist_file, history_table, interval)
    
%     ssp_table = caculateIntervalSeasonalValues(ssp_file, 2015, 2044, interval);
    ssp_table = calculateYearlyMean(ssp_file, 2015, 2044, interval);
    results = [history_table; ssp_table];
    file_details = getNetCDFFileDetails(ssp_file);
    f_ssp_only_nm = char(file_details('file_name'));
    file = strcat(hist_file, '_AND_', f_ssp_only_nm);
    
%     Writes concatenated historical and SSP245 results to the excel
%     and mat file.

%     writetable(results, strcat(file, '.xls'));
%     save(giveFileNmWithExt(hist_file, f_ssp_only_nm, '.mat'), 'results');
end

function f_nm = stripFileExtension(file_name)
    f_nm = split(file_name, '.');
    f_nm = char(f_nm(1));
end

function [historical, ssp245, ssp370] = checkFileNames(files)
        historical = 0;
        ssp245 = 0;
        ssp370 = 0;
    for i = 1:length(files)
        if (contains(files(i), 'historical'))
            historical = i;
        elseif (contains(files(i), 'ssp245'))
            ssp245 = i;
        elseif (contains(files(i), 'ssp370'))
            ssp370 = i;
        end
    end
end

	