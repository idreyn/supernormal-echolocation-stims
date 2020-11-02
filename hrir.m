head_radius_m = 0.09;
headband_thickness_m = 0.01;
head_and_headband_radius_m = head_radius_m + headband_thickness_m;
impulse_radius_m = 1;

air = Material(343, 1.225);
water = Material(1480, 1000);
plastic = Material(2170, 1070);

params = Parameters(5e4, 2 * impulse_radius_m + 0.01, 0.001);
medium = Medium(params, air);

head_radius =  m_to_grid_points(params, head_radius_m);
head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius);
apply_mask(medium, water, head);

headband = make_headband(params, head_radius_m, headband_thickness_m);
apply_mask(medium, plastic, headband);

sensor_mask = make_sensor_mask(params, head_radius_m + headband_thickness_m + 0.001, -90:1:90);
sensor = make_sensor(sensor_mask);
source = make_impulse_source(params, impulse_radius_m, 0, 1e3);

set_timestep_from_medium(params, medium);
sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor);