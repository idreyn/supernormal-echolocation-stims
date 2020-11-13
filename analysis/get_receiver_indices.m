function [left_index, right_index] = get_receiver_indices(heading_deg, compensation)
    receiver_heading_offset = 180 / pi * asin(1 / compensation);
    left_index = 1 + normalize_heading(90 + round(heading_deg - receiver_heading_offset));
    right_index =  1 + normalize_heading(90 + round(heading_deg + receiver_heading_offset));
end