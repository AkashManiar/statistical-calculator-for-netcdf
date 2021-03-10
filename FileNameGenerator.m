function f = FileNameGenerator()
    characters = randsample(65:90, 15);
    
    f = char(characters); 
    f = strcat(f, '_CMIP', '.mat');
end

