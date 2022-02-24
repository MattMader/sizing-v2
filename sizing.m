function tof = sizing(launch_vehicle,payload,propulsion,orbit,flybys,mass)

% trajectory analysis
[dV, tof] = trajectory(launch_vehicle,flybys,propulsion,orbit,mass)



end % function