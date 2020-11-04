function sensor_data_resampled = save_hrir(kgrid, sensor, sensor_data, fs)
    f0 = round(1 / (kgrid.t_array(2) - kgrid.t_array(1)));
    sensor_data_reordered = cast(reorderSensorData(kgrid, sensor, sensor_data), 'double');
    sensor_data_resampled = resample(sensor_data_reordered', fs, f0)';
    
    mkdir('data');
    filename = strcat('data/hrir-', datestr(now,'yyyy-mm-dd-HHMMSS'), '.h5');
     
    h5create(filename, '/fs', 1);
    h5write(filename, '/fs', fs);
    
    h5create(filename, '/hrir', size(sensor_data_resampled));
    h5write(filename, '/hrir', sensor_data_resampled);
end