function [left_heading, right_heading] = get_receiver_headings(heading_deg, separation)
    receiver_heading_offset = 180 / pi * asin(1 / separation);
    left_heading = normalize_heading(90 + round(heading_deg - receiver_heading_offset));
    right_heading =  normalize_heading(90 + round(heading_deg + receiver_heading_offset));
end