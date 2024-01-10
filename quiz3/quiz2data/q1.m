%% training
K=250;
rowDms=784;

digit=10;

yTrainBin=yTrain+1;
yTrainBin(yTrainBin~=digit)=-1;
yTrainBin(yTrainBin==digit)=1;
errTrain=zeros([250 1]);
gXTrain=zeros([size_train 1]);

yTestBin=yTest+1;
yTestBin(yTestBin~=digit)=-1;
yTestBin(yTestBin==digit)=1;
errTest=zeros([250 1]);
gXTest=zeros([size_test 1]);

ti=0;
j=1;
twResult=zeros([250 1]);
tiResult=zeros([250 1]);
jResult=ones([250 1]);

grad=zeros([rowDms 51 2]);

gamma5=zeros([size_train 1]);
gamma10=zeros([size_train 1]);
gamma50=zeros([size_train 1]);
gamma100=zeros([size_train 1]);
gamma250=zeros([size_train 1]);

heaviest=zeros([250 1]); 

for iter=1:1:K
    
    predTrain=(sgn(gXTrain))';
    errTrain(iter)=errCalc(predTrain,yTrainBin);
    predTest=(sgn(gXTest))';
    errTest(iter)=errCalc(predTest,yTestBin);

    if iter==5
        gamma5=yTrainBin.*gXTrain;
    elseif iter==10
        gamma10=yTrainBin.*gXTrain;
    elseif iter==50
        gamma50=yTrainBin.*gXTrain;
    elseif iter==100
        gamma100=yTrainBin.*gXTrain;
    elseif iter==250
        gamma250=yTrainBin.*gXTrain;
    end

    wgts=exp((-1).*yTrainBin.*gXTrain);
    maxWgtIdx=find(wgts==max(wgts));
    heaviest(iter)=maxWgtIdx(1);

    for tw=1:1:2
        twSlct=(tw-1.5)*2;
        for jn=1:1:rowDms
            for tn=0:1:50
                grad(jn,tn+1,tw)=sum((yTrainBin.*(twSlct).*alpha(xTrain,jn,tn/50).*wgts),1);
            end
        end
    end
    
    [newJ,newTi,newTw]=findMax(grad);
    j=newJ(1);ti=newTi(1);
    tw=0;tw(newTw(1)==1)=-1;tw(newTw(1)==2)=1;
     
    twResult(iter)=tw;
    tiResult(iter)=ti;
    jResult(iter)=j;

    wlIter=tw*alpha(xTrain,j,ti/50);
    wgtsSlct=wgts;
    wgtsSlct(wlIter==yTrainBin)=0;
    epsilon=sum(wgtsSlct)/sum(wgts);
    wt=0.5*log((1-epsilon)/epsilon);

    gXTrain=gXTrain+wt*wlIter;
    wlIterTest=tw*alpha(xTest,j,ti/50);
    gXTest=gXTest+wt*wlIterTest;
     
%     if mod(iter,25)==0
        fprintf(['Iteration ',num2str(iter),'/',num2str(K),' train error: ',num2str(errTrain(iter)),' test error: ',num2str(errTest(iter)),'\n'])
%     end
end
%% a
figure
plot(errTrain)
hold on
plot(errTest)
legend('Train','Test')
title(['digit ',num2str(digit-1)])
hold off
%% b
close all
hold on
cdf5=cdfplot(gamma5);
cdf10=cdfplot(gamma10);
cdf50=cdfplot(gamma50);
cdf100=cdfplot(gamma100);
cdf250=cdfplot(gamma250);

grid on;
xlabel('margin');
legend('5 iteration','10 iteration','50 iteration','100 iteration','250 iteration');
title(['digit ',num2str(digit-1)]);
hold off;
%% c
close all
hindex=[18599 81 5]; 
himg1=imrotate(fliplr(reshape(xTrain(hindex(1),:),[28,28])),90); 
himg2=imrotate(fliplr(reshape(xTrain(hindex(2),:),[28,28])),90); 
himg3=imrotate(fliplr(reshape(xTrain(hindex(3),:),[28,28])),90); 
 
subplot(2,3,1:3)
plot(heaviest)
xlabel('iterations');ylabel('index');grid on; 
title('hardest example (with largest weight) in each iteration'); 
subplot(2,3,4); 
imshow(himg1); 
subplot(2,3,5); 
imshow(himg2); 
subplot(2,3,6); 
imshow(himg3);
%% d
close all
A=128*ones(10,rowDms);
figure
for i=1:1:10
    for l=2:K+1
        best_j=grad(l,i,1);
        best_u=grad(l,i,2);
        if best_u>51
            A(i,best_j)=0;
        else
            A(i,best_j)=255;
        end
    end
    Ai=reshape(A(i,:),28,28)';
    subplot(2,5,i);
    imshow(uint8(Ai))
    title(['Array $$\textbf{a}$$ for the Binary Classifier ' num2str(i)],'interpreter','latex');
end

