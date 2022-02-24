%% Clear

clear
clc

%% Base design

% Falcon Heavy (Expendable)
launch_vehicle.name = "Falcon Heavy (Expendable)";
launch_vehicle.C3 = 0:10:100; % [km^2/s^2]
launch_vehicle.mass = [15010, 12345, 10115, 8225, 6640, 5280, 4100, 3080, 2195, 1425, 770]; % [kg]


% All instraments
payload.name = "All";
payload.sensors = ["COR" "TSI" "EUVI" "DSI" "UVS" "MAG" "SW" "EPP" "RPW"];
payload.mass = [10, 7, 10, 25, 15, 1.5, 10, 9, 10]; % [kg]
payload.power = [15, 14, 12, 37, 22, 2.5, 15, 9, 15]; % [W]
payload.cost = [19.3, 13.7, 17.6, 41.5, 26.9, 6.8, 24.3, 17.9, 24.3]*1e6; % [USD]


% NEXT Ion Engine (DOI 10.2514/6.2007-5199)
propulsion.name = "NEXT Ion Engines";
propulsion.type = "Ion";
propulsion.accel = 1e-04; % [km/s^2] nominal acceleration required     currently arbituary ~100mm/s^2
propulsion.thrust = 0.236; % [N/engine] thrust per engine
propulsion.power = 6900; % [W/engine] power per engine
propulsion.Isp = 4100; % [s] specific impulse per engine
propulsion.mass = 58.2; % [kg/engine] mass per engine
propulsion.cost = 15000000; % [USD/engine] cost per engine        source on this?


% POLARIS Final Orbit
orbit.perihelion = 0.48*1.496e+8; % [km]
orbit.inclination = 90; % [rad]


% Venus flyby
flybys.name = "Single Venus";
flybys.planet = "Venus";
flybys.encounters = 1;
flybys.radius = 6051.9; % [km] planetary radius
flybys.mu = 324858.59883; % [km^3/2^2] standard gravitational parameter
flybys.a = 108207284; % [km] heliocentric semimajor axis
flybys.T = 19413722; % [s] heliocentric orbital period
flybys.dV = 2.5; % [km/s] Hohmann dV from Earth
flybys.tof = 120; % [days] Hohmann time of flight from Earth

% initial mass estimation
mass0.payload = sum(payload.mass); % [kg] everything minus propulsion
mass0.total = 2*sum(payload.mass); % [kg] everything

%% 

[tof,mass,cost] = sizing(launch_vehicle,payload,propulsion,orbit,flybys,mass0);