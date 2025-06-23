
% Directories for the two sets of figures
set1Dir = 'C:\Users\Mobina\Desktop\codes for graphs\new oscillation less\percentage of good result\combination\mtx'; 
% Contains .fig files for MTX monotherapy

set2Dir = 'C:\Users\Mobina\Desktop\codes for graphs\new oscillation less\percentage of good result\combination\mtxrgx';
% Contains .fig files for MTX + RGX combination therapy

% File patterns for .fig files in each set
set1Files = dir(fullfile(set1Dir, '*.fig')); % All .fig files in set 1
set2Files = dir(fullfile(set2Dir, '*.fig')); % All .fig files in set 2

% Initialize total red areas for both sets
totalRedAreaSet1 = 0;
totalPixelsSet1 = 0;

totalRedAreaSet2 = 0;
totalPixelsSet2 = 0;

% Process first set of figures
for i = 1:numel(set1Files)
    % Load figure
    figPath = fullfile(set1Dir, set1Files(i).name);
    openfig(figPath, 'invisible');
    ax = gca; % Get current axes
    data = get(ax.Children, 'CData'); % Extract the CData matrix
    close(gcf); % Close the figure
    
    % Calculate red area 
    redPixels = sum(data(:) == 2); % Count pixels with value 3 (red)
    totalRedAreaSet1 = totalRedAreaSet1 + redPixels;
    totalPixelsSet1 = totalPixelsSet1 + numel(data); % Total pixels
end

% Process second set of figures
for i = 1:numel(set2Files)
    % Load figure
    figPath = fullfile(set2Dir, set2Files(i).name);
    openfig(figPath, 'invisible');
    ax = gca; % Get current axes
    data = get(ax.Children, 'CData'); % Extract the CData matrix
    close(gcf); % Close the figure
    
    % Calculate red area 
    redPixels = sum(data(:) == 2); % Count pixels with value 3 (red)
    totalRedAreaSet2 = totalRedAreaSet2 + redPixels;
    totalPixelsSet2 = totalPixelsSet2 + numel(data); % Total pixels
end

% Calculate percentages
percentageRedSet1 = (totalRedAreaSet1 / totalPixelsSet1) * 100;
percentageRedSet2 = (totalRedAreaSet2 / totalPixelsSet2) * 100;

% Compute difference
differenceInPercentage = abs(percentageRedSet1 - percentageRedSet2);

% Display results
fprintf('Percentage of red in set 1: %.2f%%\n', percentageRedSet1);
fprintf('Percentage of red in set 2: %.2f%%\n', percentageRedSet2);
fprintf('Difference in percentage: %.2f%%\n', differenceInPercentage);
