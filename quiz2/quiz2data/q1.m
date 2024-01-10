rowDms=784;
max_iter=3000;
lr=1e-5;
w=randn(10,rowDms);
errTrain1=zeros(max_iter,1);
errTest1=zeros(max_iter,1);

for i=1:max_iter
    a_train=softmax(w*(xTrain)');
    a_test=softmax(w*(xTest)');
    dw=(a_train-yTrainOH)*xTrain;
    % update weight
    w=w-lr*dw;
    errTrain1(i,1)=errCalc1(yTrain,a_train,size_train);
    errTest1(i,1)=errCalc1(yTest,a_test,size_test);
end


figure
plot(errTrain1)
hold on
plot(errTest1)
legend('Train', 'Test')
hold off


