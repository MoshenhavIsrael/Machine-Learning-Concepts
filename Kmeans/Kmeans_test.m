%calc the real centers and compare them with the predicted
tests={test1, test2, test3,test4, test5,test6,test7,test8, test9,test0};
real_centers=zeros(ydim,xdim);
prediction_idx=zeros(1,ydim);
for k=1:ydim
    real_centers(k,:)=mean(tests{k},1);
    errors=sqrt(sum((real_centers(k,:)-centers).^2,2));
    [min_err,idx]=min(errors);
    prediction_idx(k)=idx;
end

%check we have iid function from real to predicted
if sum(prediction_idx)~=sum(1:10)
    fprintf(" something wrong in your results\n")
    
else
    %now calc the sucsess rate
    sucsess_rates=zeros(ydim,1);
    for k=1:ydim
        N=size(tests{k},1);
        winners=zeros(N,1);
        for t=1:N
            distances=sqrt(sum((double(tests{k}(t,:))-centers).^2,2)); 
            [~,winners(t)]=min(distances);
            sucsess=sum(winners==prediction_idx(k));
            sucsess_rates(k)=sucsess/N;
        end
    end
    
    sucsess_rates
    total_sucsess_rate=mean(sucsess_rates)
end