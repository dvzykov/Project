clc
clear
tic
video1 = VideoReader('23.03(12% 150 II) T &L(new)\225XDPHH - Distance\S2250003.MP4');
%k=video1.Duration*video1.FrameRate;
k=151;
R=1;
w=1;
F{1,4}=video1.Name;
while R<=k;
    frame = video1.read(R);% кадры
    frame=imrotate(frame, 0,'bilinear');
    frame=rgb2gray(frame);
    frame1=frame(582:664, 118:486);
    frame11=frame1(:,46:168);
    frame11=im2bw(frame11,0.3);
    se1=strel('disk',3);
    frame11=imdilate(frame1,se1);
    results11 = ocr(frame11,'TextLayout','block','CharacterSet','.0123456789');
    frame12=frame1(:,46:168);
    frame12=im2bw(frame11,0.3);
    se1=strel('disk',3);
    frame11=imdilate(frame1,se1);
    results11 = ocr(frame11,'TextLayout','block','CharacterSet','.0123456789');
    %     frame1=im2bw(frame1,0.4);
%     se1=strel('disk',3);
%     frame1=imdilate(frame1,se1);
%     frame11=frame1(:, 45:369);
%     results1 = ocr(frame11,'TextLayout','block','CharacterSet','.0123456789');
    pl2=frame1(25,25);
    A=cell(0);
    if pl2==1
        A{1}='+';
    else
        A{1}='-';
    end
    F{w,1}=R;
    A{2}=results1.Words;
    D=A{2};
    D=cell2mat(D');
    A{2}=D;
    A=cell2mat(A);
    F{w,2}=A;
    %%%%%%%%%%%%%%%%%%%%%%%
    frame2=frame(20:113, 578:938);
    B=cell(0);  
    frame3= im2bw(frame2,0.25);
    se2=strel('disk',3);
    frame3=imdilate(frame3,se2);
    pl=frame3(38,22);
    if pl==1
        B{1}='+';
    else
        B{1}='-';
    end
    q=2;
    N=0;
    while q<=3;
        z1=frame3(33,106+N);%%%%         6         %%%
        z2=frame3(64,103+N);%           5            1%%%
        z4=frame3(64,74+N);%%%%         7
        z5=frame3(33,78+N);%           4            2
        z6=frame3(16,94+N);%                   3
        z7=frame3(49,91+N);%%%%%%%%%%%%
        ch=opre(z1,z2,z4,z5,z6,z7);
        ch=num2str(ch);
        B{q}=ch;
        q=q+1;
        N=N+58;
    end
    tochka='.';
    B{4}=tochka;
    N=0;
    q=5;
    while q<=7;
        z1=frame3(32,224+N);
        z2=frame3(63,220+N);
        z4=frame3(63,190+N);
        z5=frame3(32,194+N);
        z6=frame3(17,209+N);
        z7=frame3(51,207+N);
        ch=opre(z1,z2,z4,z5,z6,z7);
        ch=num2str(ch);
        B{q}=ch;
        q=q+1;
        N=N+57;
    end
    B=cell2mat(B);
    F{w,3}=B;
    R=R+25;
    w=w+1;
end
toc
imshow(frame);
%disp(results1.Text)
% Iname = insertShape(frame, 'Rectangle', wordBBox, 'Color', 'red');
% imshow(Iname);
