function best_idx = get_ild_matched_orientation_for_compensation(hrirs, kemar_ild, compensation, show_plot)
    num_orientations = size(hrirs, 1);
    best_idx = 0;
    best_cost = Inf;
    for idx = 1:num_orientations
        ild = get_ild_for_compensation_and_orientation(hrirs, compensation, idx);
        cost = get_ild_matching_cost(ild, kemar_ild);
        if cost < best_cost
            best_cost = cost;
            best_idx = idx;
        end
    end
    best_ild = get_ild_for_compensation_and_orientation(hrirs, compensation, best_idx);
    if show_plot
        hold on
        xlabel('Azimuth (degrees)');
        ylabel('ILD (dB)');
        plot(kemar_ild(1:90), '--')
        plot(best_ild(1:90))
        legend('Kemar ILD', 'Synthetic ILD');
        hold off
    end
end