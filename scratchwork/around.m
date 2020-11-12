[fs, hrirs] = load_hrir("data/notched-headband.h5");
stretch = 10;
compensate = 10;
pulse = Pulse(2e4, 5e4, 5e-3, 'logarithmic');

for i = -90:10:90
    make_stim(hrirs, fs, pulse, i, stretch, compensate);
    pause(1);
end