function source = make_impulse_source(params, mask, power_pa)
    arguments
        params SimulationParameters
        mask (:,:)
        power_pa double {mustBePositive}
    end
    impulse = zeros(size(params.grid.t_array));
    impulse(1) = power_pa;
    source.p_mask = mask;
    source.p = impulse;
end