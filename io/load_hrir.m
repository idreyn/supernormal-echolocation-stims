function [fs, hrirs] = load_hrir(filename)
    hrirs = h5read(filename, '/hrir');
    fs = h5read(filename, '/fs');
end