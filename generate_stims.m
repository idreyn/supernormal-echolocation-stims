% Generates the stimuli presented to participants in the experiment
load("hrirs.mat")

fs = 192000;
[kemar_fs, kemar_hrirs] = load_kemar_hrirs();
stim_set = StimulusSet;
directory = "/Users/Ian/Desktop/up-stims";

make_stim_set(stim_set, fs, hrirs, kemar_fs, kemar_hrirs, directory);