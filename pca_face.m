function [ X_1 , eignface_space,eignface] = pca_face( X )
%%%%pca
X_1=mean(X')';%平均脸
[dimen num]=size(X);%dimen行  num列
Init=X;%原始数据
for i=1:num
    X(:,i)=X(:,i)-X_1;  %每一张人脸与平均脸的差值
end
d=X;
C=d*d';%协方差矩阵
[l,m]=eig(C);%l特征值  m特征向量
V=eig(C);%V特征向量

%贡献率Rate
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

%特征脸空间
w = [];
for i = dimen:-1:index
    w = [w l(:,i)];
end
eignface_space=w;
%特征脸

eignface = w' * X;




