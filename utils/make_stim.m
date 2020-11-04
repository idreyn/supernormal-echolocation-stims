function [fs, stim] = make_stim(hrirs, fs, pulse, azimuth_heading, stretch_factor)
    arguments
        hrirs (360,:)
        fs {mustBeNumeric}
        pulse (1,:)
        azimuth_heading {mustBeNumeric}
        stretch_factor {mustBeNumeric}
    end
    pulse_waveform = render_pulse(pulse, fs);
    receiver_heading_offset = 180 / pi * asin(1 / stretch_factor);
    pulse_wait_time_s = 1 / 343;
    % First element in hrir is at left ear (heading = -90)
    azimuth_hrir_index = 90 - azimuth_heading;
    left_receiver_index = normalize_heading(round(azimuth_hrir_index - receiver_heading_offset))
    right_receiver_index = normalize_heading(round(azimuth_hrir_index + receiver_heading_offset))
    channels = {[],[]};
    channel_index = 1;
    hold on
    for receiver_index = [left_receiver_index, right_receiver_index]
        hrir = hrirs(receiver_index, :);
        echo = conv(hrir, pulse_waveform);
        plot(hrir .^ 2)
        channels{channel_index} = layer_audio(fs, 0, pulse_waveform, pulse_wait_time_s, echo);
        channel_index = channel_index + 1;
    end
    hold off
    stim_realtime = [channels{1}; channels{2}];
    stim = resample(stim_realtime', stretch_factor, 1)';
    soundsc(stim, fs);
end

function output = normalize_heading(input)
    output = input;
    while output >= 360
        output = output - 360;
    end
    while output < 0
        output = output + 360;
    end
end