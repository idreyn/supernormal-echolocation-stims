notch_headings = -80:10:80;
num_notch_headings = size(notch_headings, 2);
notch_hrirs_ca(1:num_notch_headings) = {[]};

i = 1;
for heading = notch_headings
    [fs, hrirs] = get_hrirs_for_directional_headband(0.015, 0.01, heading, 0.002);
    notch_hrirs_ca{i} = hrirs;
    i = i + 1
end

hrir_size = size(notch_hrirs_ca{1});
notch_hrirs = zeros(num_notch_headings, hrir_size(1), hrir_size(2));
for i = 1:num_notch_headings
    notch_hrirs(i, :, :) = notch_hrirs_ca{i};
end

