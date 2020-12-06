function smoothed = smooth_hrirs(hrirs)
    smoothed = zeros(size(hrirs));
    size(smoothed)
    for i = size(hrirs, 1)
        hrir = squeeze(hrirs(i,:,:));
        hrir_spectrum = fft(hrir);
        hrir_spectrum_smooth = smoothdata(hrir_spectrum, 1);
        hrir_smooth = ifft(hrir_spectrum_smooth);
        plot(imag(hrir_smooth));
        figure;
        imagesc(hrir_smooth .^ 2);
        figure;
        imagesc(hrir .^ 2);
        smoothed(i,:,:) = hrir_smooth;
    end
end