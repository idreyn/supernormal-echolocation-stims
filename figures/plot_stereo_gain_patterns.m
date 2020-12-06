function plot_stereo_gain_patterns(experiment_params, hrirs, compensation_factor, orientation_index)
    headings = experiment_params.headings_deg;
    receiver_orientation_deg = experiment_params.receiver_orientations_deg(orientation_index);
    num_headings = size(headings, 2);
    left_energies_db = zeros(1, num_headings);
    right_energies_db = zeros(1, num_headings);
    for heading_deg = experiment_params.headings_deg
        [left_hrir, right_hrir] = get_stereo_hrirs(hrirs, heading_deg, compensation_factor, orientation_index);
        energy_left_db = 10 * log10(sum(left_hrir .^ 2));
        energy_right_db = 10 * log10(sum(right_hrir .^ 2));
        left_energies_db(heading_deg + 1) = energy_left_db;
        right_energies_db(heading_deg + 1) = energy_right_db;
    end
    polaraxes('ThetaZeroLocation', 'top');
    hold on;
    polarplot(headings * pi / 180, left_energies_db);
    polarplot(headings * pi / 180, right_energies_db);
    receiver_normal_deg = get_receiver_heading_offset_for_compensation(compensation_factor);
    for heading = [0 - receiver_normal_deg, receiver_normal_deg]
        if heading > 0
            color_normal = 'red';
            color_orientation = 'red';
        else
            color_normal = 'blue';
            color_orientation = 'blue';
        end
        % Plot heading for receiver normal
        heading_r = deg2rad(heading);
        heading_offset_r = deg2rad(5);
        polarplot([heading_r heading_r], [0 20], ':', 'LineWidth', 2, 'Color', color_normal);
        polarplot([heading_r heading_r - heading_offset_r], [20 18], 'LineWidth', 2, 'Color', color_normal);
        polarplot([heading_r heading_r + heading_offset_r], [20 18], 'LineWidth', 2, 'Color', color_normal);
        % Plot heading for receiver
        if heading < 0
            heading_sign_factor = -1;
        else
            heading_sign_factor = 1;
        end
        receiver_heading_r = heading_sign_factor * deg2rad(receiver_orientation_deg) + heading_r;
        polarplot([receiver_heading_r receiver_heading_r], [0 10], 'LineWidth', 2, 'Color', color_orientation);
        polarplot([receiver_heading_r receiver_heading_r - heading_offset_r], [10 9], 'LineWidth', 2, 'Color', color_orientation);
        polarplot([receiver_heading_r receiver_heading_r + heading_offset_r], [10 9], 'LineWidth', 2, 'Color', color_orientation);
    end
    hold off;
end


