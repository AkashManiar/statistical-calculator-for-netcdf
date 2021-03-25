function [annual, seasonal]= calculateAnnualAndSeasonalValues(historical_files, ssp_files)
    annual = table();
    seasonal = table();
    
    for i = 1:length(historical_files)
        annual = [annual; calculateYearlyMean(historical_files{i}, 1995, 2014, 20)];
        seasonal = [seasonal; caculateIntervalSeasonalValues(historical_files{i}, 1995, 2014, 20)];
    end
    
    for i = 1:length(ssp_files)
        annual = [annual; calculateYearlyMean(ssp_files{i}, 2025, 2044, 20)];
        seasonal = [seasonal; caculateIntervalSeasonalValues(ssp_files{i}, 2025, 2044, 20)];
    end
end