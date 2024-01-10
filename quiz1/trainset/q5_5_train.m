clear;clc

origin="subset";
dimention=2500;
dataTrain=zeros(240,dimention);
dataTrs=cell(1,6);

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
end
dataTrain=dataTrain/255;

covTrain=cov(dataTrain); % Covariance matrix of training data
[V,D]=eig(covTrain); % Get eigen vector, eigen value diagonal matrix
fi=V(:,2471:dimention);

%%   Calculate mean and variance
mu_e=cell(1,6);
var_e=cell(1,6);

for i=1:6
    mu_e{i}=(mean(dataTrs{i}*fi))';
    var_e{i}=cov(dataTrs{i}*fi);
end

%%   Calculate w
w=cell(1,15);
wIndex=1;
for i=1:6
    mu_i=mu_e{i};
    var_i=var_e{i};
    for j=(i+1):6
        mu_j=mu_e{j};
        var_j=var_e{j};
        w{wIndex}=pinv(var_i+var_j+eye(30))*(mu_i-mu_j);
        wIndex=wIndex+1;
    end
end

%% Assign values
muE=cell(1,30);
varE=cell(1,30);

for i=1:5
    w_i=w{i};
    imgE1=dataTrs{1}*fi;
    imgE2=dataTrs{i+1}*fi;
    imgE1=imgE1*w_i;
    imgE2=imgE2*w_i;
    muE{2*i-1}=mean(imgE1);
    varE{2*i-1}=cov(imgE1);
    muE{2*i}=mean(imgE2);
    varE{2*i}=cov(imgE2);
end

for i=6:9
    w_i=w{i};
    imgE1=dataTrs{2}*fi;
    imgE2=dataTrs{i-3}*fi;
    imgE1=imgE1*w_i;
    imgE2=imgE2*w_i;
    muE{2*i-1}=mean(imgE1);
    varE{2*i-1}=cov(imgE1);
    muE{2*i}=mean(imgE2);
    varE{2*i}=cov(imgE2);
end

for i=10:12
    w_i=w{i};
    imgE1=dataTrs{3}*fi;
    imgE2=dataTrs{i-3*2}*fi;
    imgE1=imgE1*w_i;
    imgE2=imgE2*w_i;
    muE{2*i-1}=mean(imgE1);
    varE{2*i-1}=cov(imgE1);
    muE{2*i}=mean(imgE2);
    varE{2*i}=cov(imgE2);
end

for i=13:14
    w_i=w{i};
    imgE1=dataTrs{4}*fi;
    imgE2=dataTrs{i-8}*fi;
    imgE1=imgE1*w_i;
    imgE2=imgE2*w_i;
    muE{2*i-1}=mean(imgE1);
    varE{2*i-1}=cov(imgE1);
    muE{2*i}=mean(imgE2);
    varE{2*i}=cov(imgE2);
end

for i=15:15
    w_i=w{i};
    imgE1=dataTrs{5}*fi;
    imgE2=dataTrs{i-9}*fi;
    imgE1=imgE1*w_i;
    imgE2=imgE2*w_i;
    muE{2*i-1}=mean(imgE1);
    varE{2*i-1}=cov(imgE1);
    muE{2*i}=mean(imgE2);
    varE{2*i}=cov(imgE2);
end
