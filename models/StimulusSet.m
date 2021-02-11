classdef StimulusSet
    properties
        fs = 44100
        azimuths_deg = -90:5:90
        slowdowns = [12, 16, 20]
        compensations = {1, 2, 'half', 'full'}
        pulse_length_s = 0.01
        audible_chirp_frequency_band_hz = [1500, 2900]
        chirp_kind = "quadratic"
        target_distances_cm = [300]
    end
end
