function processHistoricAndSSPFiles(selected_files, start_yr_hist, end_yr_hist, start_yr_ssp, end_yr_ssp, interval, bi_start_hist, bi_start_ssp)
   
%     file_len = length(selected_files);
%     seasonal_rows = file_len*174;
%     annual = table();
%     seasonal = table();

for j=1:12:length(selected_files)
    annual = table();   
    seasonal = table();
    
    bid_annual = table();
    bid_seasonal = table();
    for i=j:j+11
        if contains(selected_files{i}, 'historical')
            annual = [annual; calculateYearlyMean(selected_files{i}, start_yr_hist, end_yr_hist, interval)];
            seasonal = [seasonal; caculateIntervalSeasonalValues(selected_files{i}, start_yr_hist, end_yr_hist, interval)];
            
            bid_annual = [bid_annual; calculateYearlyMean(selected_files{i}, bi_start_hist, bi_start_hist+19, 20)];
            bid_seasonal = [bid_seasonal; caculateIntervalSeasonalValues(selected_files{i}, bi_start_hist, bi_start_hist+19, 20)];
        else 
            annual = [annual; calculateYearlyMean(selected_files{i}, start_yr_ssp, end_yr_ssp, interval)];
            seasonal = [seasonal; caculateIntervalSeasonalValues(selected_files{i}, start_yr_ssp, end_yr_ssp, interval)];
            
            bid_annual = [bid_annual; calculateYearlyMean(selected_files{i}, bi_start_ssp, bi_start_ssp+19, 20)];
            bid_seasonal = [bid_seasonal; caculateIntervalSeasonalValues(selected_files{i}, bi_start_ssp, bi_start_ssp+19, 20)];
        end
    end
    file_details = getNetCDFFileDetails(selected_files{i});
    vr_name = file_details('variable_name');
    model = file_details('model_name');
    variant = file_details('variant');
    plot_details = containers.Map({'variable_name', 'model_name', 'variant', 'hist_stryr', 'hist_endyr', 'ssp_stryr', 'ssp_endyr', 'bi_hist_stryr', 'bi_ssp_stryr'}, {vr_name, model, variant, start_yr_hist, end_yr_hist, start_yr_ssp, end_yr_ssp, bi_start_hist, bi_start_ssp});
    PlotSeasonalAndAnnualValues(annual, seasonal, bid_annual, bid_seasonal, plot_details);
end
end