function dist = calculateMetricLDS(system,metricList)
% This is the main distance computing function. Use either default metric
% parmeters or provide custom parameters in metricParam
%
% INPUTS
%   system     -    Cell array of system parameters
%   metricList -    Array of metrics to be returned. Choose from the list:
%       Distances:
%
%           Subspace angles based distances
%       1 - Finsler
%       2 - Matrin
%       3 - Gap
%       4 - Frobenius
% OUTPUTS
%   dist    -       [N x N] all-pair distance matrix
%
% EXAMPLE
%   D = calculateMetricLDS(sysParam,[1 2 3 4 5 20]);
%

N = length(system);
n = size(system{1}.A,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating Subspace Angle 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
angles = zeros(size(system{1}.A,1),N,N);
for i = 1:N
    testSys = system{i};
    for j = 1:i % Can be replaced with parfor
        angles(:,i,j) = subspaceAnglesAR(testSys, system{j});
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating Distances
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = zeros(N,N,length(metricList));

for metricIndex=1:length(metricList) % Can be replaced with parfor
    switch metricList(metricIndex)
        case 1
            %%% Finsler Distance
            dist(:,:,metricIndex) = calculateFinslerDistance(angles);

        case 2
            %%% Matrin Distance
            dist(:,:,metricIndex) = calculateMartinDistance(angles);

        case 3
            %%% Gap Distance
            dist(:,:,metricIndex) = calculateGapDistance(angles);

        case 4
            %%% Frobenius Distance
            dist(:,:,metricIndex) = calculateFrobeniusDistance(angles);
    end
end
