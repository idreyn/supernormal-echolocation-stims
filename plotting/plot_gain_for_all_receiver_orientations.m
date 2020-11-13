function plot_gain_for_all_receiver_orientations(headings, hrirs)
    num_orientations = size(hrirs,1);
    for i = 1:num_orientations
        color = [1,1,1] * 0.75 * abs(i - ceil(num_orientations/2)) / ceil(num_orientations/2);
        hrir = squeeze(hrirs(i,:,:));
        energies = sum(hrir' .^ 2)';
        energies_db = 10 * log10(energies);
        polarplot(headings * pi / 180, energies_db, 'Color', color);
        hold on
    end
end