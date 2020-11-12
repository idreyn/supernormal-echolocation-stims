function plot_ild_by_separation(fs, hrirs)
    relevant_hrirs = bandpass(hrirs', [2e4, 9e4], fs)';

    hold on
    xlabel('Azimuth (degrees)');
    ylabel('ILD (dB)');

    separations = 1:25;
    headings = 0:179;
    colors = 0.75 * flip(gray(size(separations, 2)));

    for sep = separations
        color = colors(sep, :);
        ilds = zeros(size(headings));   
        receiver_heading_offset = 180 / pi * asin(1 / sep);

        for i = headings
            left_heading = normalize_heading(90 + round(i - receiver_heading_offset));
            right_heading =  normalize_heading(90 + round(i + receiver_heading_offset));

            left_hrir = relevant_hrirs(left_heading + 1, :);
            right_hrir = relevant_hrirs(right_heading + 1, :);

            left_power = sum(left_hrir .^ 2);
            right_power = sum(right_hrir .^ 2);

            ilds(i + 1) = 10 * log10(left_power / right_power);  
        end

        plot(ilds, 'Color', color)
    end

    hold off
end