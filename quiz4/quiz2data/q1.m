Cs=[2 4 8];
digits=1:10;
errTest=zeros(3,10);
margin=zeros(3,10,size_train);
g=zeros(10,size_test);
errOverall=zeros(3);
numSV=zeros(3,10);
largest=zeros(3,10,6);

for digit=digits
    if digit~=10
        yTrainBin=ones(size_train);
        yTestBin=ones(size_test);
        yTrainBin(yTrain~=digit)=-1;
        yTestBin(yTest~=digit)=-1;
    else
        yTrainBin=ones(size_train);
        yTestBin=ones(size_test);
        yTrainBin(yTrain~=0)=-1;
        yTestBin(yTest~=0)=-1;
    end
end

for i=1:3
    figure
    for digit=digits
        model=svmtrain(yTrainBin,xTrain);
        [~,acc,~]=svmpredict(yTestBin,xTest,model);
        errTest(i,digit)=100-acc(1);
        numSV(i,digit)=sum(model.nSV);
        [~,maxIndex]=maxk(model.sv_coef,3);
        [~,minIndex]=mink(model.sv_coef,3);
        largest(i,digit,1:3)=model.sv_indices(maxIndex);
        largest(i,digit,4:6)=model.sv_indices(minIndex);
        w=model.SVs'*model.sv_coef;
        b=-model.rho;
        if model.Label(1)==-1
            w=-w;
            b=-b;
        end
        margin(i,digit,:)=yTrainBin.*(w*xTrain+b);
        g(digit,:)=w*xTest+b;

        for j=1:6
            subplot(10,6,j+(digit-1)*6)
            colormap(gray(255))
            index=largest(i,digit,j);
            imshow(reshape(xTrain(index,:),28,28)')
        end
    end
    [~,yPred]=max(g);
    yPred(yPred==10)=0;
    errOverall(i)=sum(yPred'~=yTest)/size_test;
end

figure
for digit=digits
    subplot(2,5,digit)
    for i=1:3
        cdfplot(margin(i,digit,:))
        hold on
    end
    hold off
    if digit==1
        legend('C=2','C=4','C=8')
    end
    if digit==10
        title(['digit ',0])
    else
        title(['digit ',num2str(digit)])
    end
end


