function gmm_test(real_data,clustered_model)
%before comparing: sort parameters. 
[a,idx]=sort(clustered_model.a,"ascend");
mu=clustered_model.mu(idx,:);
sigma=clustered_model.sigma(idx,:);
datadim=size(real_data.pos,1);
xdim=size(real_data.pos,2);
k=numel(a);

%first - present data
if xdim==2
colors=['r','b','k'];
opts=['.','*','^'];
figure
subplot(1,2,1);
hold;
title("present real data points")
j=1;
for i=1:k
    first=j;
    last=j+datadim*real_data.a(i)-1;
        plot(real_data.pos(first:last,1),real_data.pos(first:last,2),sprintf("%c%c",colors(i),opts(i)));
    j=last+1;
end

subplot(1,2,2);
hold
title("present predicted data points")
for j=1:k
    if ~isempty(clustered_model.class{j})
        plot(clustered_model.class{idx(j)}(:,1),clustered_model.class{idx(j)}(:,2),sprintf("%c%c",colors(j),opts(j)));
    end
end
end


%second - compare parameters
fprintf("real parameters against predicted parameters\n\n");
fprintf("a:\n");
for i=1:k
    fprintf("%d\t%.2d\n",real_data.a(i),a(i));
end
for i=1:xdim
    fprintf("mu(%i):\n",i);
    for j=1:k
    fprintf("%.2d\t\t%.2d\n",real_data.mu(j,i),mu(j,i));
    end 
end
for i=1:xdim
    fprintf("sigma(%i):\n",i);
    for j=1:k
    fprintf("%.2d\t\t%.2d\n",real_data.sigma(j,i).^2,sigma(j,i));
    end 
end


%3rd - perform some exams from information theorem
%NMI - normalaized mutual information
mutual_pr=zeros(k);
for i=1:k
    for j=1:k
        mutual_pr(i,j)=sum((real_data.labels'==i).*(clustered_model.labels==j));
    end
end
mutual_pr=mutual_pr./datadim;
NMI=NMI_calc(mutual_pr);
fprintf("The NMI is %.2d\n\n",NMI);

end