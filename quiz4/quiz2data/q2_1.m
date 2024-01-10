%%
digits=1:10;
n_digits=10;
bestcv = 0;
for log2c = -1:1
    for log2g = -4:-2
        cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(yTrain, xTrain, cmd);
        if (cv >= bestcv)
            bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
        end
    end
end

%%
results2 = zeros(n_digits,8);  
margins2 = zeros(n_digits,size_train);
g2 = zeros(n_digits,size_test);
    
for digit = digits

    if digit~=10
        yTrainBin = ones(size(yTrain));
        yTrainBin(yTrain ~= digit) = -1;
        yTestBin = ones(size(yTest));
        yTestBin(yTest ~= digit) = -1;
    else
        yTrainBin = ones(size(yTrain));
        yTrainBin(yTrain ~= 0) = -1;
        yTestBin = ones(size(yTest));
        yTestBin(yTest ~= 0) = -1;
    end

    model_radial = svmtrain(yTrainBin, xTrain, sprintf('-c %g -g %g',bestc,bestg));

    [predict_label_L, accuracy_L, d_vals] = svmpredict(yTestBin, xTest, model_radial);

    results2(digit,1) = 100 - accuracy_L(1);  
    results2(digit,2) = sum(model_radial.nSV);  
    [~,max_ind] = maxk(model_radial.sv_coef,3);  
    results2(digit,3:5) = model_radial.sv_indices(max_ind);
    [~,min_ind] = mink(model_radial.sv_coef,3);  
    results2(digit,6:8) = model_radial.sv_indices(min_ind);

    w2 = model_radial.SVs' * model_radial.sv_coef;
    b2 = -model_radial.rho;
    if model_radial.Label(1) == -1
      w2 = -w2;
      b2 = -b2;
    end
    
    margins2(digit,:) = yTrainBin .* (xTrain*w2 + b2);

    g2(digit,:) = xTest*w2 + b2;

end

[~,digit_pred] = max(g2);
digit_pred(digit_pred==10) = 0;
final_test_error = sum(digit_pred' ~= yTest) / size_test;



%% Plot

figure
for digit=digits
    for i=3:8
        subplot(10,6,6*(digit-1)+i-2)
        colormap(gray(255));
        sample_ind = results2(digit,i);
        imagesc( reshape( xTrain(sample_ind,:), 28, 28)' );
    end       
end

%% CDF

figure
for digit=digits
    
    subplot(2,5,digit)
    
    cdfplot(margins2(digit,:));

    if digit ~= 10
        title(sprintf('digit %i',digit))
    else
        title(sprintf('digit %i',0))
    end
    xlabel('x')
    ylabel('P(margin <= X)')
    
end