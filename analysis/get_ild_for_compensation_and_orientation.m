function ild = get_ild_for_compensation_and_orientation(hrirs, compensation_factor, receiver_orientation_index)
    arguments
        hrirs (:,:,:)
        compensation_factor double {mustBePositive}
        receiver_orientation_index {mustBeInteger}
    end
    
    azimuths_deg = 0:1:179;
    ild = zeros(1, 180);

    for azimuth_deg = azimuths_deg
        [left_hrir,right_hrir] = get_stereo_hrirs(hrirs, azimuth_deg, compensation_factor, receiver_orientation_index);
        left_power = sum(left_hrir .^ 2);
        right_power = sum(right_hrir .^ 2);
        ild(azimuth_deg + 1) = 10 * log10(right_power / left_power);
    end
end