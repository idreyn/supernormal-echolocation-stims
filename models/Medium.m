classdef Medium < handle
    properties
        params
        sound_speed
        sound_speed_ref
        sound_speed_max
        density
        alpha_coeff
        alpha_power
    end
    
    methods
        function struct = get_struct(medium)
            arguments
                medium Medium
            end
            struct.density = medium.density;
            struct.sound_speed = medium.sound_speed;
        end
        
        function apply_mask(medium, material, mask)
            arguments
                medium Medium
                material Material
                mask (:,:) {mustBeNumeric}
            end
            medium.sound_speed_max = max(medium.sound_speed_max, material.sound_speed);
            medium.density(mask == 1) = material.density;
            medium.sound_speed(mask == 1) = material.sound_speed;
        end 
        
        function medium = Medium(params, air)
            arguments
                params Parameters
                air Material
            end
            medium.params = params;
            medium.sound_speed = zeros(params.Nx, params.Ny) + air.sound_speed;
            medium.density = zeros(params.Nx, params.Ny) + air.density;
            medium.sound_speed_ref = air.sound_speed;
            medium.sound_speed_max = air.sound_speed;
        end
    end
end
