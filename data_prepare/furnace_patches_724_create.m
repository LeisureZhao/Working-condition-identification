clear ; close all; clc

%% create furnace_patches_724 
video_num = 724;
imgdb = cell(1,video_num);
addpath(genpath('.'));
for j = 1:video_num
    dir = '.\video_segment\00283\';
    v = VideoReader([dir,num2str(j),'_00283.mp4']);
    len = v.FrameRate*v.Duration;
    pictu_matri = zeros(floor(v.Height/4),floor(v.Width/4),len,'uint8');
    for k = 1:len
        pictu_matri(:,:,k) = imresize(rgb2gray(read(v,k)),[floor(v.Height/4),floor(v.Width/4)]);
    end
    imgdb{j} = pictu_matri;
end
save('.\furnace_patches_724.mat','imgdb');
