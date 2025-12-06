clear all
close all
load mnist_all.mat 
data=double([test1; test2; test3; test4; test5; test6; test7; test8; test9; test0]);

%set params & variables
xdim=size(data,2);
ydim=10;
N=size(data,1);

%set the initial centers by permutation on the data
midgam=data(1:10:end,:);
centers=zeros(ydim,xdim);
for k=1:10
    centers(k,:)=diag(midgam(randperm(size(midgam,1)),:),1-k)';
end
midgam=[];

%start the iterative algorithm
figure
hold
title("improvement process of score during iterations");
xlabel("iteration's number");
ylabel("score");

%each step improve clustering by finding better centers
%we will stop when there is no way to find better centers
iter=0;
CONST_CENTERS=false;
oldcost=inf;
while ~CONST_CENTERS
    iter=iter+1;
    %call the step script
    Kmeans_step;
    %check the improvement
    if oldcost<cost
        fprintf("oldcost<cost at iter %i\n",iter)
    end
    %plot the improvement process of score
    plot([iter-1 iter],[oldcost cost],'b'); 
    %stop when there is no way to find better centers
    if (cost-oldcost)==0 || iter>=300
        CONST_CENTERS=true;
        fprintf("the algorithm is ended successfully\n\n")
    end
    oldcost=cost; 
end

data=[];

Kmeans_test;
