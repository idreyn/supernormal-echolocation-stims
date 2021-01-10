function plot_gain_for_all_receiver_orientations(hrirs)
    headings = 0:1:359;
    num_orientations = size(hrirs,1);
    colors = jet(num_orientations);
    for i = 1:num_orientations
        color = colors(i,:);
        hrir = squeeze(hrirs(i,:,:));
        energies = sum(hrir' .^ 2)';
        energies_db = 10 * log10(energies);
        polarplot(headings * pi / 180, energies_db, 'Color', color);
        hold on
    end
end