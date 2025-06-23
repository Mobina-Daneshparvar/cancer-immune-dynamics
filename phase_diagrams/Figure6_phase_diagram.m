
% Phase-like diagram (corresponding to Figure 6 E of the article)
% This script simulates tumor fate under various MTX and RGX-104 treatment cycles.
% The outcome is categorized as Elimination, Escape, or Dormancy based on total cancer cell count.

clc

% Define ranges for RGX-only and dual therapy exposure durations in each cycle (in days)
reststep_range = 0.165:2:81;   % Duration of RGX-only exposure
MTXstep_range = 0.165:2:81;    % Duration of combined MTX + RGX exposure

% Initialize result matrix to store final outcome category for each treatment combination
results = zeros(length(reststep_range), length(MTXstep_range));

% Loop over all treatment combinations
for i = 1:length(reststep_range)
    for j = 1:length(MTXstep_range)
        reststep = reststep_range(i);    % Current RGX-only duration
        MTXstep = MTXstep_range(j);      % Current MTX+RGX duration

        % Initial condition before any treatment begins
        y0 = [10, 10, 320000, 0, 0, 0.12, 0.22];  % [C−, C+, I, M, Cp+, q, alpha_m]
        
        % Simulate pre-treatment dynamics for 24 days
        [t, y] = ode45(@simple9, [0 24], y0);
        x_axes = [0; t];  % Initialize time axis for plotting
        k = y;            % Store simulation results

        % Apply 5 cycles of alternating treatment
        for iter = 1:5
            % MTX + RGX dual therapy
            [r, w] = ode45(@MTX_RGX9, [0 MTXstep], y(end,:));
            
            % RGX-only treatment
            [x, y] = ode45(@RGX9, [0 reststep], w(end,:));

            % Accumulate results and time
            k = [k; w; y];
            x_axes = [x_axes; x_axes(end)+r; x_axes(end)+x+MTXstep];
        end

        % Post-treatment dynamics (no drug) for 150 days to confirm final tumor fate
        [l, m] = ode45(@simple9, [0 150], k(end,:));
        x_axes = [x_axes; x_axes(end)+l];
        k = [k; m];

        % Tumor fate filtering:
        % Compute total cancer cells 
        k_8 = k(:,1) + k(:,2) + k(:,5);
        k = [k, k_8];

        % Set subpopulations to 0 if total cancer cells drop below threshold (10)
        k_8_below_ten = k(:, 8) < 10;
        k(k_8_below_ten, [1,2,5,8]) = 0;

        % Force zero from first time cancer disappears onward
        zeroIndices = find(k(:,1)==0 & k(:,2)==0 & k(:,5)==0 & k(:,8)==0);
        for o = 1:length(zeroIndices)
            k(zeroIndices(o):end, [1,2,5,8]) = 0;
        end

        % Categorize final outcome based on total cancer count
        if k(end,8) == 0
            category = 1; % Elimination
        elseif k(end,8) > 1e9
            category = 2; % Escape
        else
            category = 3; % Dormancy
        end

        % Store result
        results(i, j) = category;
    end
end

% Create phase-like diagram
figure;
imagesc(MTXstep_range, reststep_range, results);  % Plot matrix as image
set(gca, 'YDir', 'normal');                       % Flip Y-axis to standard orientation
xlabel('Days Under Combined MTX and RGX-104 Therapy per Cycle');
ylabel('Days Under RGX-104 Monotherapy per Cycle');
h = title('Tumor Fate Across Different MTX and RGX-104 Treatment Cycles');

% Adjust title position upward slightly
currentPosition = get(h, 'Position');
newPosition = currentPosition + [0, 0.4, 0];
set(h, 'Position', newPosition);

% Axis settings
xlim([0.165 80]);
ylim([0.165 80]);
xticks([0.165, 10:10:80]);
yticks([0.165, 10:10:80]);

% Add colorbar and label categories
clim([1 3]);
colorbar('Ticks', [1, 2, 3], 'TickLabels', {'Elimination', 'Escape', 'Dormancy'});
colormap([0 1 0; 1 0 0; 0 0 1]);  % Green = Elimination, Red = Escape, Blue = Dormancy

% Layout settings
axis square;
grid on;

% Save figure
savefig;
