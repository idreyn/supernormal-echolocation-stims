function receiver_heading_offset_deg = get_receiver_heading_offset_for_compensation(compensation_factor)
    receiver_heading_offset_deg = 180 / pi * asin(1 / compensation_factor);
end

