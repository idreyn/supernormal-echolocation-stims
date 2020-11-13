function plot_opposite_gains_for_orientation(headings, hrirs, orientation_index)
    [left_index, right_index] = get_orientation_indices(hrirs, orientation_index);
    for idx = [left_index, right_index]
        plot_gain(headings, squeeze(hrirs(idx,:,:)));
        hold on
    end
end