function outputArg = errCalcSGDSig(X,y,wSig1,wSig2)
    a1=sigmoid(wSig1*X');
    a2=softmax(wSig2*a1);
    [~,idx]=max(a2);
    sz=size(X,1);
    idx=idx-1;
    errs=sum(idx~=y');
    outputArg=errs/sz;
end