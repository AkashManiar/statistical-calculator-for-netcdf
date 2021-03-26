function plotBidecadalLine(bi_dec_ann, season)
    polygons = {'css', 'ess', 'wss', 'gom'};
    experimets = {'historical', 'ssp245', 'ssp370'};
    all_colors = containers.Map({'historical', 'ssp245', 'ssp370'}, {{'#ff1ac6', '#0000e6', '#00e600', '#e60000'}, {'#ff4dd2', '#3333ff', '#33ff33', '#ff3333'}, {'#e6e600', '#000000', '#404040', '#1affff'}});
    bi_decadal_range = containers.Map({'historical', 'ssp245', 'ssp370'}, {{1995, 2014}, {2025, 2044}, {2025, 2044}});
    
    for i=1:length(experimets)
        exp_color = all_colors(experimets{i});
        duration = bi_decadal_range(experimets{i});
        for j=1:length(polygons)
            filter = strcmp(bi_dec_ann.experiment, experimets{i}) & strcmp(bi_dec_ann.polygon, polygons{j});
            if nargin == 2
                filter = filter & strcmp(bi_dec_ann.season, season);
            end
            results = bi_dec_ann(filter, :);
            color = exp_color{j};
            x = [duration{1} duration{2}];
            y = [results.mean results.mean];
            line(x, y, 'Color', color, 'HandleVisibility','off');
        end
    end
end