params = Parameters(1e4, 1, 0.05);
air = Material(343, 1.225);
water = Material(1480, 1000);
plastic = Material(2170, 1070);
medium = Medium(params, air);
head_radius_m = 0.09;
headband_thickness_m = 0.01;
impulse_radius_m = 0.3;
head_radius =  m_to_grid_points(params, head_radius_m);

[parabola_mask, focus_gp] = make_parabolic_mask(params, 0, 0, 0.1, 45);
imagesc(parabola_mask);

focus_mask = make_point_mask(params, focus_gp);
sensor = make_sensor(focus_mask);
source = make_impulse_source(params, 0.5, 30, 1e4);

% head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius);
% apply_mask(medium, water, head);
% 
% headband = make_headband(params, head_radius_m, headband_thickness_m);
% apply_mask(medium, plastic, headband);

apply_mask(medium, plastic, parabola_mask);

sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor, 'RecordMovie', true, 'MovieProfile', 'MPEG-4');