function stim = make_stim_from_kemar(fs, kemar_hrirs, pulse, target_azimuth, target_distance)
    echo_delay_s = (2 * target_distance) / 343;
    [left_hrir, right_hrir] = get_kemar_hrirs_for_azimuth(kemar_hrirs, target_azimuth);
end