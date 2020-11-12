head_radius_m = 0.09;
headband_thickness_m = 0.01;
head_and_headband_radius_m = head_radius_m + headband_thickness_m;

grid_resolution_hz = 5e4;
grid_resolution_m = 0.002;

impulse_heading = 0;
impulse_radius_m = 1;
impulse_pressure_pa = 1e3;

simulation_radius_m = impulse_radius_m * 1.25;

sensor_headings = 0:1:359;

air = Material(343, 1.225);
water = Material(1480, 1000);
plastic = Material(2170, 1070);

params = Parameters(grid_resolution_hz, 2 * simulation_radius_m, grid_resolution_m);
medium = Medium(params, air);

head_radius =  m_to_grid_points(params, head_radius_m);
head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius);
apply_mask(medium, water, head);

headband = make_headband(params, head_radius_m, headband_thickness_m);
apply_mask(medium, plastic, headband);

set_timestep_from_medium(params, medium);

sensor_mask = make_sensor_mask(params, head_and_headband_radius_m, sensor_headings);
sensor = make_sensor(sensor_mask);
source = make_impulse_source(params, impulse_radius_m, impulse_heading, impulse_pressure_pa);

if max(max((headband + head) .* sensor_mask)) ~= 0
    error("sensor is overlapping head elements");
end

if ispc
    sensor_data = kspaceFirstOrder2DG(params.grid, get_struct(medium), source, sensor);
else
    sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor);
end

sensor_data_reordered = reorderSensorData(params.grid, sensor, sensor_data);
hrirs = save_hrir(params, sensor_data, 192000);