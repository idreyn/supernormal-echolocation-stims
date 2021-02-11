function stim = make_stim( ...
    hrirs, ... 
    fs, ...
    pulse, ...
    target_distance_m, ...
    target_azimuth_deg, ...
    slowdown_factor, ...
    compensation_factor, ...
    orientation_index, ...
    pulse_amplitude)
    arguments
        hrirs (:,:,:)
        fs {mustBeNumeric}
        pulse Pulse
        target_distance_m {mustBeNumeric}
        target_azimuth_deg {mustBeNumeric}
        slowdown_factor {mustBeNumeric}
        compensation_factor {mustBeNumeric}
        orientation_index {mustBeNumeric}
        pulse_amplitude {mustBeNumeric} = 1
    end
    echo_delay_s = 2 * target_distance_m / 343;
    [left_hrir, right_hrir] = get_stereo_hrirs( ...
        hrirs, ...
        target_azimuth_deg, ...
        compensation_factor, ...
        orientation_index);
    stim_realtime = make_stim_from_hrirs( ...
        fs, ...
        left_hrir, ...
        right_hrir, ...
        pulse, ...
        echo_delay_s, ...
        pulse_amplitude);
    stim = resample(stim_realtime', slowdown_factor, 1)';
end