function sensor_data_bandpassed = resample_hrir(params, sensor_data_reordered, fs, f_pass)
    f0 = round(1 / (params.grid.t_array(2) - params.grid.t_array(1)));
    [a, b] = rat(fs / f0);
    sensor_data_cast = cast(sensor_data_reordered, 'double');
    sensor_data_resampled = resample(sensor_data_cast', a, b)';
    sensor_data_bandpassed = bandpass(sensor_data_resampled', [f_pass, fs - 1], fs)';
end