function hrir = load_kemar_hrir_at_heading(heading)
    flip = heading > 0;
    azimuth = abs(heading);
    padded_azimuth = pad(string(azimuth), 3, 'left', '0');
    filename = strcat('kemar/hrtf-data/elev0/H0e', padded_azimuth, 'a.dat');
    file = fopen(filename, 'r','ieee-be');
    data = fread(file, 256, 'short');
	fclose(file);
	ir_a = data(1:2:256);
	ir_b = data(2:2:256);
    if flip
        ir_left = ir_a;
        ir_right = ir_b;
    else
        ir_left = ir_b;
        ir_right = ir_a;
    end
    hrir = [ir_left, ir_right]';
end