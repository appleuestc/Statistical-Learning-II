function outputArg = errCalc1(y,a,sz)
    [~,idx]=max(a);
    idx=idx-1;
    errs=sum(idx~=y');
    outputArg=errs/sz;
end