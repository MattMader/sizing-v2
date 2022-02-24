function [tof,cost] = sizing(launch_vehicle,payload,propulsion,orbit,flybys,mass)

% trajectory analysis
[dV, tof] = trajectory(launch_vehicle,flybys,propulsion,orbit,mass);

% propulsion sizing
[P_prop, m_propsys, cost] = propulsion_sizing(dV, propulsion, mass);

end % function