% Generate Video sequence from LDS Paramters
% OUTPUTS 
%   I        - Generated video sequence of size r x c x F
%   X        - Hidden states of the model: n x F, where n is the model order.

clear ; close all; clc
%% parameter settings
name = './LDS_Model/furnace/_n=20_nv=1_724.mat';
load(name);
ith = 1;
data = imgpara{ith};
[A,B,C,X0,C0] = deal(data.A,data.B,data.C,data.X0,data.C0);
[n,nv] = size(B);
F = 400; %Synthetic frame number
[r,c] = deal(68,263);

X = zeros(n,F);
I = zeros(r,c,F);

%%  Generated video sequence
for i=1:F
    if i==1
        X(:,i) = X0;%A*X0 + B*randn(nv,1);
    else
        X(:,i) = A*X(:,i-1) + B*randn(nv,1);
    end
        I(:,:,i) = reshape(C*X(:,i)+C0,[r c]);
end

%% Generate video
video_name = ['.\video_generate\','_n=',num2str(n),'_nv=',num2str(nv),'_ith=',num2str(ith),'_F=',num2str(F)];
v = VideoWriter(video_name,'MPEG-4');
v.FrameRate=10;
open(v);
for j = 1:F
    writeVideo(v,uint8(I(:,:,j)));
end
close(v);
