
%�ɹ�����  ����ʶ��

clear all;
clc;
allsamples=[];no_face=[];%����ѵ��ͼ��
for i=1:40
    for j=1:5
      a=imread(strcat('ORL\s',num2str(i),'\',num2str(j),'.pgm'));
      %imshow(a);
     % b=a(1:112*92); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������
      a=imresize(a,0.3);
      b=a(1:34*28);
     b=double(b);
      allsamples=[allsamples; b];  % allsamples ��һ��M * N ����allsamples ��ÿһ�����ݴ���һ��ͼƬ������M��200
    end
end
  allsamples=allsamples';


[  x_1, eignface_space,eignface] = pca_face( allsamples );

%ʶ��׶�
for i=3
    for j=6
      c=imread(strcat('ORL\s',num2str(i),'\',num2str(j),'.pgm'));
      test=imread(strcat('ORL\s',num2str(i),'\',num2str(j),'.pgm'));
      %imshow(a);
     % b=a(1:112*92); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������
      c=imresize(c,0.3);
      d=c(1:34*28);
     d=double(d);
      no_face=[no_face; d];
      no_face = no_face';% allsamples ��һ��M * N ����allsamples ��ÿһ�����ݴ���һ��ͼƬ������M��200
  end
end
mea_c=(no_face-x_1);
oumu = eignface_space'*mea_c;%��ʶ��������  55x1

%��ʶ��������������ŷ�Ͼ��룬˭С����������
%ŷʽ��oumu-eignface��(55x1-55x80)
alloushi=[];
oushi_sum=0;
[row,vir]=size(eignface); %[row,vir] row��  vir��
for i=1:vir
    for j=1:row
    oushi=(oumu(j,:)-eignface(j,i))^2;%ŷʽ����
    oushi_sum=oushi_sum+oushi;
    end
    oushi_sum=sqrt(oushi_sum);
    alloushi=[alloushi oushi_sum];
    oushi_sum=0;
end
[minx,index_oushi]=min(alloushi);

%��ʾͼƬ
group=index_oushi/5;
group=ceil(group);
dataface=imread(strcat('ORL\s',num2str(group),'\',num2str(1),'.pgm'));
subplot(211),imshow(dataface),title('���ݿ���')

hold on;
subplot(212),imshow(test),title('������')

