function [fs, hrirs] = load_kemar_hrirs()
    fs = 44100;
    headings = -180:5:180;
    num_headings = size(headings, 2);
    hrirs = zeros(num_headings, 2, 128);
    for i = 1:num_headings
        hrir = load_kemar_hrir_at_heading(headings(i));
        hrirs(i,:,:) = hrir;
    end
    max_sample = max(max(max(hrirs)));
    hrirs = hrirs ./ max_sample;
end