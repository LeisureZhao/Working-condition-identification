function plotDistance(distMatrix)
% This function plots the distance matrix by removing the diagonal elemetns
%
% INPUTS
%   distMatrix - input distance matrix that needs to be plotted


for i=1:size(distMatrix,1)
    distMatrix(i,i) = nan;
end

imagesc(distMatrix);

for i=1:size(distMatrix,1)
    text(i,i,'X','Color','w');%white
end

