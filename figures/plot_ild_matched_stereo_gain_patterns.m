function plot_ild_matched_stereo_gain_patterns(experiment_params, hrirs, kemar_ild, compensation_factor)
    best_orientation_index = get_ild_matched_orientation_for_compensation(hrirs, kemar_ild, compensation_factor, false);
    figure
    plot_stereo_gain_patterns(experiment_params, hrirs, compensation_factor, 9);
    figure
    plot_stereo_gain_patterns(experiment_params, hrirs, compensation_factor, best_orientation_index);
end

