function mask = make_directional_headband(params, sensor_headings, radius_m, focus_distance_m, thickness_m)
    arguments
        params Parameters
        sensor_headings (1, :)
        radius_m double
        focus_distance_m double
        thickness_m double
    end
    foci = zeros(size(sensor_headings, 2), 2);
    mask = make_headband(params, radius_m, thickness_m);
    i = 1;
    for heading = sensor_headings
        focus_angle = angle_from_heading(heading);
        focus_x = cos(focus_angle) * focus_distance_m;
        focus_y = sin(focus_angle) * focus_distance_m;
        foci(i, :) = [focus_x, focus_y];
        parabola = make_parabolic_mask(params, focus_x, focus_y, 0.0001, heading);
        mask(parabola == 1) = 0;
        i = i + 1;
    end
    imagesc(mask);
end