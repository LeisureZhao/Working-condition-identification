%% init
clear; close all; clc;
addpath(genpath('.'));

name = '_n=20_nv=1_martin_gram.mat';
load(name);
X=data(:,1);
[a,b,c] = deal(X(1),X(num+1),X(num*2+1));

name = '_n=20_nv=1_724_martin.mat';
load(name);
label = zeros(724,1);
[label(a),label(b),label(c)] = deal(0,1,2);
for i=1:724
    if i==a || i==b ||i==c
        continue;
    else
       if min([dist(a,i),dist(b,i),dist(c,i)]) == dist(a,i)
           label(i) = 0;
       elseif min([dist(a,i),dist(b,i),dist(c,i)]) == dist(b,i)
           label(i) = 1;
       else
           label(i) = 2;
       end
    end
end