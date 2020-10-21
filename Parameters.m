classdef Parameters
    properties
        max_freq_hz {mustBeNumeric} % Maximum supported stimulus frequency
        grid_size_m {mustBeNumeric} % Extent of (square) grid
        grid_resolution_m {mustBeNumeric} % Spacing between grid points
        c_0 {mustBeNumeric} % Speed of sound (m/s)
        Nx {mustBeNumeric} % Total points on x-axis of grid
        Ny {mustBeNumeric} % Total points on y-axis of grid
        grid
    end
    
    methods
        function points = m_to_grid_points(params, meters)
            points = meters / params.grid_resolution_m;
        end
        
        function params = Parameters(max_freq_hz, grid_size_m, desired_grid_resolution_m, c_0)
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
        end
    end
end

