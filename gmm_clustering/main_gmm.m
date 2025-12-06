clear all
close all
clc

load new_data.mat
k=numel(params.a);
lambda=0;

n_models=int8(2*k*log(k));
models=cell(1,n_models);
L=ones(1,n_models).*-inf;
for s=1:n_models
%perform algorithm for several initial values and take the maximum  L
models{s}=gmm_alg(data.pos,set_initial_centroids(data.pos,k),lambda,k);
L(s)=models{s}.Likelihood;
end

[~,winner]=max(L);
gmm_model=models{winner};
models=[];
close (1:winner-1);
close (winner+1:n_models);


%compare the results with the real classes

gmm_test(data,gmm_model);