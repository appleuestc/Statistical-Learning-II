function outputArg = relu(x)
    neg=(x<0);
    x(neg)=0;
    outputArg=x;
end