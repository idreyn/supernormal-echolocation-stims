classdef Material
    properties
        sound_speed {mustBeNumeric}
        density {mustBeNumeric}
        alpha_coeff {mustBeNumeric}
    end
    
    methods
        function mat = Material(sound_speed, density, alpha_coeff)
          arguments
              sound_speed double
              density double
              alpha_coeff double
          end
          mat.sound_speed = sound_speed;
          mat.density = density;
          mat.alpha_coeff = alpha_coeff;
        end
    end
end

