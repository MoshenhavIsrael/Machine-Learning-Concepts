
tests={test1, test2, test3,test4, test5,test6,test7,test8, test9,test0};

%params initialization
xdim=size(test0,2);
sucsess_rates=zeros(10,1);
for k=1:10
    N=size(tests{k},1);
    exponents=exp(double(tests{k})*w);    
    probabilities=exponents./sum(exponents,2);
    %now check the num and rate of sucsessfull prediction
    [val,winners]=max(probabilities');
    sucsess=sum(winners==k);
    sucsess_rates(k)=sucsess/N;
end

sucsess_rates
