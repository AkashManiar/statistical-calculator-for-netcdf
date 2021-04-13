function filtered_values = filterValues(raw_values, plot_details, index)
    model = plot_details('models');
    model = model{index};
    
    variable = plot_details('variables');
    variable = variable{index};
    
    variant = plot_details('variants');
    variant = variant{index};
    
    filter = strcmp(raw_values.model, model) & strcmp(raw_values.variable, variable) & strcmp(raw_values.variant, variant);
    filtered_values = raw_values(filter, :);
end