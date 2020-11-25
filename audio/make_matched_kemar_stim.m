function stim = make_matched_kemar_stim(kemar_hrirs, fs, ultrasound_pulse, ultrasound_slowdown_factor, ultrasound_target_distance_m, target_azimuth_deg, play_sound)
    arguments
        kemar_hrirs (73,2,:)
        fs {mustBeNumeric}
        ultrasound_pulse Pulse
        ultrasound_slowdown_factor {mustBeNumeric}
        ultrasound_target_distance_m {mustBeNumeric}
        target_azimuth_deg {mustBeNumeric}
        play_sound = true
    end
    target_distance_m = ultrasound_target_distance_m * ultrasound_slowdown_factor;
    pulse = apply_slowdown_factor(ultrasound_pulse, ultrasound_slowdown_factor);
    stim = make_stim_from_kemar(kemar_hrirs, fs, pulse, target_distance_m, target_azimuth_deg, play_sound);
end