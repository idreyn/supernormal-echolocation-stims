function best_idx = get_ild_max_orientation_for_compensation(hrirs, compensation, show_plot)
    num_orientations = size(hrirs, 1);
    best_idx = 0;
    best_ild = -Inf;
    for idx = 1:num_orientations
        ild = get_ild_for_compensation_and_orientation(hrirs, compensation, idx);
        ild_integrated = sum(ild);
        if ild_integrated > best_ild
            best_ild = ild_integrated;
            best_idx = idx;
        end
    end
    best_ild = get_ild_for_compensation_and_orientation(hrirs, compensation, best_idx);
    if show_plot
        hold on
        xlabel('Azimuth (degrees)');
        ylabel('ILD (dB)');
        plot(best_ild)
        hold off
    end
end