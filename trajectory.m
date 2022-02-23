function [dV_total, tof_total] = trajectory(launch_vehicle,flybys,propulsion,orbit,mass)

% running totals
dV_total = 0; % [km/s]
tof_total = 0; % [km/s]

% Launch vehicle excess Earth C3
C3 = interp1(launch_vehicle.mass,launch_vehicle.C3,mass.prev.total,'linear','extrap');

% check for Hohmann encounter
[dV, tof, Vs_1] = hohmann_encounter(flybys, C3);

if dV == -1

    dV = 0;
    [tof, Vs_1, fpa] = initial_flyby_min_TOF(C3, flybys);

end % if

% increment dV and tof
dV_total = dV_total + dV;
tof_total = tof_total + tof;

% conduct flyby
[perihelion, aphelion] = flyby(Vs_1, flybys);

% spiraling towards the sun
[tof,dV] = spiraling(propulsion,flybys,orbit,mass);

% increment dV and tof
dV_total = dV_total + dV;
tof_total = tof_total + tof;


end % function