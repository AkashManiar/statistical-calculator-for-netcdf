% All files must be at a root level of mentioned folder path

function [selected_files]  = separateFiles(folder_path, variables, models, variants)
    files = dir(folder_path);
    selected_files = {};
%     selectedComb = {};
    
    for j=1:length(variables)
        variable = variables{j};
        for k=1:length(models)
            set_of_files = {};
            model = models{k};
            variant = variants{k};
            hist_str   = variable + "_Omon_" + model + "_historical_" + variant;
            ssp245_str = variable + "_Omon_" + model + "_ssp245_" + variant;
            ssp370_str = variable + "_Omon_" + model + "_ssp370_" + variant;
%             selectedComb{end + 1} = {variable, model, variant};
            for i=3:length(files)
                file = files(i).name;
                if contains(file, {char(hist_str), char(ssp245_str), char(ssp370_str)})
                    f = folder_path + "\" + file;
                    set_of_files{end + 1} = f;
                    if length(set_of_files) == 12
                        break;
                    end
                end
            end
            selected_files = [selected_files, set_of_files];
        end
    end
end