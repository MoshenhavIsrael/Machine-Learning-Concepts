
load mnist_all.mat test1 test2


%remember for the digit 1 we choose y=0. therefor w*x<0
N1=size(test1,1);
sucsess_1=sum(double(test1)*w<0);
sucsess_rate_1=sucsess_1/N1

%for the digit 2 we choose y=2. therefor w*x>0
N2=size(test2,1);
b=ones(size(test2,1),1);

sucsess_2=sum(double(test2)*w>0);
sucsess_rate_2=sucsess_2/N2
