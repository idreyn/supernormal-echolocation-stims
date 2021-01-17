classdef Medium < handle
    properties
        params
        sound_speed
        density
        alpha_coeff
        alpha_power
        sound_speed_ref
    end
    
    methods
        function struct = get_struct(medium)
            arguments
                medium Medium
            end
            struct.density = medium.density;
            struct.sound_speed = medium.sound_speed;
            struct.sound_speed_ref = medium.sound_speed_ref;
            struct.alpha_power = medium.alpha_power;
            struct.alpha_coeff = medium.alpha_coeff;
        end
        
        function apply_mask(medium, material, mask)
            arguments
                medium Medium
                material Material
                mask (:,:) {mustBeNumeric}
            end
            medium.density(mask == 1) = material.density;
            medium.sound_speed(mask == 1) = material.sound_speed;
        end 
        
        function medium = Medium(params, air)
            arguments
                params SimulationParameters
                air Material
            end
            medium.params = params;
            medium.sound_speed = zeros(params.Nx, params.Ny) + air.sound_speed;
            medium.sound_speed_ref = air.sound_speed;
            medium.density = zeros(params.Nx, params.Ny) + air.density;
        end
    end
end
