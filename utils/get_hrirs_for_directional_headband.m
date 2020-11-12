function [fs, hrirs] = get_hrirs_for_directional_headband(notch_offset_m, notch_focal_width_m, notch_heading_deg, grid_resolution_m)
    arguments
        notch_offset_m
        notch_focal_width_m
        notch_heading_deg
        grid_resolution_m = 0.01;
    end
    
    head_radius_m = 0.0875;
    headband_thickness_m = 0.02;
    skull_thickness = 0.005;

    grid_resolution_hz = 5e4;
    grid_radius_m = 1.2;
    
    fs = 192000;
    f_pass = 2e4;

    impulse_pressure_pa = 1e3;

    sensor_headings = 0:1:359;
    sensor_radius = 1;

    air = Material(343, 1.225);
    water = Material(1480, 1000);
    plastic = Material(0, 1070);
    bone = Material(3515, 1800);

    params = Parameters(grid_resolution_hz, 2 * grid_radius_m, grid_resolution_m);
    medium = Medium(params, air);

    head_radius =  m_to_grid_points(params, head_radius_m);
    head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius);
    apply_mask(medium, water, head);
    
    skull = make_headband(params, head_radius_m - skull_thickness, skull_thickness);
    apply_mask(medium, bone, skull);

    [headband, focus_mask] = make_directional_headband(params, head_radius_m, notch_offset_m, notch_focal_width_m, notch_heading_deg, headband_thickness_m);
    apply_mask(medium, plastic, headband);

    set_timestep_from_medium(params, medium);

    sensor = make_sensor_ring(params, sensor_radius, sensor_headings);
    source = make_impulse_source(params, focus_mask, impulse_pressure_pa);
    
    if ispc
        sensor_data = kspaceFirstOrder2DG(params.grid, get_struct(medium), source, sensor);
    else
        sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor, 'DataCast', 'single');
    end
    
    sensor_data_reordered = reorderSensorData(params.grid, sensor, sensor_data);
    hrirs = save_hrir(params, sensor_data_reordered, fs, f_pass);
    
    figure
    subplot(311)
    plot_gain(sensor_headings, hrirs)
    subplot(312)
    plot_ild_by_separation(fs, hrirs)
    subplot(313)
    imagesc(headband + 2 * focus_mask)
end