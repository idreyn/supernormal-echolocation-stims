function mask = make_wall(params, start_point, end_point, thickness_m)
    start_point_grid = m_point_to_grid(params, start_point);
    end_point_grid = m_point_to_grid(params, end_point);
    Ay = start_point_grid(1);
    Ax = start_point_grid(2);
    By = end_point_grid(1);
    Bx = end_point_grid(2);
    mask = zeros(params.Nx, params.Ny);
    normal = pi / 2 + atan2(By - Ay, Bx - Ax);
    thickness_grid_points = m_to_grid_points(params, thickness_m);
    for i = 0:(2 * thickness_grid_points - 1)
       Ax_n = round(Ax + 0.5 * i * cos(normal));
       Ay_n = round(Ay + 0.5 * i * sin(normal));
       Bx_n = round(Bx + 0.5 * i * cos(normal));
       By_n = round(By + 0.5 * i * sin(normal));
       line = makeLine(params.Nx, params.Ny, [Ay_n, Ax_n], [By_n, Bx_n]);
       mask = mask + line;
    end
    mask(mask > 1) = 1;
end