clear;clc
mA1=[10;0];
mA2=-mA1;
covA=[1 0;0 2];
N=1000;
XA1=mvnrnd(mA1,covA,N);
XA2=mvnrnd(mA2,covA,N);

XA=cat(1,XA1,XA2);
pcaA=pca(XA);

covXA1=cov(XA1);
covXA2=cov(XA2);
wA=covXA1+covXA2;
bA=(mA1-mA2)*(mA1-mA2)';
[vecA, diagA] = eig(wA\bA);
ldaA=vecA(:,1);

figure
plot(XA1(:,1),XA1(:,2),'.')
hold on
plot(XA2(:,1),XA2(:,2),'.')
hold on
quiver(0, 0, -pcaA(1, 1), pcaA(2, 1),7,"LineWidth",1);
hold on
quiver(0, 0, ldaA(2, 1), ldaA(1, 1),7,"LineWidth",1);
legend('Class1','Class2','PCA','LDA')
hold off
title('Condition A')

mB1=[2;0];
mB2=-mB1;
covB=[1 0;0 10];
N=1000;
XB1=mvnrnd(mB1,covB,N);
XB2=mvnrnd(mB2,covB,N);

XB=cat(1,XB1,XB2);
pcaB=pca(XB);

covXB1=cov(XB1);
covXB2=cov(XB2);
wB=covXB1+covXB2;
bB=(mB1-mB2)*(mB1-mB2)';
[vecB, diagB] = eig(wB\bB);
ldaB=vecB(:,1);

figure
plot(XB1(:,1),XB1(:,2),'.')
hold on
plot(XB2(:,1),XB2(:,2),'.')
hold on
quiver(0, 0, -pcaB(1, 1), pcaB(2, 1),7,"LineWidth",1);
hold on
quiver(0, 0, ldaB(2, 1), ldaB(1, 1),7,"LineWidth",1);
legend('Class1','Class2','PCA','LDA')
hold off
title('Condition B')
