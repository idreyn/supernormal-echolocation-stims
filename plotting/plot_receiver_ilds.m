function plot_receiver_ilds(head_radius_m, receiver_orientations, hrirs, compensation_factor)
    arguments
        head_radius_m double
        receiver_orientations (1,:)
        hrirs (:,:,:)
        compensation_factor {mustBePositive}
    end
    receiver_separation_cm = round(100 * 2 * head_radius_m / compensation_factor, 1);
    num_orientations = size(hrirs, 1);
    headings = 0:1:179;
    ilds = zeros(num_orientations, 180);
    title = strcat( ...
        'Receiver separation=', ... 
        string(receiver_separation_cm), 'cm', ...
        ' (compensation=', string(compensation_factor), 'x)');

    for i = 1:num_orientations-1
        for heading = headings
            [left_index, right_index] = get_receiver_indices(heading, compensation_factor);

            left_hrir = hrirs(i, left_index, :); 
            right_hrir = hrirs(num_orientations - i, right_index, :);

            left_power = sum(left_hrir .^ 2);
            right_power = sum(right_hrir .^ 2);

            ilds(i, heading + 1) = 10 * log10(left_power / right_power);
        end
    end

    colors = 0.75 * gray(num_orientations);
    figure;
    
    sgtitle(title);
    subplot(311);
    imagesc(headings, receiver_orientations, ilds);

    xlabel('Echo azimuth (degrees)');
    ylabel({'Notch orientation'; 'Degrees from normal'});
    subplot(312);
    hold on
    for i = 1:num_orientations
        if i == (num_orientations + 1) / 2
            % Corresponds to the 0 degree (straight on) orientation
            color = "red";
        else
            color = colors(i,:);
        end
        plot(ilds(i, :), 'Color', color);
    end
    xlabel('Echo azimuth (degrees)');
    ylabel('ILD (dB SPL)');
    
    subplot(313);
    plot(sum(ilds,2));
    xlabel('Receiver index');
    ylabel('"total" ILD (dB SPL)');
end