
% ESTIMATE_GROWTH_PARAM - Main script to estimate the growth rate parameter 'a2'
clc

% Experimental time points (days)
t = [0, 1, 2, 3, 4];

% Experimental measurements of cancer cell counts/C_max
global y;
y = [0.129e8, 0.157e8, 0.317e8, 0.624e8, 1.380e8];  

% Initial guess for parameter 'a2'
a0 = [0.1];

global a;

% Estimate parameter 'a2' by fitting the model to data
[X, RESNORM] = lsqcurvefit(@simulate_logistic_fit, a0, t, y);

% Display estimated parameter and residual norm
disp(['Estimated a: ', num2str(X)]);
disp(['Residual norm: ', num2str(RESNORM)]);

