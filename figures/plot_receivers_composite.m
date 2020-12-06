function composite = plot_receivers_composite(experiment_params, heading_deg, compensation_factor, receiver_orientation_deg)
    heading_offset = get_receiver_heading_offset_for_compensation(compensation_factor);
    left_headband = plot_rotated_single_receiver(experiment_params, heading_deg - heading_offset, -receiver_orientation_deg);
    right_headband = plot_rotated_single_receiver(experiment_params, heading_deg + heading_offset, receiver_orientation_deg);
    composite = left_headband + right_headband;
    composite(composite < 2) = 0;
    imagesc(composite);
    axis image;
end