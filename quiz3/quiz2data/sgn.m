function outputArg = sgn(x)
    outputArg(x<0)=-1;
    outputArg(x==0)=0;
    outputArg(x>0)=1;
end