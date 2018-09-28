function dist = calculateGapDistance(angles)
% Compute the Gap distance between dynamical systems
%
% INPUTS
% Takes variable inputs of the type:
%   option 1 -  (angles) - all-pair subspace angles [numAngles x N xN] between
%                systems
%   option 2 -  (system1, system2) - two system parameters
%   option 3 -  (system1, system2, metricParams) - two system parameters
%                and custom values for metric properties
%
% OUTPUTS
%   dist     -  distance between two systems or all-pair Gap distance
%               matrix [N x N]
%
% EXAMPLE
%
%   sa = subspaceAnglesAR(sysParamsCellArray);
%   dist = calculateGapDistance(sa);
%
%% Written by : Avinash Ravichandran, Rizwan Chaudhry
%% $DATE      : 09-Sep-2011 17:57:43 $
%% $REVISION  : 0.5.0 $

%%% Calculating the distances from the angle
N    = size(angles,2);
dist = zeros(N,N);

if N > 1
    for i = 1:N
        for j=1:i-1
            dist(i,j) = sin(max(angles(:,i,j)));
        end
    end
    dist = dist + dist';
else
    dist = sin(max(angles));
end
