% All files must be at a root level of mentioned folder path

function [selected_files]  = separateFiles(folder_path, variables, models, variants)

    DirList = dir(fullfile(folder_path, '*.nc'));
    files = fullfile(folder_path, {DirList.name});
    
    selected_files = {};
%     selectedComb = {};
    
    for j=1:length(variables)
        variable = variables{j};
        for k=1:length(models)
            set_of_files = {};
            model = models{k};
            variant = variants{k};
            if strcmp(model, "CanESM5")
                disp(model);
            end
            hist_str   = variable + "_Omon_" + model + "_historical_" + variant;
            ssp245_str = variable + "_Omon_" + model + "_ssp245_" + variant;
            ssp370_str = variable + "_Omon_" + model + "_ssp370_" + variant;
%             selectedComb{end + 1} = {variable, model, variant};
            for i=1:length(files)
                file = files{i};
                if contains(file, {char(hist_str), char(ssp245_str), char(ssp370_str)})
                    set_of_files{end + 1} = file;
                    if length(set_of_files) == 12
                        break;
                    end
                end
            end
            selected_files = [selected_files, set_of_files];
        end
%         "zos_Omon_CanESM5_historical_r3i1p2f1_gom_1950-2014"
%         "zos_Omon_CanESM5-CanOE_historical_r1i1p2f1_ess_1950-2014"
    end
end