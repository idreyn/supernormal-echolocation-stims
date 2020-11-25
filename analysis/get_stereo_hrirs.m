function [left_hrir, right_hrir] = get_stereo_hrirs(hrirs, azimuth_deg, compensation_factor, orientation_index)
    arguments
        hrirs (17,360,:)
        azimuth_deg {mustBeNumeric}
        compensation_factor {mustBePositive}
        orientation_index {mustBePositive}
    end
    [left_receiver_index, right_receiver_index] = get_receiver_indices(azimuth_deg, compensation_factor);
    [left_orientation_index, right_orientation_index] = get_orientation_indices(hrirs, orientation_index);
    left_hrir = squeeze(hrirs(left_orientation_index, left_receiver_index, :));
    right_hrir = squeeze(hrirs(right_orientation_index, right_receiver_index, :));
end

