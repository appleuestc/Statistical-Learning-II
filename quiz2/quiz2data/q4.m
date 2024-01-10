rowDms=784;
H=[10 20 50];
max_iter=2800;
lr=2e-6;
lamda=1e-4;
errTrainSig1=zeros(max_iter,1);
errTestSig1=zeros(max_iter,1);
errTrainRe1=zeros(max_iter,1);
errTestRe1=zeros(max_iter,1);
figure

for i=1:3
    wSig1=randn(H(i),rowDms);
    wSig2=randn(10,H(i));
    wRe1=randn(H(i),rowDms)*0.01;
    wRe2=randn(10,H(i))*0.01;
    for j=1:max_iter
        %% sigmoid
        aSig1_train=sigmoid(wSig1*(xTrain)');
        aSig2_train=softmax(wSig2*aSig1_train);
        aSig1_test=sigmoid(wSig1*(xTest)');
        aSig2_test=softmax(wSig2*aSig1_test);
        dzSig2=aSig2_train-yTrainOH;
        dwSig2=dzSig2*(aSig1_train');
        dwSig2=dwSig2+2*wSig2*lamda/lr;
        dwSig1=((wSig2'*dzSig2).*(aSig1_train.*(1-aSig1_train)))*xTrain;
        dwSig1=dwSig1+2*wSig1*lamda/lr;
        wSig1=wSig1-lr*dwSig1;
        wSig2=wSig2-lr*dwSig2;
        errTrainSig1(j,1)=errCalc2(yTrain,aSig2_train,size_train);
        errTestSig1(j,1)=errCalc2(yTest,aSig2_test,size_test);
        %% ReLU
        zRe1_train=wRe1*(xTrain)';
        aRe1_train=relu(zRe1_train);
        aRe2_train=softmax(wRe2*aRe1_train);
        zRe1_test=wRe1*(xTest)';
        aRe1_test=relu(zRe1_test);
        aRe2_test=softmax(wRe2*aRe1_test);
        dzRe2=aRe2_train-yTrainOH;
        dwRe2=dzRe2*(aRe1_train');
        dwRe2=dwRe2+2*wRe2*lamda/lr;
        dReLU_train=ones(H(i),size_train);
        dReLU_train(zRe1_train<0)=0;
        dwRe1=((wRe2'*dzRe2).*dReLU_train)*xTrain;
        dwRe1=dwRe1+2*wRe1*lamda/lr;
        wRe1=wRe1-lr*dwRe1;
        wRe2=wRe2-lr*dwRe2;
        errTrainRe1(j,1)=errCalc2(yTrain,aRe2_train,size_train);
        errTestRe1(j,1)=errCalc2(yTest,aRe2_test,size_test);
    end
    errTrainFinSig1=errTrainSig1(max_iter)
    errTestFinSig1=errTestSig1(max_iter)
    errTrainFinRe1=errTrainRe1(max_iter)
    errTestFinRe1=errTestRe1(max_iter)
    
    subplot(3,2,i*2-1)
    plot(errTrainSig1)
    hold on
    plot(errTestSig1)
    legend('Train','Test')
    title(['Sigmoid, H=' num2str(H(i))])
    hold off

    subplot(3,2,i*2)
    plot(errTrainRe1)
    hold on
    plot(errTestRe1)
    legend('Train','Test')
    title(['ReLU, H=' num2str(H(i))])
    hold off
end

