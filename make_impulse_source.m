function source = make_impulse_source(params, distance_m, angle_deg, power_pa)
    arguments
        params Parameters
        distance_m double {mustBePositive}
        angle_deg double
        power_pa double {mustBePositive}
    end
    source_grid_point = m_polar_to_grid(params, distance_m, angle_deg);
    impulse = zeros(size(params.grid.t_array));
    impulse(1) = power_pa;
    source.p_mask = make_point_mask(params, source_grid_point);
    source.p = impulse;
end