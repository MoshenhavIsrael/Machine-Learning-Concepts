function model=gmm_alg(data,initial_centroids,lambda,k)

%set parameters
xdim=size(data,2);
datadim=size(data,1);
classes=cell(k,1);

%initial class dist is being set by uniform dist and initial sigma according to data
a=ones(k,1)./k;
mu=initial_centroids;
sigma=zeros(k,xdim);
for j=1:k
    sigma(j,:)=(diag(cov(data)));
end

%perform iterative algorithm
fig=figure;
hold;
title("improvement process of score during iterations");
xlabel("iteration's number");
ylabel("score");

%each step improve clustering by finding better parameters
%we will stop when there is no way to find better centers
iter=0;
STOP_RULE=false;
old_L=-inf;
tolerance=0.0005;
while ~STOP_RULE
    iter=iter+1;
    %call the step scripts
    E_step;
    M_step;
    %calc likelihood function
    L=sum(log((sum(Pr_xy,1))))-lambda*sum(sum(sigma.^2));
    %stop when there is no way to find better parameters
    if abs((L-old_L)/L)<=tolerance
        STOP_RULE=true;
        fprintf("the algorithm is ended successfully\n\n")
        %divide into classes
        [~,hard_choice]=max(w);
        for i=1:datadim
            classes{hard_choice(i)}=[classes{hard_choice(i)}; data(i,:)];
        end 
    end
    %check the improvement
    if old_L>L
        fprintf("old_L>L at iter %i\n",iter)
    end
    %plot the improvement process of score
    plot([iter-1 iter],[old_L L],'b'); 
    old_L=L; 
end

model=struct;
model.class=classes;
model.labels=hard_choice;
model.a=a;
model.mu=mu;
model.sigma=sigma;
model.Likelihood=L;
model.iterations_figure=fig;

end