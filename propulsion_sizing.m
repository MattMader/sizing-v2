function [P_prop, m_propsys, cost] = propulsion_sizing(dV, propulsion, mass)

% constants
mu = 132712440018; % [km^3/s^2] % solar standard gravitational parameter
g0 = 9.81; % [m/s^2] standard gravity
AU = 1.496e+8; % [km] % AU in km

% solar sail case
if propulsion.name == "Solar Sail"
    
    % lightness factor (design input)
    beta = propulsion.beta; % [-]
    
    % payload mass (everything minus the solar sail)
    m_payload = mass.prev.bus; % [kg]
    
    % sail material area density (estimate from ACS3)
    rho_material = 0.0133; % [kg/m^2]
    
    % spar material linear density (estimate from ACS3)
    lambda_spars = 0.1286; % [kg/m]

    % local solar gravity at 1 AU
    a_g = mu/AU^2*1000; % [m/s^2]

    % solar pressure at 1 AU
    P = 9.08e-06; % [N/m^2]

    % lmao this is a monster of an equation...
    S_sail = (a_g^2*beta^2*m_payload^2)/((a_g*beta*(2*a_g*beta*lambda_spars^2 ...
        + 2*P*m_payload - a_g*m_payload*rho_material*beta))^(1/2) ...
        - 2^(1/2)*a_g*beta*lambda_spars)^2; % [m^2]

    % effective density of sail (includes spars)
    rho_sail = rho_material + 2*lambda_spars*sqrt(2/S_sail); % [kg/m^2]

    % mass of sail
    m_propsys = S_sail*rho_sail; % [kg]

    %%%%%% Need help! %%%%%%
    cost = 0; % [USD]

% ion engine case
elseif propulsion.name == "Ion"

    % spacecraft mass (everything except launch vehicle)
    m_spacecraft = mass.prev.total; % [kg]

    % payload mass (spacecraft mass minus propulsion and propellant)
    m_payload = mass.prev.bus; % [kg]

    % required nominal acceleration (design input)
    accel = propulsion.accel; % [m/s^2]

    % required thrust estimate
    F_total = m_spacecraft*accel; % [N]

    % thrust per NEXT ion engine (DOI 10.2514/6.2007-5199)
    F_engine = 0.236; % [N/engine]

    % power per NEXT ion engine (DOI 10.2514/6.2007-5199)
    P_engine = 6900; % [W/engine]

    % maximum Isp for NEXT ion engine (DOI 10.2514/6.2007-5199)
    Isp = 4100; % [s]

    % mass per NEXT ion engine (DOI 10.2514/6.2007-5199)
    m_engine = 58.2; % [kg/engine]

    % number of engines required
    N_engines = ceil(F_total/F_engine); % [engines]

    % total inert propulsion mass
    m_inert = m_engine*N_engines; % [kg]

    % total propulsion power
    P_prop = P_engine*N_engines; % [W]

    % propellant mass
    m_prop = exp(dV/g0/Isp)*(m_payload + m_inert)-m_payload-m_inert; % [kg]

    % propulsion system mass
    m_propsys = m_prop + m_inert; % [kg]

    %%%%% Need Help! %%%%%

    % cost per engine (source?)
    cost_engine = 15000000; % [USD/engine]

    % cost of xenon
    cost_xenon = 850; % [USD/kg]

    % cost of ion system
    cost = cost_engine*N_engines + m_prop*cost_xenon; % [USD]

else

    error("Unsupported Propulsion type!")

end % if/elseif


end % function