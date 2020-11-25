function [left_index, right_index] = get_orientation_indices(hrirs, index)
    num_orientations = size(hrirs, 1);
    right_index = index;
    left_index = num_orientations - index + 1;
end