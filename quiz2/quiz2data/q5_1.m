rowDms=784;
labelTrain=yTrainOH;
imgTrain=xTrain';
max_iter=15;
lr=0.01;
w=randn(10,rowDms);
errSGDTrain=zeros(max_iter*60,1);
errSGDTest=zeros(max_iter*60,1);

for i=1:max_iter
    p=randperm(size_train);
    imgRand=imgTrain(:,p);
    labelRand=labelTrain(:,p);
    for j=1:size_train
        img=imgRand(:,j);
        a=softmax(w*img);
        dw=(a-labelRand(:,j))*(img');
        % update weight
        w=w-lr*dw;
        if mod(j,1000)==0
            errSGDTrain((i-1)*60+j/1000,1)=errCalc3(xTrain,yTrain,w);
            errSGDTest((i-1)*60+j/1000,1)=errCalc3(xTest,yTest,w);
        end
    end
end

errTrainFinSGD=errSGDTrain(max_iter*60);
errTestFinSGD=errSGDTest(max_iter*60);

figure
plot(linspace(0,max_iter,max_iter*60),errSGDTrain)
hold on
plot(linspace(0,max_iter,max_iter*60),errSGDTest)
xlim([0,max_iter]);
legend('Train', 'Test')
hold off





