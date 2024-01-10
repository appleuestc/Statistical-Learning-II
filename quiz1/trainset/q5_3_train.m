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
[B,index]=sort(diag(D),'descend'); % Get the 16 largest
PCA_Train=zeros(dimention,16);

for i=1:16
    PCA_Train(:,i)=V(:,index(i));
end
