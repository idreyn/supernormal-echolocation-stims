function output = normalize_heading(input)
    output = input;
    while output >= 360
        output = output - 360;
    end
    while output < 0
        output = output + 360;
    end
end
       

function [fs, y, actual_stretch_factor] = make_stim(hrir, stimulus, azimuth_heading, target_stretch_factor)
    arguments
        hrir (360, :)
        stimulus (1,:)
        azimuth {mustBeNumeric}
        target_stretch_factor {mustBeNumeric}
    end
    receiver_heading_offset = 180 / pi * asin(1 / target_stretch_factor);
    % First element in hrir is at left ear (heading = -90)
    azimuth_hrir_index = 90 - azimuth_heading;
    left_receiver_index = normalize_heading(azimuth_hrir_index - receiver_heading_offset);
    right_receiver_index = normalize_heading(azimuth_hrir_index + receiver_heading_offset);
    
end