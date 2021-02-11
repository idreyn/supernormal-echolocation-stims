function stim = make_stim_from_hrirs(fs, left_hrir, right_hrir, pulse, echo_delay_s, pulse_amplitude)
    arguments
        fs double
        left_hrir (1,:)
        right_hrir (1,:)
        pulse Pulse
        echo_delay_s double
        pulse_amplitude double = 1
    end
    hrirs = {left_hrir, right_hrir};
    channels = {[],[]};
    pulse_waveform = render_pulse(pulse, fs);
    for i = 1:2
        hrir = hrirs{i};
        echo = conv(hrir, pulse_waveform);
        channels{i} = layer_audio(fs, 0, pulse_amplitude * pulse_waveform, echo_delay_s, 0.1 * echo);
    end
    stim = [channels{1}; channels{2}];
end