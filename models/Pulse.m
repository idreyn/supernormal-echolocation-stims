classdef Pulse
    properties
        f0 {mustBeNumeric} % Start frequency
        f1 {mustBeNumeric} % End frequency
        duration_s {mustBeNumeric}
        kind % 'linear', 'quadratic', 'logarithmic' etc
    end
    
    methods
        function pulse = Pulse(f0, f1, duration_s, kind)
            arguments
                f0 double
                f1 double
                duration_s double
                kind = 'linear'
            end
            pulse.f0 = f0;
            pulse.f1 = f1;
            pulse.duration_s = duration_s;
            pulse.kind = kind;
        end
        
        function arr = render_pulse(pulse, fs)
            time = 0 : (1 / fs) : pulse.duration_s - (1 / fs);
            arr = chirp(time, pulse.f0, pulse.duration_s, pulse.f1, pulse.kind);
        end
    end
end