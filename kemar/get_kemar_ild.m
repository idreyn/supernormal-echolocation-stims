function ild_truncated = get_kemar_ild(fs, hrirs, passband)
    headings = 0:5:180;
    num_headings = size(headings, 2);
    ild = zeros(1, num_headings);
    for i = 1:num_headings
        heading = headings(i);
        [left_hrir, right_hrir] = get_kemar_hrirs_for_heading(hrirs, heading);
        left = bandpass(left_hrir, passband, fs);
        right = bandpass(right_hrir, passband, fs);
        left_power = sum(left .^ 2);
        right_power = sum(right .^ 2);
        ild(i) = 10 * log10(right_power / left_power);
    end
    ild_resampled = resample(ild, 5, 1);
    ild_truncated = ild_resampled(1, 1:180);
end
        