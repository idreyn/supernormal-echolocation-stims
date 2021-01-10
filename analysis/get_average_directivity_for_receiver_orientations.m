function averages = get_average_directivity_for_receiver_orientations(hrirs)
    headings = -90:1:90;
    num_orientations = size(hrirs,1);
    averages = zeros(num_orientations, 1);
    for i = 1:num_orientations
        hrir = squeeze(hrirs(i,:,:));
        all_energies = sum(hrir' .^ 2);
        front_energies = all_energies(1:181);
        averages(i) = dot(headings, front_energies) / size(headings,2);
    end
end