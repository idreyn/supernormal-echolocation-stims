function [left_hrir, right_hrir] = get_stereo_hrirs_2(hrirs, incident_azimuth_deg, compensation_factor, orientation_index)
    arguments
        hrirs (17,360,:)
        incident_azimuth_deg {mustBeNumeric}
        compensation_factor {mustBePositive}
        orientation_index {mustBePositive}
    end
    right_receiver_azimuth_deg = 180 / pi * asin(1 / compensation_factor)
    left_receiver_azimuth_deg = 0 - right_receiver_azimuth_deg
    angle_between_right_receiver_and_incident_azimuth_deg = incident_azimuth_deg - right_receiver_azimuth_deg
    angle_between_left_receiver_and_incident_azimuth_deg = incident_azimuth_deg - left_receiver_azimuth_deg
    right_hrir_index = get_hrir_index_for_relative_angle(angle_between_right_receiver_and_incident_azimuth_deg)
    left_hrir_index = get_hrir_index_for_relative_angle(angle_between_left_receiver_and_incident_azimuth_deg)
    [left_orientation_index, right_orientation_index] = get_orientation_indices(hrirs, orientation_index)
    left_hrir = squeeze(hrirs(left_orientation_index, left_hrir_index, :));
    right_hrir = squeeze(hrirs(right_orientation_index, right_hrir_index, :));
end

function index = get_hrir_index_for_relative_angle(angle_deg)
    index = 1 + normalize_heading(90 + round(angle_deg));
end

