function plot_gain(headings, hrirs)
    energies = sum(hrirs' .^ 2)';
    energies_db = 10 * log10(energies);
    min_energy = min(0, min(energies_db));
    norm_energies_db = energies_db - min_energy;
    polarplot(headings * pi / 180, norm_energies_db);
end