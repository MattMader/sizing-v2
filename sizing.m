function sizing(launch_vehicle,payload,propulsion,orbit,flybys,mass)

% trajectory analysis
[dV, tof] = trajectory(launch_vehicle,flybys,mass);

disp(dV)
disp(tof)

end % function