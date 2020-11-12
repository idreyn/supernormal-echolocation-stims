function [mask, focus_gp] = make_parabolic_mask(params, focus_x_m, focus_y_m, focal_width_m, heading_deg)
    arguments
        params Parameters
        focus_x_m double
        focus_y_m double
        focal_width_m double {mustBePositive}
        heading_deg double
    end
    a = 1 / focal_width_m;
    c = - 1 / (4 * a);
    theta = pi / 2 - angle_from_heading(heading_deg);
    rotate = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    mask = zeros(params.Nx, params.Ny);
    focus_gp = m_point_to_grid(params,[focus_x_m, focus_y_m]);
    for i = 1 : params.Nx
        for j = 1 : params.Ny
           m_point = grid_point_to_m(params, [j i]);
           x = m_point(1) - focus_x_m;
           y = m_point(2) - focus_y_m;
           transform = rotate * [x; y];
           v = transform(1);
           w = transform(2);
           boundary = a * v^2 + c;
           if w > boundary
               mask(j, i) = 1;
           end
        end
    end
end