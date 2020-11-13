function ild = get_ild_for_compensation_and_orientation(hrirs, compensation_factor, receiver_orientation_index)
    arguments
        hrirs (:,:,:)
        compensation_factor double {mustBePositive}
        receiver_orientation_index {mustBeInteger}
    end
    
    num_orientations = size(hrirs, 1);
    headings = 0:1:179;
    ild = zeros(1, 180);

    for heading = headings
        [left_index, right_index] = get_receiver_indices(heading, compensation_factor);

        left_hrir = hrirs(receiver_orientation_index, left_index, :); 
        right_hrir = hrirs(num_orientations - receiver_orientation_index + 1, right_index, :);

        left_power = sum(left_hrir .^ 2);
        right_power = sum(right_hrir .^ 2);

        ild(heading + 1) = 10 * log10(left_power / right_power);
    end
end