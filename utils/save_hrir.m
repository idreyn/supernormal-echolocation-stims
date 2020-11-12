function sensor_data_resampled = save_hrir(params, sensor_data_reordered, fs, f_pass)
    sensor_data_resampled = resample_hrir(params, sensor_data_reordered, fs, f_pass);
    
    mkdir('data');
    filename = strcat('data/hrir-', datestr(now,'yyyy-mm-dd-HHMMSS'), '.h5');
     
    h5create(filename, '/fs', 1);
    h5write(filename, '/fs', fs);
    
    h5create(filename, '/hrir', size(sensor_data_resampled));
    h5write(filename, '/hrir', sensor_data_resampled);
end