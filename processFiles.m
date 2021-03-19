function processFiles(netCDF_files, interval_len)
    [ind_hist, ind_ssp245, ind_ssp370] = checkFileNames(netCDF_files);
    
    if (ind_hist == 0 || (ind_ssp245 == 0 && ind_ssp370 == 0))
        error('Provided files must have at least one historical and one ssp file, for concatenation of datasets to happen.');
    end
    f_hist = char(netCDF_files(ind_hist));
    
    % At this time starting year and ending year are given static input,
    % however can be made dynamic 
    hist_table = caculateIntervalSeasonalValues(f_hist, 1955, 2014, interval_len);
    f_hist = giveJustFileName(f_hist);
    
    if (ind_ssp245 ~= 0)
        f_ssp245 = char(netCDF_files(ind_ssp245));
        ssp_table = caculateIntervalSeasonalValues(f_ssp245, 2015, 2044, interval_len);
        results = [hist_table; ssp_table];
        f_ssp245 = giveJustFileName(f_ssp245);
        
        % Writes concatenated historical and SSP245 results to the excel
        % and mat file.
        
        writetable(results, giveFileWithExt(f_hist, f_ssp245, '.xls'));
        save(giveFileWithExt(f_hist, f_ssp245, '.mat'), 'results');
    end
    
    if (ind_ssp370 ~= 0)
        f_ssp370 = char(netCDF_files(ind_ssp370));
        ssp_table = caculateIntervalSeasonalValues(f_ssp370, 2015, 2044, interval_len);
        results = [hist_table; ssp_table];
        f_ssp370 = giveJustFileName(f_ssp370);
        
        % Writes concatenated historical and SSP370 results to the excel
        % and mat file.
        
        writetable(results, giveFileWithExt(f_hist, f_ssp370, '.xls'));
        save(giveFileWithExt(f_hist, f_ssp370, '.mat'), 'results');
    end
end

function f_nm = giveJustFileName(file_name)
    f_nm = split(file_name, '.');
    f_nm = char(f_nm(1));
end

function f_nm = giveFileWithExt(h_name, ssp_name, extension)
    f_nm = strcat(h_name, '__AND__', ssp_name, extension);
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

	