separation = 20;
head_radius_m = 0.0875;
receiver_separation_cm = round(100 * 2 * head_radius_m / separation, 1);
num_notch_orientations = size(notch_hrirs, 1);
notch_orientations = -80:10:80;
headings = 0:1:179;
ilds = zeros(num_notch_orientations, 180);
title = strcat( ...
    'Receiver separation=', ... 
    string(receiver_separation_cm), 'cm', ...
    ' (slowdown=', string(separation), 'x)');

for i = 1:num_notch_orientations
    for heading = headings
        [left_heading, right_heading] = get_receiver_headings(heading, separation);

        left_hrir = notch_hrirs(i, left_heading + 1, :); 
        right_hrir = notch_hrirs(num_notch_orientations - i + 1, right_heading + 1, :);

        left_power = sum(left_hrir .^ 2);
        right_power = sum(right_hrir .^ 2);

        ilds(i, heading + 1) = 10 * log10(left_power / right_power);
    end
end

colors = 0.75 * gray(num_notch_orientations);
figure;
sgtitle(title);
subplot(211);
imagesc(headings, notch_orientations, ilds);

xlabel('Echo azimuth (degrees)');
ylabel({'Notch orientation'; 'Degrees from normal'});
subplot(212);
hold on
for i = 1:num_notch_orientations
    if i == (num_notch_orientations + 1) / 2
        % Corresponds to the 0 degree (straight on) orientation
        color = "red";
    else
        color = colors(i,:);
    end
    plot(ilds(i, :), 'Color', color);
end
xlabel('Echo azimuth (degrees)');
ylabel('ILD (dB SPL)');