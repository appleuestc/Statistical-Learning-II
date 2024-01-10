K=250;
rowDms=784;
digit=6;

yTrainBin=yTrain+1; 
yTrainBin(yTrainBin~=digit)=-1; 
yTrainBin(yTrainBin==digit)=1; 
  
yTestBin=yTest+1; 
yTestBin(yTestBin~=digit)=-1; 
yTestBin(yTestBin==digit)=1; 
  

ti=0;
j=1;
grad=zeros([rowDms 51 2]);
  
gXTrain=zeros([size_train 1]);
gXTest=zeros([size_test 1]);
  
errTrain=zeros([250 1]); 
errTest=zeros([250 1]);
  
heaviest=zeros([250 1]); 
 
gamma5=zeros([size_train 1]);
gamma10=zeros([size_train 1]);
gamma50=zeros([size_train 1]);
gamma100=zeros([size_train 1]);
gamma250=zeros([size_train 1]);
  
twResult=zeros([250 1]); 
tiResult=zeros([250 1]); 
jResult=ones([250 1]); 

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
     
    fprintf(['iteration: ',num2str(iter),'; train_error: ',num2str(errTrain(iter)),'; test_error: ',num2str(errTest(iter)),'\n']); 
end 


