clear;clc

origin="subset";
dataTrains=cell(1,6);
dimention=2500;

mu=cell(1,6);
var=cell(1,6);
w=cell(1,15);

for i=1:6
    folderName=strcat(origin,num2str(i-1));
    path=dir(fullfile(folderName,"*.jpg"));
    dataTrain=zeros(40,2500);
    for j=1:length(path)
        img=path(j);
        imgName=strcat(folderName,"/",img.name);
        dataTrain(j,:)=reshape(imread(imgName),1,dimention);
    end
    dataTrain=dataTrain/255;
    dataTrains{i}=dataTrain;
%   Calculate mean and variance
    mu{i}=(mean(dataTrains{i}))';
    var{i}=cov(dataTrains{i});
end

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

% Make plots
figure
for i=1:15
    subplot(4,4,i)
    LDA_Train=mat2gray(reshape(w{i},50,50));
    imshow(LDA_Train)
    title(num2str(i))
end

