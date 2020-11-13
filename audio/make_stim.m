function stim_realtime = make_stim(hrirs, fs, speed_of_sound, pulse, azimuth_heading, stretch_factor, separation_factor)
    arguments
        hrirs (360,:)
        fs {mustBeNumeric}
        speed_of_sound {mustBeNumeric}
        pulse (1,:)
        azimuth_heading {mustBeNumeric}
        stretch_factor {mustBeNumeric}
        separation_factor {mustBeNumeric}
    end
    pulse_waveform = render_pulse(pulse, fs);
    receiver_heading_offset = 180 / pi * asin(1 / separation_factor);
    pulse_wait_time_s = 1 / speed_of_sound;
    % First element in hrir is at left ear (heading = -90)
    azimuth_hrir_index = 90 - azimuth_heading + 1;
    left_receiver_index = normalize_heading(round(azimuth_hrir_index - receiver_heading_offset));
    right_receiver_index = normalize_heading(round(azimuth_hrir_index + receiver_heading_offset));
    channels = {[],[]};
    channel_index = 1;
    for receiver_index = [left_receiver_index, right_receiver_index]
        hrir = hrirs(receiver_index, :);
        echo = conv(hrir, pulse_waveform);
        channels{channel_index} = layer_audio(fs, 0, pulse_waveform, pulse_wait_time_s, echo);
        channel_index = channel_index + 1;
    end
    stim_realtime = [channels{1}; channels{2}];
    stim = resample(stim_realtime', stretch_factor, 1)';
    soundsc(stim, fs);
end