function [tof,dV] = cranking(propulsion,final_orbit, mass)
% assumptions:
% either solar sail or ion
% desired radius is the starting point
    tof = 0; % [days]
    dV = 0; % [km/s] 
    mu = 132712440018; % [km^3/s^2]

           
    if propulsion.name == "Solar Sail"
           alpha = atan(1/sqrt(2));
           di = 4 * propulsion.beta * (cos(alpha))^2 * sin(alpha) * 180 / pi; % deg/orbit
           period = 2*pi*sqrt(final_orbit.perihelion^3/mu) / 86400; % day/orbit
           tof = final_orbit.inclination / di * period;
    end

    if propulsion.name == "Ion"
       T = 1.77; % thrust in Newtons using AEPS as reference 
       period = 2*pi*sqrt(final_orbit.perihelion^3/mu); 
       delta_v = T*period/mass.prev.total/1000; % delta v from ion engine per period, km/s
       v =  sqrt(mu/final_orbit.perihelion); 
       inclin_change = 0.5*asind(delta_v / (2*v)); % assuming circular orbit, deg/orbit
       num_periods = final_orbit.inclination / inclin_change;
       tof = period * num_periods / 86400;
       dV = delta_v * num_periods;
    end
end