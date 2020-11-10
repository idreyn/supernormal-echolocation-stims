function mask = make_headband(params, radius_m, thickness_m)
    arguments
        params Parameters
        radius_m double
        thickness_m double
    end
    mask = zeros(params.Nx, params.Ny);
    head_radius_gp = m_to_grid_points(params, radius_m);
    headband_thickness_gp = m_to_grid_points(params, thickness_m);
    head_plus_band = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius_gp + headband_thickness_gp);
    head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius_gp);
    mask(head_plus_band == 1) = 1;
    mask(head == 1) = 0;
end