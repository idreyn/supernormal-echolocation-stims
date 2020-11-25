function smoothed = smooth_hrirs(hrirs)
    smoothed = zeros(size(hrirs));
    size(smoothed)
    for i = size(hrirs, 1)
        hrir = squeeze(hrirs(i,:,:));
        smoothed(i,:,:) = smoothdata(hrir);
    end
end