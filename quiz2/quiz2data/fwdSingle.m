function outputArg = fwdSingle(aw, axTrain)
    a_exp=exp(aw*(axTrain)');
    as=repmat(sum(a_exp,1),[10,1]);
    outputArg=a_exp./as;
end