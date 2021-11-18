clc 
clear
close all
tic
video1 = VideoReader('C:\Users\ASUS_X550\Desktop\Видео\20200318_154538.MP4');
k=video1.Duration*video1.FrameRate;
%k=1*30*60*21;
%k=31;
w=2850;
R=1+w*30-1253*30;
f2=0;
while R<=k
    frame = video1.read(R);
    frame=rgb2gray(frame);
    %frame=frame(75:400,10:400);
    %frame=im2bw(frame,0.4);
%     se=strel('disk',1);
%     frame=imdilate(frame,se);
    points1 = detectSURFFeatures(frame);
    [f1,vpts1] = extractFeatures(frame,points1);
    if R~=1+w*30-1253*30;
        points2 = detectSURFFeatures(frame4);
        [f2,vpts2] = extractFeatures(frame4,points2);
        [indexPairs,vector] = matchFeatures(f1,f2,'Method','Exhaustive','MatchThreshold', 1) ;
        matchedPoints1 = vpts1(indexPairs(:,1));
        matchedPoints2 = vpts2(indexPairs(:,2));
         figure; showMatchedFeatures(frame,frame4,matchedPoints1,matchedPoints2);
        [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPoints1,matchedPoints2,'projective');
        %figure; showMatchedFeatures(frame4,frame,inlierPtsOriginal,inlierPtsDistorted);
        outputView = imref2d(size(frame));
        frame4= imwarp(frame,tform,'OutputView',outputView);
        %points3 = detectSURFFeatures(frame3,'MetricThreshold' ,1500);
%         [f3,vpts3] = extractFeatures(frame3,points3);
%         points2 = detectSURFFeatures(frame4,'MetricThreshold' ,1500);
%         [f2,vpts2] = extractFeatures(frame4,points2);
%         [indexPairs,vector1] = matchFeatures(f3,f2,'Method','Approximate','MatchThreshold' ,10) ;
%         matchedPoints3 = vpts3(indexPairs(:,1));
%         matchedPoints2 = vpts2(indexPairs(:,2));
%         [tform,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(matchedPoints3,matchedPoints2,'projective');
%        % figure; showMatchedFeatures(frame4,frame3,inlierPtsOriginal1,inlierPtsDistorted1);
%         outputView = imref2d(size(frame3));
%         frame4= imwarp(frame3,tform,'OutputView',outputView);
    else
%         frame = video1.read(R);
%         frame=imrotate(frame, -90,'bilinear');
%         frame=rgb2gray(frame);
        frame4=frame;
    end
    
    %%%%%%%%%
     frame1=frame4(254:320,335:353);
     frame1=imrotate(frame1, -94.5,'bilinear');
     frame1=imresize(frame1,2);
     frame1= medfilt2(frame1);
%      frame1=frame1*1.2;
%       frame1=im2bw(frame1,0.8);
%       se=strel('disk',1);
%       frame1=imdilate(frame1,se);
     results1 = ocr(frame1,'TextLayout','block','CharacterSet','+-.0123456789');
     F{w,1}=R;
    A=results1.Words;
    A=cell2mat(A');
    F{w,2}=A;
    
   %figure; imshow(frame1)
   frame2=frame4( 177:256,223:250);
   frame2=imrotate(frame2, -94.5,'bilinear');
  % figure; imshow(frame2)
%     B=cell(0);
%     frame3= im2bw(frame2,0.2);
%     se2=strel('disk',2);
%     frame3=imdilate(frame3,se2);
%     pl=frame3(25,5);                  
%     if pl==1
%         B{1}='+';
%     else
%         B{1}='-';
%     end
%     q=2;
%     N=0;
%     while q<=3;
%         z1=frame3(20,65+N);
%         z2=frame3(45,65+N);
%         z4=frame3(45,43+N);
%         z5=frame3(20,43+N);
%         z6=frame3(9,55+N);
%         z7=frame3(34,55+N);
%         ch=opre(z1,z2,z4,z5,z6,z7);
%          ch=num2str(ch);
%         B{q}=ch;
%         q=q+1;
%         N=N+40;
%     end
%     tochka='.';
%     B{4}=tochka;
%     N=0;
%     q=5;
%      while q<=7;
%         z1=frame3(20,150+N);
%         z2=frame3(45,150+N);
%         z4=frame3(45,128+N);
%         z5=frame3(20,128+N);
%         z6=frame3(9,140+N);
%         z7=frame3(34,140+N);
%         ch=opre(z1,z2,z4,z5,z6,z7);
%         ch=num2str(ch);
%         B{q}=ch;
%         q=q+1;
%         N=N+43;
%      end
%      B=cell2mat(B);
%      F{w,3}=B;
R=R+30*1;
    frame9=imrotate(frame4, -90);
    imshow(frame9);
    disp(w)
    w=w+1;
    pause
end


%{
while R<=k;
    frame = video1.read(R);% кадры
    frame=imrotate(frame, 1,'bilinear');
    frame=rgb2gray(frame);
    frame1=frame(512:565, 280:527);
    frame1=im2bw(frame1,0.45);
    se1=strel('disk',2);
    frame1=imdilate(frame1,se1);
    results1 = ocr(frame1,'TextLayout','block','CharacterSet','+-.0123456789');
    F{w,1}=R;
    A=results1.Words;
    A=cell2mat(A');
    F{w,2}=A;
    %%%%%%%%%%%%%%%%%%%%%%%
    frame2=frame(115:180, 590:830);
    B=cell(0);
    frame3= im2bw(frame2,0.2);
    se2=strel('disk',2);
    frame3=imdilate(frame3,se2);
    pl=frame3(25,5);
    if pl==1
        B{1}='+';
    else
        B{1}='-';
    end
    q=2;
    N=0;
    while q<=3;
        z1=frame3(20,65+N);
        z2=frame3(45,65+N);
        z4=frame3(45,43+N);
        z5=frame3(20,43+N);
        z6=frame3(9,55+N);
        z7=frame3(34,55+N);
        ch=opre(z1,z2,z4,z5,z6,z7);
         ch=num2str(ch);
        B{q}=ch;
        q=q+1;
        N=N+40;
    end
    tochka='.';
    B{4}=tochka;
    N=0;
    q=5;
     while q<=7;
        z1=frame3(20,150+N);
        z2=frame3(45,150+N);
        z4=frame3(45,128+N);
        z5=frame3(20,128+N);
        z6=frame3(9,140+N);
        z7=frame3(34,140+N);
        ch=opre(z1,z2,z4,z5,z6,z7);
        ch=num2str(ch);
        B{q}=ch;
        q=q+1;
        N=N+43;
     end
     B=cell2mat(B);
     F{w,3}=B;
      R=R+25;
      w=w+1;
end
%}
toc
%imshow(frame);
%disp(results1.Text)
% Iname = insertShape(frame, 'Rectangle', wordBBox, 'Color', 'red');
% imshow(Iname);
