function ild_truncated = get_kemar_ild(fs, hrirs)
    passband = [1500, 6000];
    num_headings = ceil(size(hrirs, 1) / 2);
    ild = zeros(1, num_headings);
    for i = 1:num_headings
        left = bandpass(reshape(hrirs(i,1,:), [1, 128]), passband, fs);
        right = bandpass(reshape(hrirs(i,2,:), [1, 128]), passband, fs);
        size(left);
        left_power = sum(left .^ 2);
        right_power = sum(right .^ 2);
        ild(i) = 10 * log10(left_power / right_power);
    end
    ild_resampled = resample(ild, 5, 1);
    ild_truncated = ild_resampled(1, 1:180);
end
        