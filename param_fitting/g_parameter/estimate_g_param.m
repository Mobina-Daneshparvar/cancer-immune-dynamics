
% ESTIMATE_MDSC_PARAM - Main script to estimate model parameter 'g' using experimental data.
clc

% Experimental time points (day)
t = [0, 0.125];

% Experimental data (MDSC count/Initial number of MDSCs)
global y
y = [1, 0.347];  

% Initial guess for parameter g
g0 = [10.48];

% Make g available to other functions
global g

% Estimate the parameter using nonlinear least squares curve fitting
[X, RESNORM] = lsqcurvefit(@fit_model_to_data, g0, t, y);

% Display the estimated parameter and residual norm
disp(['Estimated k: ', num2str(X)]);
disp(['Residual norm: ', num2str(RESNORM)]);
