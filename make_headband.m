function mask = make_headband(params, head_radius_m, headband_thickness_m)
    arguments
        params Parameters
        head_radius_m double
        headband_thickness_m double
    end
    mask = zeros(params.Nx, params.Ny);
    head_radius_gp = m_to_grid_points(params, head_radius_m);
    headband_thickness_gp = m_to_grid_points(params, headband_thickness_m);
    head_plus_band = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius_gp + headband_thickness_gp);
    head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius_gp);
    mask(head_plus_band == 1) = 1;
    mask(head == 1) = 0;
    mask(params.Ny/2:params.Ny, 1:params.Nx) = 0;
end