function outputArg = errCalc(pred,y)
    error=length(find(pred~=y));
    outputArg=error/size(pred,1);
end