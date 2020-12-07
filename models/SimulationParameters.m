classdef SimulationParameters
    properties
        c_0 {mustBeNumeric} % Speed of sound (m/s)
        max_freq_hz {mustBeNumeric} % Maximum supported stimulus frequency
        grid_size_m {mustBeNumeric} % Extent of (square) grid
        grid_resolution_m {mustBeNumeric} % Spacing between grid points
        Nx {mustBeNumeric} % Total points on x-axis of grid
        Ny {mustBeNumeric} % Total points on y-axis of grid
        grid % k-Wave grid
        t_end_s {mustBeNumeric} % End of simulation (s)
    end
    
    methods
        function point_m = grid_point_to_m(params, point)
            arguments
                params SimulationParameters
                point (1,2)
            end
            point_m = [
                grid_points_to_m(params, point(2) - params.Nx / 2),
                grid_points_to_m(params, params.Ny / 2 - point(1))
           ];
        end
        
        function point_gp = m_point_to_grid(params, point)
            arguments
                params SimulationParameters
                point (1,2)
            end
            point_gp = [
                params.Ny / 2 - m_to_grid_points(params, point(2))
                params.Nx / 2 + m_to_grid_points(params, point(1))
           ];
        end
        
        function point_gp = m_polar_to_grid(params, distance_m, angle_deg)
            arguments
                params SimulationParameters
                distance_m double {mustBePositive}
                angle_deg double
            end
            angle_normalized_rad = angle_from_heading(angle_deg);
            x_m = distance_m * cos(angle_normalized_rad);
            y_m = distance_m * sin(angle_normalized_rad);
            point_gp = m_point_to_grid(params, [x_m, y_m]);
        end
        
        function points = m_to_grid_points(params, meters)
            points = round(meters / params.grid_resolution_m);
        end
        
        function meters = grid_points_to_m(params, grid_points)
            meters = params.grid_resolution_m * grid_points;
        end
        
        function params = SimulationParameters(max_freq_hz, grid_size_m, desired_grid_resolution_m, c_0)
            arguments
                max_freq_hz double
                grid_size_m double
                desired_grid_resolution_m double
                c_0 double = 343
            end
            params.max_freq_hz = max_freq_hz;
            params.grid_size_m = grid_size_m;
            min_grid_resolution_m = c_0 / (2 * max_freq_hz);
            min_grid_points = grid_size_m / min(desired_grid_resolution_m, min_grid_resolution_m);
            grid_points = 2 ^ ceil(log2(min_grid_points));
            grid_resolution_m = grid_size_m / grid_points;
            params.Nx = grid_points;
            params.Ny = grid_points;
            params.grid_resolution_m = grid_resolution_m;
            params.c_0 = c_0;
            params.grid = kWaveGrid(grid_points, grid_resolution_m, grid_points, grid_resolution_m);
            params.t_end_s = 0.5 * params.grid_size_m * sqrt(2) / c_0;

        end
        
        function set_timestep_from_medium(params, medium)
            arguments
                params SimulationParameters
                medium Medium
            end
            k_max = max(params.grid.k(:));
            c_max = max(max(medium.sound_speed));
            c_ref = medium.sound_speed_ref;
            dt_limit = 2 / (c_ref * k_max) * asin(c_ref / c_max);
            dt = 0.5 * dt_limit; % set to 5e-8 for atten model;
            params.grid.setTime(round(params.t_end_s / dt), dt);
        end
    end
end

