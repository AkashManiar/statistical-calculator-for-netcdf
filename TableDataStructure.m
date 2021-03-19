% For table you need to predefine column vecotors first
% Here we are trying to create three column vectors, which would be used to
% generate tables, here 

age = [20:20:100];
age = age';
height = [100:20:180];
height = height';
weight = [10:10:50];
weight = weight';

% Now we gonna be adding rownames as the additional property of our table,
% which shows whose age, height, and weight we are talking about. Any
% properties of the table can be added using
% TABLE_NAME.Properties.PROPERTY_NAME
% For instance, given following property is RowNames, which would be added later
firstNames = {'Akash', 'Rushik', 'Aayushi', 'Nakul','Zeel'};

% By default table titles are created as of variable names, however to have
% your own table title names, you can have a cellarray of variable names as
% follows
variableNames = {'Person Age', 'Person Height', 'Person Weight'};


T = table(age, height, weight);
T.Properties.RowNames = firstNames;
T.Properties.VariableNames = variableNames;
% Here we are adding the dimension names to our property, so first property
% name will be the title of the very first dimension of the table. In this
% case Person Name
T.Properties.DimensionNames = {'Person Name', 'IDK'};
T.Properties.Description = 'This table is about age height and weight of the person';

% Finally to write table we use function called as writetable() given as
% follows, setting 'WriteRowNames' true allows table to write rows, 
writetable(T, 'myFirstWriteTable.xls', 'WriteRowNames', true);

