clear all
close all
load mnist_all.mat train1 train2

%params initialization
N1=size(train1,1);
N2=size(train2,1);
tau=0.0001/(N1+N2);
impr=1E-4;
xdim=size(train1,2);
sigmoid=@(z) 1/(1+exp(-z));

%w_0 initialization
w=ones(xdim,1)*1E-8;

%gradient ascent for finding w
oldscore=-inf;
iter=0;
CLOSE=false;
figure
hold
title("improvement process of score during iterations");
xlabel("iteration's number");
ylabel("score");
while ~CLOSE
    iter=iter+1;
    %call the step script
    LogRegStep_bin;
    %check the improvement
    if oldscore>score
        fprintf("the algorithm failed\n")
        return;
    end
    %stop when w_i close to w_i-1
    if score-oldscore<impr 
        CLOSE=true;
        fprintf("the algorithm is ended successfully\n\n")
    end
    %plot the improvement process of score
    plot([iter-1 iter],[oldscore score],'b'); 
    oldscore=score;
end

fprintf("now checking wheigths on the test data:\n")
LogRegTest_bin;
save LogReg_bin w sucsess_rate_1 sucsess_rate_2









