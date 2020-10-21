params = Parameters(2e4, 3, 0.001);
air = Material(343, 1.225);
water = Material(14800, 1000);
medium = Medium(params, air);
head = makeDisc(params.Nx, params.Ny, params.Nx/2, params.Ny/2, 200);
