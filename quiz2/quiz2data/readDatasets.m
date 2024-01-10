clear;clc

xTrainFile="E:\Work\hw2\codes\quiz2data\training set\train-images.idx3-ubyte";
yTrainFile="E:\Work\hw2\codes\quiz2data\training set\train-labels.idx1-ubyte";
xTestFile="E:\Work\hw2\codes\quiz2data\test set\t10k-images.idx3-ubyte";
yTestFile="E:\Work\hw2\codes\quiz2data\test set\t10k-labels.idx1-ubyte";

[xTrain, yTrain]=readMNIST(xTrainFile,yTrainFile,60000,0);
[xTest, yTest]=readMNIST(xTestFile,yTestFile,10000,0);

size_train=size(xTrain,1);
size_test=size(xTest,1);
yTrainOH=zeros(10,size_train);
for i=1:size_train
    yTrainOH(yTrain(i)+1,i)=1;
end
