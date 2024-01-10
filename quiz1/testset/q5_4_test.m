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

mu_d=cell(1,30);
var_d=cell(1,30);

%% Assign values
for i=1:5
    w_i=w{i};
    imgD1=dataTrs{1};
    imgD2=dataTrs{i+1};
    imgD1=imgD1*w_i;
    imgD2=imgD2*w_i;
    mu_d{2*i-1}=mean(imgD1);
    var_d{2*i-1}=cov(imgD1);
    mu_d{2*i}=mean(imgD2);
    var_d{2*i}=cov(imgD2);
end

for i=6:9
    w_i=w{i};
    imgD1=dataTrs{2};
    imgD2=dataTrs{i-3};
    imgD1=imgD1*w_i;
    imgD2=imgD2*w_i;
    mu_d{2*i-1}=mean(imgD1);
    var_d{2*i-1}=cov(imgD1);
    mu_d{2*i}=mean(imgD2);
    var_d{2*i}=cov(imgD2);
end

for i=10:12
    w_i=w{i};
    imgD1=dataTrs{3};
    imgD2=dataTrs{i-3*2};
    imgD1=imgD1*w_i;
    imgD2=imgD2*w_i;
    mu_d{2*i-1}=mean(imgD1);
    var_d{2*i-1}=cov(imgD1);
    mu_d{2*i}=mean(imgD2);
    var_d{2*i}=cov(imgD2);
end

for i=13:14
    w_i=w{i};
    imgD1=dataTrs{4};
    imgD2=dataTrs{i-8};
    imgD1=imgD1*w_i;
    imgD2=imgD2*w_i;
    mu_d{2*i-1}=mean(imgD1);
    var_d{2*i-1}=cov(imgD1);
    mu_d{2*i}=mean(imgD2);
    var_d{2*i}=cov(imgD2);
end

for i=15:15
    w_i=w{i};
    imgD1=dataTrs{5};
    imgD2=dataTrs{i-9};
    imgD1=imgD1*w_i;
    imgD2=imgD2*w_i;
    mu_d{2*i-1}=mean(imgD1);
    var_d{2*i-1}=cov(imgD1);
    mu_d{2*i}=mean(imgD2);
    var_d{2*i}=cov(imgD2);
end

%% Error calculation
eD=zeros(1,6);

% Person 1
imgD=dataTests{6};
falseD=0;
for i=1:10
    pixel=imgD(i,:);
    for j=1:5
        rate1=0.5*(pixel*w{j}-mu_d{2*j-1})^2/var_d{2*j-1}+log(var_d{2*j-1});
        rate2=0.5*(pixel*w{j}-mu_d{2*j})^2/var_d{2*j}+log(var_d{2*j});
        if rate2<rate1
            falseD=falseD+1;
            break
        end
    end
end
eD(1)=falseD/10;

% Person 2
imgD=dataTests{7};
falseD=0;
for i=1:10
    pixel=imgD(i,:);
    rate1=0.5*(pixel*w{1}-mu_d{1})^2/var_d{1}+log(var_d{1});
    rate2=0.5*(pixel*w{1}-mu_d{2})^2/var_d{2}+log(var_d{2});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    for j=6:9
        rate1=0.5*(pixel*w{j}-mu_d{2*j-1})^2/var_d{2*j-1}+log(var_d{2*j-1});
        rate2=0.5*(pixel*w{j}-mu_d{2*j})^2/var_d{2*j}+log(var_d{2*j});
        if rate2<rate1
            falseD=falseD+1;
        end
    end
end
eD(2)=falseD/10;

% Person 3
imgD=dataTests{8};
falseD=0;
for i=1:10
    pixel=imgD(i,:);
    rate1=0.5*(pixel*w{2}-mu_d{3})^2/var_d{3}+log(var_d{3});
    rate2=0.5*(pixel*w{2}-mu_d{4})^2/var_d{4}+log(var_d{4});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{6}-mu_d{11})^2/var_d{11}+log(var_d{11});
    rate2=0.5*(pixel*w{6}-mu_d{12})^2/var_d{12}+log(var_d{12});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    for j=10:12
        rate1=0.5*(pixel*w{j}-mu_d{2*j-1})^2/var_d{2*j-1}+log(var_d{2*j-1});
        rate2=0.5*(pixel*w{j}-mu_d{2*j})^2/var_d{2*j}+log(var_d{2*j});
        if rate2<rate1
            falseD=falseD+1;
        end
    end
end
eD(3)=falseD/10;

% Person 4
imgD=dataTests{9};
falseD=0;
for i=1:10
    pixel=imgD(i,:);
    rate1=0.5*(pixel*w{3}-mu_d{5})^2/var_d{5}+log(var_d{5});
    rate2=0.5*(pixel*w{3}-mu_d{6})^2/var_d{6}+log(var_d{6});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{7}-mu_d{13})^2/var_d{13}+log(var_d{13});
    rate2=0.5*(pixel*w{7}-mu_d{14})^2/var_d{14}+log(var_d{14});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{10}-mu_d{19})^2/var_d{19}+log(var_d{19});
    rate2=0.5*(pixel*w{10}-mu_d{20})^2/var_d{20}+log(var_d{20});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    for j=13:14
        rate1=0.5*(pixel*w{j}-mu_d{2*j-1})^2/var_d{2*j-1}+log(var_d{2*j-1});
        rate2=0.5*(pixel*w{j}-mu_d{2*j})^2/var_d{2*j}+log(var_d{2*j});
        if rate2<rate1
            falseD=falseD+1;
        end
    end
end
eD(4)=falseD/10;

% Person 5
imgD=dataTests{10};
falseD=0;
for i=1:10
    pixel=imgD(i,:);
    rate1=0.5*(pixel*w{4}-mu_d{7})^2/var_d{7}+log(var_d{7});
    rate2=0.5*(pixel*w{4}-mu_d{8})^2/var_d{8}+log(var_d{8});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{8}-mu_d{15})^2/var_d{15}+log(var_d{15});
    rate2=0.5*(pixel*w{8}-mu_d{16})^2/var_d{16}+log(var_d{16});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{11}-mu_d{21})^2/var_d{21}+log(var_d{21});
    rate2=0.5*(pixel*w{11}-mu_d{22})^2/var_d{22}+log(var_d{22});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{13}-mu_d{25})^2/var_d{25}+log(var_d{25});
    rate2=0.5*(pixel*w{13}-mu_d{26})^2/var_d{26}+log(var_d{26});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    for j=15:15
        rate1=0.5*(pixel*w{j}-mu_d{2*j-1})^2/var_d{2*j-1}+log(var_d{2*j-1});
        rate2=0.5*(pixel*w{j}-mu_d{2*j})^2/var_d{2*j}+log(var_d{2*j});
        if rate2<rate1
            falseD=falseD+1;
        end
    end
end
eD(5)=falseD/10;

% Person 6
imgD=dataTests{11};
falseD=0;
for i=1:10
    pixel=imgD(i,:);
    rate1=0.5*(pixel*w{5}-mu_d{9})^2/var_d{9}+log(var_d{9});
    rate2=0.5*(pixel*w{5}-mu_d{10})^2/var_d{10}+log(var_d{10});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{9}-mu_d{17})^2/var_d{17}+log(var_d{17});
    rate2=0.5*(pixel*w{9}-mu_d{18})^2/var_d{18}+log(var_d{18});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{12}-mu_d{23})^2/var_d{23}+log(var_d{23});
    rate2=0.5*(pixel*w{12}-mu_d{24})^2/var_d{24}+log(var_d{24});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{14}-mu_d{27})^2/var_d{27}+log(var_d{27});
    rate2=0.5*(pixel*w{14}-mu_d{28})^2/var_d{28}+log(var_d{28});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
    rate1=0.5*(pixel*w{15}-mu_d{29})^2/var_d{29}+log(var_d{29});
    rate2=0.5*(pixel*w{15}-mu_d{30})^2/var_d{30}+log(var_d{30});
    if rate1<rate2
        falseD=falseD+1;
        continue
    end
end
eD(6)=falseD/10;
