% Takes vector as %Y%m%d.%f and converts them into date format
function vector = getDateVector(x)
    vector = NaT(length(x), 1);
    for i=1:length(x)
        date_str = num2str(x(i));
        vector(i) = datetime(str2double(date_str(1:4)), str2double(date_str(5:6)), str2double(date_str(7:8)));
    end
end