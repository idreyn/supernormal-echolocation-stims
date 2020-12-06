function plot_gain(headings, hrirs)
    energies = sum(hrirs' .^ 2)';
    energies_db = 10 * log10(energies);
    polarplot(headings * pi / 180, energies_db, 'LineWidth', 2);
end