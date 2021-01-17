classdef StimulusSet
    properties
        fs = 44100
        hrir_included_distance_m = 1.4
        azimuths_deg = -90:5:90
        slowdowns = [12, 16, 20]
        % compensation_factor = slowdown / denominator, below
        % by convention, 0 is taken to mean the slowdown factor, so the
        % compensation_factor is slowdown / slowdown = 1.
        % this is represented in this annoying way to make it easier to
        % refer to stimuli, since they may have odd compensation factors
        % like 7/4 which are not easy to express in filenames.
        compensation_fractions_of_slowdown_denominator = [0, 2, 1]
        pulse_length_s = 0.01
        audible_chirp_frequency_band_hz = [1500, 2900]
        chirp_kind = "quadratic"
        target_distances_cm = [300]
    end
end
