classdef HeadbandExperimentParameters
    properties
        simulation_resolution_m {mustBeNumeric} = 0.01
        simulation_resolution_hz {mustBeNumeric} = 5e4
        sensor_radius_m {mustBeNumeric} = 1.4
        head_radius_m {mustBeNumeric} = 0.0875
        skull_thickness_m {mustBeNumeric} = 0.005
        foam_thickness_m = 0.01
        headband_thickness_m {mustBeNumeric} = 0.02
        headings_deg (1,:) = 0:1:359
        receiver_orientations_deg (1,:) = -80:5:80
        receiver_focal_width_m = 0.01
        receiver_focus_offset_m = 0.01
        impulse_pressure_pa {mustBeNumeric} = 1
        fs_hz {mustBeNumeric} = 192000 % Sampling rate used when working with audio
        f_pass_hz {mustBeNumeric} = 20000 % Minimum frequency of ultrasound
        noise_length_samples {mustBeNumeric} = 0
    end
end

