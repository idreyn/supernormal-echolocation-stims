function [mask, focus_mask] = make_directional_headband(params, radius_m, notch_focus_offset_m, notch_focal_width_m, notch_heading_deg, thickness_m)
    arguments
        params Parameters
        radius_m double
        notch_focus_offset_m double
        notch_focal_width_m double
        notch_heading_deg
        thickness_m double
    end
    if notch_focus_offset_m >= thickness_m
        error("notch focus must be within the headband")
    end
    mask = make_headband(params, radius_m, thickness_m);
    notch_focus_distance_m = radius_m + notch_focus_offset_m;
    focus_angle = angle_from_heading(0);
    focus_x = cos(focus_angle) * notch_focus_distance_m;
    focus_y = sin(focus_angle) * notch_focus_distance_m;
    parabola = make_parabolic_mask(params, focus_x, focus_y, notch_focal_width_m, notch_heading_deg);
    mask(parabola == 1) = 0;
    focus_mask = make_point_mask(params, m_point_to_grid(params, [focus_x, focus_y]));
end