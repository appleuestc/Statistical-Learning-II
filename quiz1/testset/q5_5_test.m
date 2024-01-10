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

%% Error calculation
eE=zeros(1,6);

% Person 1
imgE=dataTests{6}*fi;
falseE=0;
for i=1:10
    pixel=imgE(i,:);
    for j=1:5
        rate1=0.5*(pixel*w{j}-muE{2*j-1})^2/varE{2*j-1}+log(varE{2*j-1});
        rate2=0.5*(pixel*w{j}-muE{2*j})^2/varE{2*j}+log(varE{2*j});
        if rate2<rate1
            falseE=falseE+1;
            break
        end
    end
end
eE(1)=falseE/10;

% Person 2
imgE=dataTests{7}*fi;
falseE=0;
for i=1:10
    pixel=imgE(i,:);
    rate1=0.5*(pixel*w{1}-muE{1})^2/varE{1}+log(varE{1});
    rate2=0.5*(pixel*w{1}-muE{2})^2/varE{2}+log(varE{2});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    for j=6:9
        rate1=0.5*(pixel*w{j}-muE{2*j-1})^2/varE{2*j-1}+log(varE{2*j-1});
        rate2=0.5*(pixel*w{j}-muE{2*j})^2/varE{2*j}+log(varE{2*j});
        if rate2<rate1
            falseE=falseE+1;
        end
    end
end
eE(2)=falseE/10;

% Person 3
imgE=dataTests{8}*fi;
falseE=0;
for i=1:10
    pixel=imgE(i,:);
    rate1=0.5*(pixel*w{2}-muE{3})^2/varE{3}+log(varE{3});
    rate2=0.5*(pixel*w{2}-muE{4})^2/varE{4}+log(varE{4});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{6}-muE{11})^2/varE{11}+log(varE{11});
    rate2=0.5*(pixel*w{6}-muE{12})^2/varE{12}+log(varE{12});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    for j=10:12
        rate1=0.5*(pixel*w{j}-muE{2*j-1})^2/varE{2*j-1}+log(varE{2*j-1});
        rate2=0.5*(pixel*w{j}-muE{2*j})^2/varE{2*j}+log(varE{2*j});
        if rate2<rate1
            falseE=falseE+1;
        end
    end
end
eE(3)=falseE/10;

% Person 4
imgE=dataTests{9}*fi;
falseE=0;
for i=1:10
    pixel=imgE(i,:);
    rate1=0.5*(pixel*w{3}-muE{5})^2/varE{5}+log(varE{5});
    rate2=0.5*(pixel*w{3}-muE{6})^2/varE{6}+log(varE{6});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{7}-muE{13})^2/varE{13}+log(varE{13});
    rate2=0.5*(pixel*w{7}-muE{14})^2/varE{14}+log(varE{14});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{10}-muE{19})^2/varE{19}+log(varE{19});
    rate2=0.5*(pixel*w{10}-muE{20})^2/varE{20}+log(varE{20});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    for j=13:14
        rate1=0.5*(pixel*w{j}-muE{2*j-1})^2/varE{2*j-1}+log(varE{2*j-1});
        rate2=0.5*(pixel*w{j}-muE{2*j})^2/varE{2*j}+log(varE{2*j});
        if rate2<rate1
            falseE=falseE+1;
        end
    end
end
eE(4)=falseE/10;

% Person 5
imgE=dataTests{10}*fi;
falseE=0;
for i=1:10
    pixel=imgE(i,:);
    rate1=0.5*(pixel*w{4}-muE{7})^2/varE{7}+log(varE{7});
    rate2=0.5*(pixel*w{4}-muE{8})^2/varE{8}+log(varE{8});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{8}-muE{15})^2/varE{15}+log(varE{15});
    rate2=0.5*(pixel*w{8}-muE{16})^2/varE{16}+log(varE{16});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{11}-muE{21})^2/varE{21}+log(varE{21});
    rate2=0.5*(pixel*w{11}-muE{22})^2/varE{22}+log(varE{22});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{13}-muE{25})^2/varE{25}+log(varE{25});
    rate2=0.5*(pixel*w{13}-muE{26})^2/varE{26}+log(varE{26});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    for j=15:15
        rate1=0.5*(pixel*w{j}-muE{2*j-1})^2/varE{2*j-1}+log(varE{2*j-1});
        rate2=0.5*(pixel*w{j}-muE{2*j})^2/varE{2*j}+log(varE{2*j});
        if rate2<rate1
            falseE=falseE+1;
        end
    end
end
eE(5)=falseE/10;

% Person 6
imgE=dataTests{11}*fi;
falseE=0;
for i=1:10
    pixel=imgE(i,:);
    rate1=0.5*(pixel*w{5}-muE{9})^2/varE{9}+log(varE{9});
    rate2=0.5*(pixel*w{5}-muE{10})^2/varE{10}+log(varE{10});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{9}-muE{17})^2/varE{17}+log(varE{17});
    rate2=0.5*(pixel*w{9}-muE{18})^2/varE{18}+log(varE{18});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{12}-muE{23})^2/varE{23}+log(varE{23});
    rate2=0.5*(pixel*w{12}-muE{24})^2/varE{24}+log(varE{24});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{14}-muE{27})^2/varE{27}+log(varE{27});
    rate2=0.5*(pixel*w{14}-muE{28})^2/varE{28}+log(varE{28});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
    rate1=0.5*(pixel*w{15}-muE{29})^2/varE{29}+log(varE{29});
    rate2=0.5*(pixel*w{15}-muE{30})^2/varE{30}+log(varE{30});
    if rate1<rate2
        falseE=falseE+1;
        continue
    end
end
eE(6)=falseE/10;


