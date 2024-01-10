Cs=[2 4 8];
digits=1:10;
errTest1=zeros(1,10);
margin1=zeros(10,size_train);
g1=zeros(10,size_test);
numSV1=zeros(1,10);
largest1=zeros(6,10);

for digit=digits
    if digit~=10
        yTrainBin=ones(size(yTrain));
        yTestBin=ones(size(yTest));
        yTrainBin(yTrain~=digit)=-1;
        yTestBin(yTest~=digit)=-1;
    else
        yTrainBin=ones(size(yTrain));
        yTestBin=ones(size(yTest));
        yTrainBin(yTrain~=0)=-1;
        yTestBin(yTest~=0)=-1;
    end
end


bestVal=0;
for i=-1:1
    for j=-4:-2
        val=svmtrain(yTrain,xTrain,['-v 5 -c ', num2str(2^i), ' -g ', num2str(2^j)]);
        if val>=bestVal
            bestVal=val;
            bestC=2^i;
            bestOutput=2^j;
        end
    end
end

figure
for digit=digits
    model1=svmtrain(yTrainBin,xTrain,sprintf('-c %g -g %g',bestC,bestOutput));
    [a,acc,d]=svmpredict(yTestBin,xTest,model1);
    errTest1(1,digit)=100-acc(1);
    numSV1(digit)=sum(model1.nSV);
    [~,maxIndex]=maxk(model1.sv_coef,3);
    [~,minIndex]=mink(model1.sv_coef,3);
    largest1(1:3,digit)=model1.sv_indices(maxIndex);
    largest1(4:6,digit)=model1.sv_indices(minIndex);
    w1=model1.SVs'*model1.sv_coef;
    b1=-model1.rho;
    if model1.Label(1)==-1
        w1=-w1;
        b1=-b1;
    end
    margin1(digit,:)=yTrainBin.*(xTrain*w1+b1);
    
    g1(digit,:)=xTest*w1+b1;
    for i=1:6
        subplot(10,6,i+(digit-1)*6)
        colormap(gray(255))
        index=largest1(i,digit);
        imshow(reshape(xTrain(index,:),28,28)')
    end
end

[~,yPred]=max(g1);
yPred(yPred==10)=0;
errOverall1=sum(yPred'~=yTest)/size_test;

%%
figure
for digit=digits
    for i=1:6
        subplot(10,6,i+(digit-1)*6)
        colormap(gray(255))
        index=largest1(i,digit);
        imshow(reshape(xTrain(index,:),28,28)')
    end
end
%%
figure
for digit=digits
    subplot(2,5,digit)
    cdfplot(margin1(digit,:))
    if digit==10
        title(['digit ',0])
    else
        title(['digit ',num2str(digit)])
    end
end
%%
kkk=zeros(1,10);
kkk(5)=8

