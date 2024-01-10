function outputArg = softmax(x)
    outputArg=exp(x)./sum(exp(x),1);
end