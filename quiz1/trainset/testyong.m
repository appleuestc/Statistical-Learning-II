clear;clc
origin="subset";
dataTests=cell(1,11);
dimention=2500;

for i=6:11
    folderName=strcat(origin,num2str(i));
    path=dir(fullfile(folderName,"*.jpg"));
    dataTest=zeros(10,2500);
    for j=1:length(path)
        img=path(j);
        imgName=strcat(folderName,"/",img.name);
        dataTest(j,:)=reshape(imread(imgName),1,dimention);
    end
    dataTest=dataTest/255;
    dataTests{i}=dataTest;
end

