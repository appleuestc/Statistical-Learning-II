rowDms=784;
H=[10 20 50];
labelTrain=yTrainOH;
imgTrain=xTrain';
max_iter=15;
lrS=0.01;
lrR=2e-3;
errTrainFinSGDSig=zeros(3,1);
errTestFinSGDSig=zeros(3,1);
errTrainFinSGDRe=zeros(3,1);
errTestFinSGDRe=zeros(3,1);
errTrainSig2=zeros(max_iter*60,1);
errTestSig2=zeros(max_iter*60,1);
errTrainRe2=zeros(max_iter*60,1);
errTestRe2=zeros(max_iter*60,1);
figure

for i=1:3
    wSig1=randn(H(i),rowDms);
    wSig2=randn(10,H(i));
    wRe1=randn(H(i),rowDms)*0.01;
    wRe2=randn(10,H(i))*0.01;
    for j=1:max_iter
        p=randperm(size_train);
        imgRand=imgTrain(:,p);
        labelRand=labelTrain(:,p);
        for k=1:size_train
            img=imgRand(:,k);
            %% sigmoid
            aSig1=sigmoid(wSig1*img);
            aSig2=softmax(wSig2*aSig1);
            dzSig2=aSig2-labelRand(:,k);
            dwSig2=dzSig2*(aSig1');
            dwSig1=((wSig2'*dzSig2).*(aSig1.*(1-aSig1)))*(img');
            wSig1=wSig1-lrS*dwSig1;
            wSig2=wSig2-lrS*dwSig2;
            %% ReLU
            zRe1=wRe1*img;
            aRe1=relu(zRe1);
            aRe2=softmax(wRe2*aRe1);
            dzRe2=aRe2-labelRand(:,k);
            dwRe2=dzRe2*(aRe1');
            dReLU=ones(H(i),1);
            dReLU(zRe1<0)=0;
            dwRe1=((wRe2'*dzRe2).*dReLU)*(img');
            wRe1=wRe1-lrR*dwRe1;
            wRe2=wRe2-lrR*dwRe2;
            %% error calculation
            if mod(k,1000)==0
                errTrainSig2((j-1)*60+k/1000,1)=errCalcSGDSig(xTrain,yTrain,wSig1,wSig2);
                errTestSig2((j-1)*60+k/1000,1)=errCalcSGDSig(xTest,yTest,wSig1,wSig2);
                errTrainRe2((j-1)*60+k/1000,1)=errCalcSGDRe(xTrain,yTrain,wRe1,wRe2);
                errTestRe2((j-1)*60+k/1000,1)=errCalcSGDRe(xTest,yTest,wRe1,wRe2);
            end
        end
    end

    errTrainFinSGDSig(i)=errTrainSig2(j*60);
    errTestFinSGDSig(i)=errTestSig2(j*60);
    errTrainFinSGDRe(i)=errTrainRe2(j*60);
    errTestFinSGDRe(i)=errTestRe2(j*60);

    subplot(3,2,i*2-1)
    plot(linspace(0,max_iter,max_iter*60),errTrainSig2)
    hold on
    plot(linspace(0,max_iter,max_iter*60),errTestSig2)
    xlim([0,max_iter]);
    legend('Train','Test')
    title(['Sigmoid, H=' num2str(H(i))])
    hold off

    subplot(3,2,i*2)
    plot(linspace(0,max_iter,max_iter*60),errTrainRe2)
    hold on
    plot(linspace(0,max_iter,max_iter*60),errTestRe2)
    xlim([0,max_iter]);
    legend('Train','Test')
    title(['ReLU, H=' num2str(H(i))])
    hold off
end





