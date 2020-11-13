function mask = make_point_mask(params, point_gp)
    arguments
        params SimulationParameters
        point_gp (1,2)
    end
    mask = zeros(params.Nx, params.Ny);
    mask(point_gp(1), point_gp(2)) = 1;
end