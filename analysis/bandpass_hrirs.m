function res = bandpass_hrirs(hrirs, fs, passband)
    res = zeros(size(hrirs));
    for i = 1:size(hrirs, 1)
        hrir = squeeze(hrirs(i,:,:));
        bp = bandpass(hrir', passband, fs)';
        imagesc(bp)
        res(i,:,:) = bp;
    end
end