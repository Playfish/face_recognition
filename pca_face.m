function [ X_1 , eignface_space,eignface] = pca_face( X )
%%%%pca
X_1=mean(X')';%ƽ����
[dimen num]=size(X);%dimen��  num��
Init=X;%ԭʼ����
for i=1:num
    X(:,i)=X(:,i)-X_1;  %ÿһ��������ƽ�����Ĳ�ֵ
end
d=X;
C=d*d';%Э�������
[l,m]=eig(C);%l����ֵ  m��������
V=eig(C);%V��������

%������Rate
tmp = 0;
sumV=sum(V);
for i =dimen:-1:1
    tmp = tmp + V(i,1);
    Rate = tmp/sumV;
    if Rate >= 0.97
        index = i;
        break;
    end
end

%�������ռ�
w = [];
for i = dimen:-1:index
    w = [w l(:,i)];
end
eignface_space=w;
%������

eignface = w' * X;




