clear all
close all
load mnist_all.mat 
trains={train1, train2, train3,train4, train5,train6,train7,train8, train9,train0};

%params initialization
xdim=size(train0,2);
N=zeros(10,1);
for k=1:10
    N(k)=size(trains{k},1);
end
tau=1E-2/(sum(N));
impr=50;

%w_0 initialization
w=ones(xdim,k)*1E-8;

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
    LogRegStep_multi;
    %check the improvement
    if oldscore>score
        fprintf("the algorithm failed at iter %i\n",iter)
        return;
    end
    %stop when w_i close to w_i-1
    if (score-oldscore)<impr
        CLOSE=true;
        fprintf("the algorithm is ended successfully\n\n")
    end
    %plot the improvement process of score
    plot([iter-1 iter],[oldscore score],'b'); 
    oldscore=score;
end

fprintf("now checking wheigths on the test data:\n")
LogRegTest_multi;
save LogReg_multy w sucsess_rates






