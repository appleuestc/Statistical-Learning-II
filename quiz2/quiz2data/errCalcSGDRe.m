function outputArg = errCalcSGDRe(X,y,wRe1,wRe2)
    a1=relu(wRe1*X');
    a2=softmax(wRe2*a1);
    [~,idx]=max(a2);
    sz=size(X,1);
    idx=idx-1;
    errs=sum(idx~=y');
    outputArg=errs/sz;
end