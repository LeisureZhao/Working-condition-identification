%% load data
clear ; close all; clc
addpath(genpath('.'))
name = '.\LDS_Model\furnace\_n=20_nv=1_724.mat';
load(name);

%% calculating distance Matrix
iscluster = true;%如果想观察聚类后的视频的距离矩阵，设置为true
if iscluster
    name2 = '.\cluster_result\data25X3_martin.mat';
    load(name2);
    X_select = data(:,1);
else
    X_select = 1:724
end

sysParam = cell(1, length(X_select));
for i=1:length(X_select)
    sysParam{i} = imgpara{X_select(i)};
end

dist = calculateMetricLDS(sysParam, [2]);%martin distance

% plotDistance(dist)
% set(gca,'fontsize',15)
% xlabel('Martin Kernel')
% xlabel('Frobenius Kernel')
% colorbar
 save('.\distMatrix\_n=20_nv=1_martin_gram.mat','dist','data','num')

