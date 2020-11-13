function all_hrirs = simulate_headband_for_each_receiver_orientation(experiment_params)
    arguments
        experiment_params HeadbandExperimentParameters
    end
    materials = MaterialsBank();
    num_notch_headings = size(experiment_params.receiver_orientations_deg, 2);
    notch_hrirs_ca(1:num_notch_headings) = {[]};

    i = 1;
    for heading = experiment_params.receiver_orientations_deg
        hrirs = simulate_headband_hrirs(experiment_params, materials, heading);
        notch_hrirs_ca{i} = hrirs;
        i = i + 1;
    end

    hrir_size = size(notch_hrirs_ca{1});
    all_hrirs = zeros(num_notch_headings, hrir_size(1), hrir_size(2));
    for i = 1:num_notch_headings
        all_hrirs(i, :, :) = notch_hrirs_ca{i};
    end
end
