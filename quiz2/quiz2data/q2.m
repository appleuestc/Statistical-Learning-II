rowDms=784;
max_iter=4000;
lr=1e-5;
errTrain2=zeros(max_iter,1);
errTest2=zeros(max_iter,1);

for H=[10 20 50]
    w1=randn(H,rowDms);
    w2=randn(10,H);
    for i=1:max_iter
        % parameters for training
        a1_train=sigmoid(w1*(xTrain)');
        a2_train=softmax(w2*a1_train);
        % parameters for testing
        a1_test=sigmoid(w1*(xTest)');
        a2_test=softmax(w2*a1_test);
        % second
        dz2=a2_train-yTrainOH;
        dw2=dz2*(a1_train');
        dw1=((w2'*dz2).*(a1_train.*(1-a1_train)))*xTrain;
        % update weights
        w1=w1-lr*dw1;
        w2=w2-lr*dw2;
        % calculate error
        errTrain2(i,1)=errCalc2(yTrain,a2_train,size_train);
        errTest2(i,1)=errCalc2(yTest,a2_test,size_test);
    end
    errTrainFin2=errTrain2(max_iter)
    errTestFin2=errTest2(max_iter)
    figure
    plot(errTrain2)
    hold on
    plot(errTest2)
    legend('Train','Test')
    title(['H=' num2str(H)])
    hold off
end

