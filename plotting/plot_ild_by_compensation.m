function plot_ild_by_compensation(hrirs)
    hold on
    xlabel('Azimuth (degrees)');
    ylabel('ILD (dB)');

    compensations = 1:25;
    headings = 0:179;
    colors = 0.75 * flip(gray(size(compensations, 2)));

    for comp = compensations
        color = colors(comp, :);
        ilds = zeros(size(headings));   
        receiver_heading_offset = 180 / pi * asin(1 / comp);

        for i = headings
            left_heading = normalize_heading(90 + round(i - receiver_heading_offset));
            right_heading = normalize_heading(90 + round(i + receiver_heading_offset));

            left_hrir = hrirs(left_heading + 1, :);
            right_hrir = hrirs(right_heading + 1, :);

            left_power = sum(left_hrir .^ 2);
            right_power = sum(right_hrir .^ 2);

            ilds(i + 1) = 10 * log10(left_power / right_power);  
        end

        plot(ilds, 'Color', color)
    end

    hold off
end