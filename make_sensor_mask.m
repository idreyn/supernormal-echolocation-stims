function mask = make_sensor_mask(params, offset_radius_m, offset_angle_deg)
    arguments
        params Parameters
        offset_radius_m double {mustBePositive}
        offset_angle_deg double {mustBePositive}
    end
    mask = zeros(params.Nx, params.Ny);
    offset_radius_m_corrected = offset_radius_m + grid_points_to_m(params, 1);
    left_point = m_polar_to_grid(params, offset_radius_m_corrected, -offset_angle_deg);
    right_point = m_polar_to_grid(params, offset_radius_m_corrected, offset_angle_deg);
    mask(make_point_mask(params, left_point) == 1) = 1;
    mask(make_point_mask(params, right_point) == 1) = 1;
end