function smoothed = smooth_hrirs(hrirs)
    smoothed = zeros(size(hrirs));
    for i = 1:size(hrirs, 1)
        hrir = squeeze(hrirs(i,:,:));
        hrir_spectrum = fft(hrir');
        hrir_spectrum_smooth = smoothdata(hrir_spectrum', 'sgolay', 5)';
        hrir_smooth = ifft(hrir_spectrum_smooth)';
        smoothed(i,:,:) = hrir_smooth;
    end
end