function source = make_noise_source(length_samples, mask, equivalent_impulse_pressure_pa)
    arguments
        length_samples double {mustBePositive}
        mask (:,:)
        equivalent_impulse_pressure_pa double {mustBePositive}
    end
    equivalent_impulse_power = equivalent_impulse_pressure_pa ^ 2;
    noise = wgn(1, length_samples, 1, 37);
    noise_power = sum(noise .^ 2);
    source.p_mask = mask;
    source.p = noise * (equivalent_impulse_power / noise_power);
end