% First cylinder
prepobs{1}.R = 100;
prepobs{1}.c = [620; 0];
prepobs{1}.rho0 = 150;
prepobs{1}.h = 572;
prepobs{1}.type = 'cyl';

prepobs{2}.R = 100;
prepobs{2}.c = [620; -440];
prepobs{2}.rho0 = 150;
prepobs{2}.h = 572;
prepobs{2}.type = 'cyl';

prepobs{3}.c = [0; 0];
prepobs{3}.h = 0;
prepobs{3}.rho0 = 150;
prepobs{3}.type = 'xy_plane';