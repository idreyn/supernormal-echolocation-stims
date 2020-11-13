function mask = make_target(params, distance_m, angle_deg, width_m, thickness_m)
    arguments
        params SimulationParameters
        distance_m double
        angle_deg double
        width_m double = 0.5
        thickness_m double = 0.02
    end
    half_width = width_m / 2;
    angle = (angle_deg + 90) * (pi / 180);
    normal = angle - pi / 2;
    midpoint_x = distance_m * cos(angle);
    midpoint_y = distance_m * sin(angle);
    start_x = midpoint_x - half_width * cos(normal);
    start_y = midpoint_y - half_width * sin(normal);
    end_x = midpoint_x + half_width * cos(normal);
    end_y = midpoint_y + half_width * sin(normal);
    mask = make_wall(params, [start_x, start_y], [end_x, end_y], thickness_m);
end