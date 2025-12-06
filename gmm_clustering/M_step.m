%update parameters

%pre-calc
sums_wj=sum(w,2);
u=w./sums_wj;%u(j,i) is Probability of x(i) given y(j)

%params-calc
a=sums_wj/datadim;
mu=u*data;
%using the identity of V[X]=E[X^2]-E[X]^2
sigma=u*(data.^2)-mu.^2;


