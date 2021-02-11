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
            if pulse.kind == "click"
                arr = wgn(1, size(time,2), 1, 1, 1);
            else
                arr = chirp(time, pulse.f0, pulse.duration_s, pulse.f1, pulse.kind);
            end
        end
        
        function slow_pulse = apply_slowdown_factor(pulse, slowdown)
            slow_pulse = Pulse( ...
                pulse.f0 / slowdown, ...
                pulse.f1 / slowdown, ...
                pulse.duration_s * slowdown, ...
                pulse.kind);
        end
    end
end