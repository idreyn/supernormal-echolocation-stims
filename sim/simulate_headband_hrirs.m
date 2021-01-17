function hrirs = simulate_headband_hrirs(experiment_params, materials, receiver_orientation_deg, debug_plot)
    arguments
        experiment_params HeadbandExperimentParameters
        materials MaterialsBank
        receiver_orientation_deg double
        debug_plot logical = false
    end

    params = SimulationParameters( ...
       experiment_params.simulation_resolution_hz, ...
       2 * (experiment_params.sensor_radius_m + 0.1), ...
       experiment_params.simulation_resolution_m)

    medium = Medium(params, materials.air);

    head_radius =  m_to_grid_points(params, experiment_params.head_radius_m);
    head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius);
    apply_mask(medium, materials.water, head);
    
    skull = make_headband( ...
        params, ... 
        experiment_params.head_radius_m - experiment_params.skull_thickness_m, ...
        experiment_params.skull_thickness_m);
    apply_mask(medium, materials.bone, skull);

    [headband, focus_mask] = make_directional_headband( ...
        params, ...
        experiment_params.head_radius_m, ...
        experiment_params.receiver_focus_offset_m, ...
        experiment_params.receiver_focal_width_m,...
        receiver_orientation_deg, ...
        experiment_params.headband_thickness_m);
 
    apply_mask(medium, materials.plastic, headband);
    set_timestep_from_medium(params, medium);

    sensor = make_sensor_ring(params, experiment_params.sensor_radius_m, experiment_params.headings_deg);
    source = make_impulse_source(params, focus_mask, experiment_params.impulse_pressure_pa);
   
    if debug_plot
        imagesc(headband)
        pause(60);
    end
    
    if ispc
        sensor_data = kspaceFirstOrder2DG(params.grid, get_struct(medium), source, sensor);
    else
        sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor, 'DataCast', 'single');
    end
    
    sensor_data_reordered = reorderSensorData(params.grid, sensor, sensor_data);
    hrirs = resample_hrir(params, sensor_data_reordered, experiment_params.fs_hz, experiment_params.f_pass_hz);
    
    if debug_plot
        figure
        subplot(311)
        plot_gain(experiment_params.headings_deg, hrirs)
        subplot(312)
        plot_ild_by_separation(experiment_params.fs_hz, hrirs)
        subplot(313)
        imagesc(headband + 2 * focus_mask)
    end
end