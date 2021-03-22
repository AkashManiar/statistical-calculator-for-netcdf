function file_details = getNetCDFFileDetails(file)
    file_nm = file;
    
    % If file contains file path having '/', then it will fetch file name from the end of the string 
    if contains(file, '/')
        file_nm = split(file, '/');
        cell = size(file_nm);
        cell = cell(1);
        file_nm = file_nm(cell);
        
    end
    file_nm = split(file_nm, '.');
    file_nm = char(file_nm(1));
    file_details = split(file_nm, "_");
    year = file_details(7);
    year = split(year, '-');
    year = str2double(year);
    file_details = containers.Map({'file_name', 'variable_name', 'domain_and_frequency', 'model_name', 'experiment', 'variant',  'polygon', 'start_year', 'end_year'}, {file_nm, file_details(1), file_details(2), file_details(3), file_details(4), file_details(5), file_details(6), year(1), year(2)});
    
end