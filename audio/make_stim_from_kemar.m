function stim = make_stim_from_kemar(kemar_hrirs, fs, pulse, target_distance_m, target_azimuth_deg, play_sound)
    arguments
        kemar_hrirs (73,2,:)
        fs {mustBeNumeric}
        pulse Pulse
        target_distance_m {mustBeNumeric}
        target_azimuth_deg {mustBeNumeric}
        play_sound = true
    end
    echo_delay_s = (2 * target_distance_m) / 343;
    [left_hrir, right_hrir] = get_kemar_hrirs_for_heading(kemar_hrirs, target_azimuth_deg);
    stim = make_stim_from_hrirs( ...
        fs, ...
        left_hrir, ...
        right_hrir, ...
        pulse, ...
        echo_delay_s);
    if play_sound
       soundsc(stim, fs); 
    end
end