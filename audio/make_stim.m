function stim_realtime = make_stim(hrirs, fs, speed_of_sound, pulse, heading, stretch_factor, compensation, orientation_index)
    arguments
        hrirs (:,:,:)
        fs {mustBeNumeric}
        speed_of_sound {mustBeNumeric}
        pulse (1,:)
        heading {mustBeNumeric}
        stretch_factor {mustBeNumeric}
        compensation {mustBeNumeric}
        orientation_index {mustBeNumeric}
    end
    pulse_waveform = render_pulse(pulse, fs);
    pulse_wait_time_s = 1 / speed_of_sound;
    [left_receiver_index, right_receiver_index] = get_receiver_indices(heading, compensation);
    [left_orientation_index, right_orientation_index] = get_orientation_indices(hrirs, orientation_index);
    channels = {[],[]};
    channel_index = 1;
    indices = {{right_orientation_index, right_receiver_index},{left_orientation_index, left_receiver_index}};
    for i = 1:2
        hrir = squeeze(hrirs(indices{i}{1}, indices{i}{2}, :));
        echo = conv(hrir, pulse_waveform);
        channels{channel_index} = layer_audio(fs, 0, 0 * pulse_waveform, pulse_wait_time_s, echo);
        plot(i + channels{channel_index});
        hold on
        channel_index = channel_index + 1;
    end
    stim_realtime = [channels{1}; channels{2}];
    stim = resample(stim_realtime', stretch_factor, 1)';
    soundsc(stim, fs);
end