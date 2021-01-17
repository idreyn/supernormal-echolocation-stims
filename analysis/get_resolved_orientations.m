function get_resolved_orientations(hrirs, stimulus_set, kemar_fs, kemar_hrirs)
    kemar_ild = get_kemar_ild(kemar_fs, kemar_hrirs, stimulus_set.audible_chirp_frequency_band_hz);
    average_directivities = get_average_directivity_for_receiver_orientations(hrirs);
    for slowdown = stimulus_set.slowdowns
        for denominator = stimulus_set.compensation_fractions_of_slowdown_denominator
            compensation = resolve_compensation_factor(slowdown, denominator);
            index = get_ild_matched_orientation_for_compensation(hrirs, kemar_ild, compensation, false);
            directivity = average_directivities(index);
            fprintf("S=%d C=%.1f I=%d D=%.1f\n", slowdown, compensation, index, directivity);
        end
    end
end