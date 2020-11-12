[fs, hrirs] = load_hrir("data/notched-headband.h5");

hold on

colors = gray(10);
separation_factor = 5;

for j = 6:6
    color = colors(9 - j, :);
    ka = 2 .^ j;
    c = 343;
    a_m = 0.0875;
    f_hz = c * (ka / a_m) / (2 * pi);
    headings = 0:1:179;
    ilds_bandpassed = zeros(size(headings));
    ilds = zeros(size(headings));
    passband = [f_hz - 250 ,f_hz + 250];
    
    receiver_heading_offset = 180 / pi * asin(1 / separation_factor);

    for i = 0:1:179
        left_heading = normalize_heading(90 + round(i - receiver_heading_offset));
        right_heading =  normalize_heading(90 + round(i + receiver_heading_offset));

        left_hrir = hrirs(left_heading + 1, :);
        right_hrir = hrirs(right_heading + 1, :);

        left_power = sum(left_hrir .^ 2);
        right_power = sum(right_hrir .^ 2);

        left_bandpassed = bandpass(left_hrir, passband, fs);
        right_bandpassed = bandpass(right_hrir, passband, fs);

        left_bandpassed_power = sum(left_bandpassed .^ 2);
        right_bandpassed_power = sum(right_bandpassed .^ 2);

        ilds(i + 1) = 10 * log10(left_power / right_power);  
        ilds_bandpassed(i + 1) = 10 * log10(left_bandpassed_power / right_bandpassed_power);        
    end
    
    plot(ilds_bandpassed, 'Color', color)
end

plot(ilds)

hold off