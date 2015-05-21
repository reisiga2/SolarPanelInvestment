
function p = GBM(N, mu, sigma, p0)

% N is the time horizon. for example for 10 years you should set N = 10.
% sigam is the volatility and a good number is 0.1; 
% mu is the rate of increase or decreasein price. 0.05 is a good number. 
TS = 1; % time step. We generate for each year. if you want it for each month set this value to 1/12.
sde_obj = gbm( mu, sigma, 'Simulation', @simBySolution );
p = sde_obj.simulate(N, 'DeltaTime', TS );
p = p0*p;