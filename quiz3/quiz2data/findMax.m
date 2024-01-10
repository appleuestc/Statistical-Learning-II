function [outputArg1,outputArg2,outputArg3] = findMax(Q)
    a=size(Q,1);
    b=size(Q,2);
    idx=find(Q==max(Q(:)));
    idx=idx(1);
    remainder=mod(idx,a*b);
    outputArg3=floor((idx-1)/(a*b))+1;
    if remainder~=0
        outputArg2=floor((remainder-1)/a)+1;
        if mod(remainder,a)~=0
            outputArg1=mod(remainder,a);
        else
            outputArg1=a;
        end
    else
        outputArg1=a;
        outputArg2=b;
    end
end