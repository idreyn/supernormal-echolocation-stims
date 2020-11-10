classdef Material
    properties
        sound_speed {mustBeNumeric}
        density {mustBeNumeric}
    end
    
    methods
        function mat = Material(sound_speed, density)
          arguments
              sound_speed double
              density double
          end
          mat.sound_speed = sound_speed;
          mat.density = density;
        end
    end
end

