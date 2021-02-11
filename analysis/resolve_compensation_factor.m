function compensation = resolve_compensation_factor(slowdown, compensation_descriptor)
    if string(compensation_descriptor) == "full"
        compensation = slowdown;
    elseif string(compensation_descriptor) == "half"
        compensation = slowdown / 2;
    else
        compensation = compensation_descriptor;
    end
end