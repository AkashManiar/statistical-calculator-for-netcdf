function file_names = getFileNames(file_list)
    file_names = cell(length(file_list), 1);
    for i=1:length(file_list)
        file = file_list{i};
        file = split(file, '\');
        file = file{length(file)};
        file_names{i} = file;
    end
end