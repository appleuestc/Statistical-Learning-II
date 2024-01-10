clear;clc

origin="subset";
dimention=2500;
dataTrain=zeros(240,dimention);
dataTrs=cell(1,6);
mu=cell(1,6);
var=cell(1,6);
w=cell(1,15);

for i=1:6
    folderName=strcat(origin,num2str(i-1));
    path=dir(fullfile(folderName,"*.jpg"));
    dataTr=zeros(40,dimention);
    for j=1:length(path)
        img=path(j);
        imgName=strcat(folderName,"/",img.name);
        dataTrain(j+40*(i-1),:)=reshape(imread(imgName),1,dimention);
        dataTr(j,:)=reshape(imread(imgName),1,dimention);
    end
    dataTr=dataTr/255;
    dataTrs{i}=dataTr;
%   Calculate mean and variance
    mu{i}=(mean(dataTrs{i}))';
    var{i}=cov(dataTrs{i});
end
dataTrain=dataTrain/255;

%   Calculate w, this section runs a long time
wIndex=1;
for i=1:6
    mu_i=mu{i};
    var_i=var{i};
    for j=(i+1):6
        mu_j=mu{j};
        var_j=var{j};
        w{wIndex}=pinv(var_i+var_j+eye(dimention))*(mu_i-mu_j);
        wIndex=wIndex+1;
    end
end