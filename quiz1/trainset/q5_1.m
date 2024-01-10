clear;clc

origin="subset";
dimention=2500;
dataTrain=zeros(240,dimention);

for i=1:6
    folderName=strcat(origin,num2str(i-1));
    path=dir(fullfile(folderName,"*.jpg"));
    for j=1:length(path)
        img=path(j);
        imgName=strcat(folderName,"/",img.name);
        dataTrain(j+40*(i-1),:)=reshape(imread(imgName),1,dimention);
    end
end
dataTrain=dataTrain/255;

covTrain=cov(dataTrain); % Covariance matrix of training data
[V,D]=eig(covTrain); % Get eigen vector, eigen value diagonal matrix
[B,index]=sort(diag(D),'descend'); % Get the 16 largest
PCA_Train=zeros(dimention,16);

figure
for i=1:16
    PCA_Train(:,i)=V(:,index(i));
    subplot(4,4,i)
    arr=reshape(PCA_Train(:,i),50,50);
    arr=mat2gray(arr);
    imshow(arr)
    title(num2str(i))
end


