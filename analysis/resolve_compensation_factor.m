function compensation = resolve_compensation_factor(slowdown, compensation_denominator)
    if compensation_denominator == 0
        compensation = 1;
    else
        compensation = slowdown / compensation_denominator;
    end
end