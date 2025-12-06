
%set variables
sum_and_count=zeros(10,xdim+1); %the last column will be counter vector
cost=0;
%set classes + calc the new centers and cost
for t=1:N
    distances=sqrt(sum((data(t,:)-centers).^2,2)); 
    [min_distance,winner]=min(distances);
    sum_and_count(winner,:)=sum_and_count(winner,:)+[data(t,:) 1];
    cost=cost+min_distance;
end

mean_class=sum_and_count./sum_and_count(:,end);
centers=mean_class(:,1:end-1);


