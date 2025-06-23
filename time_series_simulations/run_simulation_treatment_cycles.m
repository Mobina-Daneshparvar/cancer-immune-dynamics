
% ----------------------------------------------------------
% Description:
%   Simulates tumor elimination under cyclic treatment (Figure 4 C of the article):
%   - 2 days MTX+RGX 
%   - 20 days RGX only 
%   - Treatment initiates after 18 days of tumor growth
%   - Repeats for 5 cycles
%   - Followed by 150 days without any treatment
% ----------------------------------------------------------

clc;

% --- Initial conditions ---
y0 = [10, 10, 320000, 0, 0, 0.12, 0.22];   % [C−, C+, I, M, Cp+, q, alpha_m]

% --- Pre-treatment simulation (e.g. growth until day 18) ---
[t, y] = ode45(@simple9, [0 18], y0);

% --- Treatment cycle parameters ---
delta_chemrgx = 2;     % Days of MTX+RGX exposure period in a cycle
delta_rgx = 20;        % Days of RGX-only exposure period in a cycle
x_axes = [0; t];       % Initialize time axis for plotting
k = y;                 % Store simulation results

% --- Apply 5 therapeutic cycles ---
for i = 1:5
    [r, w] = ode45(@MTX_RGX9, [0 delta_chemrgx], y(end,:));  % MTX+RGX
    [x, y] = ode45(@RGX9, [0 delta_rgx], w(end,:));          % RGX-only

     % Accumulate results and time
    k = [k; w; y];
    x_axes = [x_axes; x_axes(end)+r; x_axes(end)+x+delta_chemrgx];
end

% --- Post-treatment phase (150 days, no drugs) to confirm final tumor fate---
[l, m] = ode45(@simple9, [0 150], k(end,:));
k = [k; m];
x_axes = [x_axes; x_axes(end)+l];

% --- Thresholding cancer cells when tumor is eliminated (<10 cells) ---
k_8 = k(:,1) + k(:,2) + k(:,5);     % Total cancer cells
k = [k, k_8];                       % Append sum as 8th column
below_thresh = k(:,8) < 10;
k(below_thresh, [1,2,5,8]) = 0;

% Force zero from first time cancer disappears onward
zeroIndices = find(k(:,1)==0 & k(:,2)==0 & k(:,5)==0 & k(:,8)==0);
for o = 1:length(zeroIndices)
    k(zeroIndices(o):end, [1,2,5,8]) = 0;
end
x_axes = x_axes(2:end);

% --- Plotting ---
figure;
plot(x_axes, k(:,1), 'DisplayName','C^{-}','LineWidth',1.5,'Color',[0 0.4470 0.7410]);
hold on;
xlabel('Time (day)');
ylabel('Cell Count');
title('Dynamics of Cell Populations');
xlim([0, 54]);

plot(x_axes, k(:,2), 'DisplayName','C^{+}','LineWidth',1.5);
plot(x_axes, k(:,3), 'DisplayName','I','LineWidth',1.5);
plot(x_axes, k(:,5), 'DisplayName','C_{p}^{+}','LineWidth',1.5);
plot(x_axes, k(:,4), 'DisplayName','M','LineWidth',1.5);
legend;
hold off;
