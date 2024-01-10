% Load testset
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

% Compute fi, mean, variance of z
fi=PCA_Train(:,1:15)';
mu_z=cell(1,6);
var_z=cell(1,6);
for i=1:6
    imgC=(dataTrs{i})';
    z=(fi*imgC)';
    mu_z{i}=(mean(z))';
    var_z{i}=cov(z);
end

% Compute error
eC=zeros(1,6);
dets=zeros(1,6);
invs=cell(1,6);
for i=1:6
    dets(i)=det(var_z{i});
    invs{i}=pinv(var_z{i});
end
for i=6:11
    arrTest=(fi*(dataTests{i})')';
    falseC=0;
    for j=1:10
        pixel=(arrTest(j,:))';
        trueC=(pixel-mu_z{i-5})'* invs{i-5} * (pixel-mu_z{i-5}) + log(dets(i-5));
        for k=1:6
            if k==i-5
                continue
            end
            result=(pixel-mu_z{k})'* invs{k} * (pixel-mu_z{k}) + log(dets(k));
            if result<trueC
                falseC=falseC+1;
                break
            end
        end
    end
    eC(i-5)=falseC/10;
end
