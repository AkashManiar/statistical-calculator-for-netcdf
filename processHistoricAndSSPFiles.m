function processHistoricAndSSPFiles(selected_files, start_yr_hist, end_yr_hist, start_yr_ssp, end_yr_ssp, interval, bi_start_hist, bi_start_ssp)
   
%     file_len = length(selected_files);
%     seasonal_rows = file_len*174;
%     annual = table();
%     seasonal = table();
counter = 0;
variants = cell(1,5);
variables = cell(1,5);
models = cell(1,5);
annual = table();   
bid_annual = table();

for j=1:12:length(selected_files)
    counter = counter + 1;
    if (counter > 5)
        annual = table();   
        bid_annual = table();
    end
    
    for i=j:j+11
        if contains(selected_files{i}, 'historical')
            annual = [annual; calculateYearlyMean(selected_files{i}, start_yr_hist, end_yr_hist, interval)];
            bid_annual = [bid_annual; calculateYearlyMean(selected_files{i}, bi_start_hist, bi_start_hist+19, 20)];
           
        else 
            annual = [annual; calculateYearlyMean(selected_files{i}, start_yr_ssp, end_yr_ssp, interval)];
            bid_annual = [bid_annual; calculateYearlyMean(selected_files{i}, bi_start_ssp, bi_start_ssp+19, 20)];
        end
    end
    file_details = getNetCDFFileDetails(selected_files{i});
    vr_name = file_details('variable_name');
    model = file_details('model_name');
    variant = file_details('variant');
    
    variants{counter} = variant;
    variables{counter} = vr_name;
    models{counter} = model;
    
    if counter == 5
        plot_details = containers.Map({'variables', 'models', 'variants', 'hist_stryr', 'hist_endyr', 'ssp_stryr', 'ssp_endyr', 'bi_hist_stryr', 'bi_ssp_stryr'}, {variables, models, variants, start_yr_hist, end_yr_hist, start_yr_ssp, end_yr_ssp, bi_start_hist, bi_start_ssp});
        PlotAnnualValues(annual, bid_annual, plot_details);
        counter = 0;
    else
        continue;
    end
end
end