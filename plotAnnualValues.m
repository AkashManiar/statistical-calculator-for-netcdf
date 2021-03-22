function plotAnnualValues(css, ess, wss, gom, variant, model, sspName)
    title_str = model + " (" + variant+ "), from historical & " + sspName + " experiments,";
    figure
    plot(ess.start_year, ess.('Annual mean'), 'blue', 'DisplayName','ess');
    hold on;
    plot(css.start_year, css.('Annual mean'), 'green', 'DisplayName','css');
    hold on;
    plot(wss.start_year, wss.('Annual mean'), 'magenta', 'DisplayName','wss');
    hold on;
    plot(gom.start_year, gom.('Annual mean'), 'cyan', 'DisplayName','gom');
    xline(2021, 'red', {'2021'}, 'HandleVisibility','off', 'LineWidth',2);
    xlabel('Year');
    ylabel("Sea Surface Temperature (C"+char(176)+")");
    title({"Annual Mean, ", title_str, "1955-2044"});
    hold off;
    grid on;
    grid minor;
    l = legend('show');
    l.Title.String = model+ " (" + variant + ")";
end