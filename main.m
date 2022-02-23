%% Clear

clear
close all
clc

%% Launch Vehicles

% % Vulcan Centaur (6 SRBs)
% launch_vehicle.name = "Vulcan Centaur";
% launch_vehicle.C3 = 0:10:100; % [km^2/s^2]
% launch_vehicle.mass = [10850, 9130, 7630, 6310, 5150, 4120, 3250, 2420, 1780, 1370, 755]; % [kg]

% Falcon Heavy (Recovery)
launch_vehicle.name = "Falcon Heavy (Recovery)";
launch_vehicle.C3 = 0:10:70; % [km^2/s^2]
launch_vehicle.mass = [6690, 4930, 3845, 2740, 1805, 1005, 320, 0]; % [kg]

% % Falcon Heavy (Expendable)
% launch_vehicle.name = "Falcon Heavy (Expendable)";
% launch_vehicle.C3 = 0:10:100; % [km^2/s^2]
% launch_vehicle.mass = [15010, 12345, 10115, 8225, 6640, 5280, 4100, 3080, 2195, 1425, 770]; % [kg]
% 
% % NASA SLS
% launch_vehicle.name = "NASA SLS";
% launch_vehicle.C3 = 0:10:100; % [km^2/s^2]
% launch_vehicle.mass = [26910, 22085, 18266, 15201, 12739, 10628, 8920, 7513, 6307, 5201, 4296]; % [kg]
% 
% % New Glenn
% launch_vehicle.name = "New Glenn";
% launch_vehicle.C3 = 0:10:40; % [km^2/s^2]
% launch_vehicle.mass = [7180, 5130, 2365, 120, 0]; % [kg]

%% Payload Options

% All instraments
payload.name = "All";
payload.sensors = ["COR" "TSI" "EUVI" "DSI" "UVS" "MAG" "SW" "EPP" "RPW"];
payload.mass = [10, 7, 10, 25, 15, 1.5, 10, 9, 10]; % [kg]
payload.power = [15, 14, 12, 37, 22, 2.5, 15, 9, 15]; % [W]
payload.cost = [19.3, 13.7, 17.6, 41.5, 26.9, 6.8, 24.3, 17.9, 24.3]*1e6; % [USD]

%% Propulsion Options

% Solar Sail
propulsion.name = "Solar Sail";
propulsion.beta = 0.1; % [-] lightness factor

% % Ion Engine
% propulsion.name = "Ion";
% propulsion.Isp = 4190; % [s] specific impulse (Dawn Ion Engine)
% 
% % Chemical Engine (storable)
% propulsion.name = "Chemical";
% propulsion.Isp = 317; % [s] specific impulse (Juno Main Engine)

%% Final Orbit Options

% POLARIS Final Orbit
orbit.perihelion = 0.48*1.496e+8; % [km]
orbit.inclination = deg2rad(90); % [rad]

%% Planetary Flyby Options

% % None
% flybys.name = "None";
% 
% Mercury
% flybys.name = "Single Mercury";
% flybys.planet = "Mercury";
% flybys.encounters = 1;
% flybys.radius = 2439.7; % [km] planetary radius
% flybys.mu = 22032.0805; % [km^3/2^2] standard gravitational parameter
% flybys.a = 57909101; % [km] heliocentric semimajor axis
% flybys.T = 7600537; % [s] heliocentric orbital period
% flybys.dV = 7.5; % [km/s] Hohmann dV from Earth
% flybys.tof = 106.75; % [days] Hohmann time of flight from Earth

% Venus
flybys.name = "Single Venus";
flybys.planet = "Venus";
flybys.encounters = 1;
flybys.radius = 6051.9; % [km] planetary radius
flybys.mu = 324858.59883; % [km^3/2^2] standard gravitational parameter
flybys.a = 108207284; % [km] heliocentric semimajor axis
flybys.T = 19413722; % [s] heliocentric orbital period
flybys.dV = 2.5; % [km/s] Hohmann dV from Earth
flybys.tof = 120; % [days] Hohmann time of flight from Earth

% % Where's Earth???
% 
% % Mars
% flybys.name = "Single Mars";
% flybys.planet = "Mars";
% flybys.encounters = 1;
% flybys.radius = 3397; % [km] planetary radius
% flybys.mu = 42828.3143; % [km^3/2^2] standard gravitational parameter
% flybys.a = 227944135; % [km] heliocentric semimajor axis
% flybys.T = 59356281; % [s] heliocentric orbital period
% flybys.dV = 2.9; % [km/s] Hohmann dV from Earth
% flybys.tof = 259.25; % [days] Hohmann time of flight from Earth
% 
% Jupiter
% flybys.name = "Single Jupiter";
% flybys.planet = "Jupiter";
% flybys.encounters = 1;
% flybys.radius = 71492; % [km] planetary radius
% flybys.mu = 126712767.858; % [km^3/2^2] standard gravitational parameter
% flybys.a = 778279959; % [km] heliocentric semimajor axis
% flybys.T = 374479305; % [s] heliocentric orbital period
% flybys.dV = 8.8; % [km/s] Hohmann dV from Earth
% flybys.tof = 730; % [days] Hohmann time of flight from Earth

%% Initial Mass Estimates

mass.prev.bus = sum(payload.mass); % [kg] everything minus propulsion
mass.prev.total = 2*sum(payload.mass); % [kg] everything

%% Sizing

sizing(launch_vehicle,payload,propulsion,orbit,flybys,mass);
