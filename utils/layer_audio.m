function audio = layer_audio(fs, varargin)
    num_args = size(varargin, 2);
    length_samples = 0;
    if mod(num_args, 2) ~= 0
        error("wrong number of arguments for layer_audio")
    end
    for i = 1:num_args / 2
        time_s = varargin{2 * i - 1};
        clip = varargin{2 * i};
        length_samples = max(length_samples, round(fs * time_s + size(clip, 2)));
    end
    audio = zeros(1, length_samples);
    for i = 1:num_args / 2
        time_s = varargin{2 * i - 1};
        clip = varargin{2 * i};
        zeros_before = zeros(1, round(time_s * fs));
        zeros_after = zeros(1, length_samples - size(zeros_before, 2) - size(clip, 2));
        layer = cat(2, zeros_before, clip, zeros_after);
        audio = audio + layer;
    end
end