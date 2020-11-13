function [left_index, right_index] = get_orientation_indices(hrirs, index)
    num_orientations = size(hrirs, 1);
    left_index = index;
    right_index = num_orientations - index + 1;
end