function stim = make_kemar_stim(kemar_hrir, pulse, heading_index)
    fs = 44100;
    pulse_waveform = render_pulse(pulse, fs);
    channels = {[],[]};
    channel_index = 1;
    for i = 1:2
        hrir = squeeze(kemar_hrir(heading_index, i, :));
        echo = conv(hrir, pulse_waveform);
        channels{channel_index} = layer_audio(fs, 0, echo);
        plot(i + channels{channel_index});
        hold on
        channel_index = channel_index + 1;
    end
    stim = [channels{1}; channels{2}];
    soundsc(stim, fs);
end