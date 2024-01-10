function outputArg = errCalc3(X,y,w)
    z=w*X';
    a=softmax(z);
    [~,idx]=max(a);
    sz=size(X,1);
    idx=idx-1;
    errs=sum(idx~=y');
    outputArg=errs/sz;
end