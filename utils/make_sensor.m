function struct = make_sensor(mask)
    arguments
        mask (:,:)
    end
    struct.mask = mask;
    struct.directivity_angle = zeros(size(mask));
    struct.directivity_angle(mask == 1) = pi;
end