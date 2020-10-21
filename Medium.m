classdef Medium < handle
    properties
        params
        sound_speed
        sound_speed_ref
        density
    end
    
    methods
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
                params Parameters
                air Material
            end
            medium.params = params;
            medium.sound_speed = zeros(params.Nx, params.Ny) + air.sound_speed;
            medium.density = zeros(params.Nx, params.Ny) + air.density;
            medium.sound_speed_ref = air.sound_speed;
        end
    end
end
