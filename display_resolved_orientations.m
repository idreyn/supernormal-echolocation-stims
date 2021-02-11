% Prints a summary of receiver positions used in the experiment
load("hrirs.mat")

fs = 192000;
[kemar_fs, kemar_hrirs] = load_kemar_hrirs();
stimulus_set = StimulusSet;

get_resolved_orientations(hrirs, stimulus_set, kemar_fs, kemar_hrirs)