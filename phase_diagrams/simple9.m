
% ----------------------------------------------------------
% Description:
% Simulates the time evolution of 7 variables in the absence of drug treatments.
% Including:
%     - dp(1): C− (Sca-1- cancer cells)
%     - dp(2): C+ (Sca-1+ cancer cells)
%     - dp(3): I (Immune killer cells)
%     - dp(4): M (MDSCs)
%     - dp(5): C+p (MTX resistant Sca-1+ cancer cells)
%     - dp(6): q (I cells' recruitment rate)
%     - dp(7): alpha_m (M cells' recruitment rate)
%
% Outputs:
%   dp - derivative vector for use in ode45
% ----------------------------------------------------------

function dp = simple9(t, p)
dp = zeros(7,1);

% --- Parameters ---
a1 = 0.7616;      % proliferation rate for C− and C+
a2 = 0.5826;      % proliferation rate for Cp+
C_max = 1e10;     % carrying capacity of cancer cells
b = [0.1, 0.025]; % b(1) and b(2) represent gamma and lambda rates respectively
s = 1.3e4;        % Constant Source of I Cells
epsilon = 1.4;    % Coefficent mentioned in the article
r = 10;           % Coefficent mentioned in the article
t = 2.86e-7;      % Cancer Cell Death Rate Induced by I Cells 
B = 0.35;         % Natural Death Rate of M Cells (beta)
n = 4.12e-2;      % Natural Death Rate of I Cells
k = 2.02e7;       % Steepness coefficient of the immune killer cells recruitment curve
o = 4.5e-8;       % Inactivation Rate of I Cells by M Cells (omega)

% --- Total cancer cell population ---
C_tot = p(1) + p(2) + p(5);

c_t = (p(2) + p(5)) / C_tot;  % represents i_c mentioned in the article
c_m = p(4) / C_tot;           % represents i_m mentioned in the article

% --- Equations ---
dp(1) = a1 * p(1) * (1 - C_tot/C_max) ...
      - b(2)*p(1) + b(1)*p(2) ...
      - epsilon*(c_m/(r + c_m))*c_t*p(1) ...
      - t * p(3) * p(1);                   % C−

dp(2) = a1 * p(2) * (1 - C_tot/C_max) ...
      - b(1)*p(2) + b(2)*p(1) ...
      + epsilon*(c_m/(r + c_m))*c_t*p(1) ...
      - t * p(3) * p(2);                   % C+

dp(3) = s + p(3)*p(6)*(C_tot^2 / (k + C_tot^2)) ...
      - n * p(3) ...
      - o * p(3) * p(4);                    % I

dp(4) = p(7) * C_tot - B * p(4);            % M

dp(5) = a2 * p(5) * (1 - C_tot/C_max) ...
      - t * p(3) * p(5);                   % Cp+

dp(6) = n * (0.12 - p(6));                 % q

dp(7) = B * (0.22 - p(7));                 % alpha_m

end
