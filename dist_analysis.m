clear ; close all; clc
%% dist analysis
name = '.\distMatrix\_n=20_nv=1_724_martin.mat';
load(name);

limit_number = 25;%25£º3Àà
[dist_sort,dist_sort_index] = sort(dist,2);
result = dist_sort_index(1,1:limit_number);
for i = 2:724
    if intersect(result(:,2:limit_number),dist_sort_index(i,2:limit_number))
        continue;
    else
        result = [result;dist_sort_index(i,1:limit_number)];
    end
end
result2 = result';
num=size(result',1);
X=result2(:);
Y=[zeros(num,1);ones(num,1);ones(num,1)+1];
data=[X,Y];
save('.\cluster_result\data25X3_martin.mat','num','data')

