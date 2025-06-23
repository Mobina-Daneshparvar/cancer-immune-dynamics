
function V = simulate_logistic_fit(x, xdata)
% SIMULATE_LOGISTIC_FIT - Simulates the logistic model and returns interpolated values.
%
% Inputs:
%   x      - value of growth rate parameter 'a2' to evaluate
%   xdata  - time points where model output is needed
%
% Output:
%   V - model-predicted cancer cell counts divided by C_max at xdata time points

global a;
a = x;
global y;

initial_condition = 0.129e8;    % Initial cancer cell count/C_max

% Solve ODE over the experiment time window
z = ode45(@logistic_growth_model, [0 4], initial_condition);

% Interpolate solution at measured time points
V = interp1(z.x, z.y, xdata);
end

