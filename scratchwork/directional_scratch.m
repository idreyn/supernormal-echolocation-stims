head_radius_m = 0.09;
headband_thickness_m = 0.03;
head_and_headband_radius_m = head_radius_m + headband_thickness_m;

grid_resolution_hz = 5e4;
grid_resolution_m = 0.01;

impulse_heading = 0;
impulse_radius_m = head_radius_m + headband_thickness_m / 2;
sensor_radius_m = 1;
impulse_pressure_pa = 1e3;

simulation_radius_m = 1;

sensor_headings = 0:5:355;

air = Material(343, 1.225);
water = Material(1480, 1000);
plastic = Material(0, 1070);
bone = Material(3515, 1800);
foam = Material(30, 10);

params = Parameters(grid_resolution_hz, 2 * simulation_radius_m, grid_resolution_m);
medium = Medium(params, air);

head_radius =  m_to_grid_points(params, head_radius_m);
head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_radius);
apply_mask(medium, water, head);


headband = make_directional_headband(params, [0], head_radius_m, impulse_radius_m, headband_thickness_m);
apply_mask(medium, plastic, headband);

skull = make_headband(params, head_radius_m - 0.05, 0.05);
apply_mask(medium, foam, skull);

set_timestep_from_medium(params, medium);

sensor_mask = make_sensor_mask(params, 0.75, sensor_headings);
sensor = make_sensor(sensor_mask);
source = make_impulse_source(params, impulse_radius_m + 0.01, impulse_heading, impulse_pressure_pa);

if max(max((headband + head) .* sensor_mask)) ~= 0
    error("sensor is overlapping head elements");
end

if ispc
    sensor_data = kspaceFirstOrder2DG(params.grid, get_struct(medium), source, sensor);
else
    sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor, 'DataCast', 'single');
end

sd = reorderSensorData(params.grid, sensor, sensor_data);