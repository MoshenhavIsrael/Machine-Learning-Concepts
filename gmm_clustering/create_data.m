%define the parameters
params=struct;
%probability of the k classes
k=3;
params.a=[0.2,0.3,0.5]';
%k vectors of expectations
params.mu=[1,5.9;-3.0,2;1.3,-4.8].*[1.5 1]+[20,20];
%k covarians matrices
params.cov=zeros(2,2,3);
params.cov(:,:,1)=[4,0;0,8];
params.cov(:,:,2)=[2.5,0;0,7];
params.cov(:,:,3)=[9,0;0,3];
params.sigma=zeros(size(params.mu));

%create the data by params
data=struct;
N=1000;
data.labels=zeros(N,1);
data.pos=zeros(N,2);
%preparing graph options
if size(data.pos,2)==2
    colors=['r','b','k'];
    opts=['.','*','^'];
    figure
    hold
    title("present data points")
end
j=1;
for i=1:k
    first=j;
    last=j+N*params.a(i)-1;
    data.labels(first:last,1)=i;
    params.sigma(i,:)=sqrt(diag(params.cov(:,:,i)));
    data.pos(first:last,:)=randn(N*params.a(i),2).*params.sigma(i,:)+params.mu(i,:);
    j=last+1;
    if size(data.pos,2)==2
        plot(data.pos(first:last,1),data.pos(first:last,2),sprintf("%c%c",colors(i),opts(i)));
    end
end

data.a=params.a;
data.mu=params.mu;
data.sigma=params.sigma;

save new_data data params
