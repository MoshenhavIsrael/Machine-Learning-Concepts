function centroids=set_initial_centroids(data,k)
%rows - samples. cols- fetures
%N=size(data,1)
d=size(data,2);

%set the initial centers by permutation on the data
centroids=zeros(k,d);
for i=1:k
    centroids(i,:)=diag(data(randperm(size(data,1)),:))';
end

end