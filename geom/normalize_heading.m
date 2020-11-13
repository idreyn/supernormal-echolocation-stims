function output = normalize_heading(input)
    output = input;
    while output >= 360
        output = output - 360;
    end
    while output < 0
        output = output + 360;
    end
end