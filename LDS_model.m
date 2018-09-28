%% init
clear; close all; clc;
addpath(genpath('.'));
data_name = '.\data_prepare\furnace_patches_724.mat'; % furnace video database

%% preparing data
load(data_name); % load data file
data = imgdb;
K = numel(data); % the number of samples

%% training LDS models
n = 20;% n represents the dimension of the state 
nv = 1;% nv represents the dimension of the driving process 
dParams.class = 2;% struct type
imgpara = cell(1,K);% storing all parameters

for kth=1:K 
    obj_k = data{kth};  % read the kth array from the data cell
    imgpara{kth} = suboptimalSystemID(obj_k,[n nv],dParams); % train a model    
end
save(['.\LDS_Model\furnace\','_n=',num2str(n),'_nv=',num2str(nv),'_724.mat'],'imgpara','-v7.3');