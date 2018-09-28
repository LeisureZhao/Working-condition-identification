% cut a 10s video from the original video
clear ; close all; clc
video_name = 'g:\炉口火焰数据库制作\MP4\效果好00283.mp4';
video_len = 5;
frameRate = 10;
v = VideoReader(video_name);
for i = 1:floor(v.Duration*v.FrameRate / (video_len*frameRate) )
    vcut_name = ['.\video_segment\00283\',num2str(i),'_00283'];
    vcut = VideoWriter(vcut_name,'MPEG-4');
    vcut.FrameRate = frameRate;
    open(vcut);
    temp = frameRate*video_len;
    for j = (i-1)*temp+1:i*temp
        I = read(v,j);
%         Img=I(200:470,350:1100,:); % （for 00279）
%         Img=I(200:470,350:1100,:); % （for 00282）
        Img=I(200:470,400:1450,:); % （for 00283） 271*1051
        writeVideo(vcut,Img);
    end
    close(vcut);
    fprintf(['the ',num2str(i),' is generated!\n']);
end
