function [tof,dV] = spiraling(propulsion,flybys,orbit,mass)
% assumptions:
% either solar sail or ion
% for solar sail use same values as POLARIS

    mu = 132712440018;  % [km^3/s^2] solar gravitational parameter

    initial_radius = flybys.a; % [km] start at flyby planet semimajor axis
    desired_radius = orbit.perihelion; % [km] end at desired perihelion
    
    if propulsion.name == "Solar Sail"
        % S_0 = affordable_budget * 0.8 / price_per_area;
        % a_c = 8.172 / (M_total * 1000) * S_0;   % M_total (kg), S_0(m^2)
        % beta = a_c / 5.93;
        dV = 0; % [km/s]
        beta = propulsion.beta; % [-] lightness factor
        alpha = atan(1/sqrt(2));
        tof = 1/3 * abs(desired_radius^1.5 - initial_radius^1.5) * sqrt( (1-beta*(cos(alpha))^3)/(beta^2*mu*(cos(alpha))^4*(sin(alpha))^2) ) / 86400; % days
            
    elseif propulsion.name == "Ion"
       dV = sqrt(mu/desired_radius) - sqrt(mu/initial_radius);
       T = 1.77 / mass.prev.total / 1000; % acceleration from ion engine, km/s^2
       tof = dV/ T / 86400;
    end

end