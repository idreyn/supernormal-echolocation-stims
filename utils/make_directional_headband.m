function mask = make_directional_headband(params, radius_m, focus_distance_m, focal_width_m, thickness_m)
    arguments
        params Parameters
        radius_m double
        focus_distance_m double
        focal_width_m double
        thickness_m double
    end
    mask = make_headband(params, radius_m, thickness_m);
    for heading = [0]
        focus_angle = angle_from_heading(heading);
        focus_x = cos(focus_angle) * focus_distance_m;
        focus_y = sin(focus_angle) * focus_distance_m;
        parabola = make_parabolic_mask(params, focus_x, focus_y, focal_width_m, 0);
        mask(parabola == 1) = 0;
    end
end