function mask = make_sensor_mask(params, offset_radius_m, sensor_headings)
    arguments
        params Parameters
        offset_radius_m double {mustBePositive}
        sensor_headings
    end
    mask = zeros(params.Nx, params.Ny);
    offset_radius_m_corrected = offset_radius_m + grid_points_to_m(params, 1);
    for heading = sensor_headings
        point = m_polar_to_grid(params, offset_radius_m_corrected, heading);
        mask(make_point_mask(params, point) == 1) = 1;
    end
    expected_points = size(sensor_headings, 2)
    actual_points = sum(sum(mask))
    if expected_points ~= actual_points
        error("Grid is not fine enough for given sensor_headings");
    end
end