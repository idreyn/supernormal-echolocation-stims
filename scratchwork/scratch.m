params = Parameters(4, 3, 0.02);
air = Material(343, 1.225);
water = Material(1480, 1000);
wood = Material(4874, 835);
medium = Medium(params, air);
head_size =  m_to_grid_points(params, 0.09);
head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, head_size);
apply_mask(medium, water, head);
target = make_target(params, 1, 45);
apply_mask(medium, wood, target);

disc_magnitude = 5; % [Pa]
disc_x_pos = 50;    % [grid points]
disc_y_pos = 50;    % [grid points]
disc_radius = 8;    % [grid points]
disc_1 = disc_magnitude * makeDisc(params.Nx, params.Ny, disc_x_pos, disc_y_pos, disc_radius);

disc_magnitude = 3; % [Pa]
disc_x_pos = 80;    % [grid points]
disc_y_pos = 60;    % [grid points]
disc_radius = 5;    % [grid points]
disc_2 = disc_magnitude * makeDisc(params.Nx, params.Ny, disc_x_pos, disc_y_pos, disc_radius);

source.p0 = disc_1 + disc_2;

% define a centered circular sensor
sensor_radius = 4e-3;   % [m]
num_sensor_points = 50;
sensor.mask = makeCartCircle(sensor_radius, num_sensor_points);

sensor_data = kspaceFirstOrder2D(params.grid, get_struct(medium), source, sensor);