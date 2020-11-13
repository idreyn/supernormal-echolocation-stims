function smoothed = smooth_hrirs(hrirs)
    smoothed = zeros(size(hrirs));
    for i = size(hrirs, 1)
        hrir = squeeze(hrirs(i,:,:));
        smoothed(i,:,:) = smooth(hrir')';
    end
end