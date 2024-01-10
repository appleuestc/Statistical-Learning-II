function outputArg = errCalc2(y,a2,sz)
    [~,idx]=max(a2);
    idx=idx-1;
    errs=sum(idx~=y');
    outputArg=errs/sz;
end