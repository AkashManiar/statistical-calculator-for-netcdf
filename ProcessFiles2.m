function ProcessFiles2(folder_path)
    variables = 'zos';
    models = 'ACCESS-CM2, CanESM5, UKESM1-0-LL, TaiESM1, NorESM2-LM';
    variants = 'r1i1p1f1, r2i1p2f1, r1i1p1f2, r1i1p1f1, r3i1p1f1';
    start_year_hist = 1955;
    end_year_hist = 2014;
    start_year_ssp = 2015;
    end_year_ssp = 2049;
    interval = 1;
    start_year_bidec_hist = 1995;
    start_year_bidec_ssp = 2030;
    isBidecadal = 'Y'; 
%     variables = input('Enter variables to be processed (e.g. tos, zos):- ', 's');
%     models = input('Enter models that needs to processed (must be a String separated by comma), by default is ALL:- ', 's');
%     variants = input('Enter variants that you would like to try, in order you want to process (must be String separated by comma):- ', 's');
%     start_year_hist = input('Enter historical start year, (must be a numeric value):- ');
%     end_year_hist = input('Enter historical end year, (must be a numeric value):- ');
%     start_year_ssp = input('Enter SSP start year, (must be a numeric value):- ');
%     end_year_ssp = input('Enter SSP end year, (must be a numeric value):- ');
%     interval = input("Enter the interval years to process (must be a numeric values) (e.g. 1 it means 1 year):- ");
%     isBidecadal = input("Do you need bidecadal year to be computed? (type Y for yes or N for No):- ", 's');
% 
%      if (strcmp(isBidecadal, 'Y'))
%          start_year_bidec_hist = input("Enter historical start year for bi-decadal calculation");
%          start_year_bidec_ssp = input("Enter SSP start year for bi-decadal calculation");
%      end
%     disp('Here are all the input values you have entered, please verify');
%     disp('------------Variables---------------');
%     disp(variables);
%     disp('------------Models---------------');
%     disp(models);
%     disp('------------Variants--------------');
%     disp(variants);
%     disp('------------Historical start year-------------');
%     disp(start_year_hist);
%     disp('------------Historical end year------------');
%     disp(end_year_hist);
%     disp('------------SSP start year--------------');
%     disp(start_year_ssp);
%     disp('------------SSP end year--------------');
%     disp(end_year_ssp);
%     disp('------------Interval--------------');
%     disp(interval);
%     disp('------------Do you want to calculate bi-decadal values? (Y- YES, N-NO)--------------');
%     disp(isBidecadal);
%     if (strcmp(isBidecadal, 'Y'))
%         disp('------------Bi-decadal start year (historical)--------------');
%         disp(start_year_bidec_hist);
%         disp('------------Bi-decadal start year (SSP)--------------');
%         disp(start_year_bidec_ssp);
%     end
%     
%     isConfirm = input('To confirm please press Y, else press enter to input all values again: ', 's');
%     if (~strcmp(isConfirm, 'Y'))
%         ProcessFiles2(folder_path)
%     end

    
    isValuesOk = ~(isempty(start_year_hist) || isempty(end_year_hist) || isempty(start_year_ssp) || isempty(end_year_ssp) || isempty(interval) || isempty(models) || isempty(variants) || isempty(variables));
    
    
    if isValuesOk
        variables = getCellArrayOfString(variables);
        models = getCellArrayOfString(models);
        variants = getCellArrayOfString(variants);
        if ~isequal(size(models), size(variants))
            error('Number of inputted models should be equal as that of the variants');
        end
        selected_files= separateFiles(folder_path, variables, models, variants);
        if mod(length(selected_files), 12) ~= 0
            error('Selected files should always be in factors of 12, due to 12 selected files');
        end
        processHistoricAndSSPFiles(selected_files, start_year_hist, end_year_hist, start_year_ssp, end_year_ssp, interval, start_year_bidec_hist, start_year_bidec_ssp);
        
        % Check if bidecadal calculation is needed
%         if strcmp(isBidecadal, 'Y')
%             isBiDecYearsOK = ~(isempty(start_year_bidec_hist) || isempty(start_year_bidec_ssp));
%             if isBiDecYearsOK
%                 [bidec_annual_table, bidec_seasonal_table] = processHistoricAndSSPFiles(selected_files, start_year_bidec_hist, start_year_bidec_hist+19, start_year_bidec_ssp, start_year_bidec_ssp+19, 20);
%             else
%                 error('Bidecal years are not okay');
%             end
%         end
    else
        error('Something is wrong with inputted values, values cannot be empty.');
    end
end

function cellArray = getCellArrayOfString(string)
    cellArray = {string};
    if contains(string, ',')
        cellArray = strsplit(string, ',');
    end
        cellArray = cellfun(@strip, cellArray, 'UniformOutput' , false);
end

