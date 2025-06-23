
function dp = logistic_growth_model(t, p)

% LOGISTIC_GROWTH_MODEL - Defines logistic growth dynamics for non-resistant cancer cells (C^- and C^+).
%
% Inputs:
%   t - time 
%   p - current population of cancer cells
%
% Output:
%   dp - rate of change of the cancer cell population

dp = zeros(1,1);
global a;                   % Growth rate parameter to estimate
C_max = 1e10;               % Carrying capacity of the system (maximum cancer cell population)

% Logistic growth equation
dp(1) = a * p(1) * (1 - p(1) / C_max);
end

