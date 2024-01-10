function outputArg = alpha(x,j,t)
    outputArg=zeros(size(x,1),1);
    outputArg(x(:,j)<t)=-1;
    outputArg(x(:,j)>=t)=1;
end