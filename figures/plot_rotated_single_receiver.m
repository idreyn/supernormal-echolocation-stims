function headband = plot_rotated_single_receiver(experiment_params, receiver_heading_deg, receiver_orientation_deg)
    sim_params = SimulationParameters( ...
        experiment_params.simulation_resolution_hz, ...
        3 * experiment_params.head_radius_m, ...
        experiment_params.simulation_resolution_m, ...
        343, ...
        0);
    [headband] = make_directional_headband( ...
        sim_params, ...
        experiment_params.head_radius_m, ...
        experiment_params.receiver_focus_offset_m, ...
        experiment_params.receiver_focal_width_m,...
        receiver_orientation_deg, ...
        experiment_params.headband_thickness_m, ...
        receiver_heading_deg);
end

