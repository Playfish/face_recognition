
%成功——  人脸识别

clear all;
clc;
allsamples=[];no_face=[];%所有训练图像
for i=1:40
    for j=1:5
      a=imread(strcat('ORL\s',num2str(i),'\',num2str(j),'.pgm'));
      %imshow(a);
     % b=a(1:112*92); % b是行矢量 1×N，其中N＝10304，提取顺序是先列后行，即从上到下，从左到右
      a=imresize(a,0.3);
      b=a(1:34*28);
     b=double(b);
      allsamples=[allsamples; b];  % allsamples 是一个M * N 矩阵，allsamples 中每一行数据代表一张图片，其中M＝200
    end
end
  allsamples=allsamples';


[  x_1, eignface_space,eignface] = pca_face( allsamples );

%识别阶段
for i=3
    for j=6
      c=imread(strcat('ORL\s',num2str(i),'\',num2str(j),'.pgm'));
      test=imread(strcat('ORL\s',num2str(i),'\',num2str(j),'.pgm'));
      %imshow(a);
     % b=a(1:112*92); % b是行矢量 1×N，其中N＝10304，提取顺序是先列后行，即从上到下，从左到右
      c=imresize(c,0.3);
      d=c(1:34*28);
     d=double(d);
      no_face=[no_face; d];
      no_face = no_face';% allsamples 是一个M * N 矩阵，allsamples 中每一行数据代表一张图片，其中M＝200
  end
end
mea_c=(no_face-x_1);
oumu = eignface_space'*mea_c;%待识别脸特征  55x1

%待识别脸与特征脸做欧氏距离，谁小便是哪张脸
%欧式（oumu-eignface）(55x1-55x80)
alloushi=[];
oushi_sum=0;
[row,vir]=size(eignface); %[row,vir] row行  vir列
for i=1:vir
    for j=1:row
    oushi=(oumu(j,:)-eignface(j,i))^2;%欧式距离
    oushi_sum=oushi_sum+oushi;
    end
    oushi_sum=sqrt(oushi_sum);
    alloushi=[alloushi oushi_sum];
    oushi_sum=0;
end
[minx,index_oushi]=min(alloushi);

%显示图片
group=index_oushi/5;
group=ceil(group);
dataface=imread(strcat('ORL\s',num2str(group),'\',num2str(1),'.pgm'));
subplot(211),imshow(dataface),title('数据库脸')

hold on;
subplot(212),imshow(test),title('测试脸')

