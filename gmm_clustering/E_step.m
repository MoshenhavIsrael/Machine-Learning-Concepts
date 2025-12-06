%calc w - the probability of category given a specified data.

%a_j is the incidence of the y_j category
%the pr of x given category y is a gaussian
%f_bin is for 2D statically independent case
f_bin = @(x,mu,sigma) (2.*pi)^(-xdim/2).*det(diag(sigma))^(-0.5).*exp(-0.5.*(1/det(diag(sigma)).*(x-mu).*sigma(end:-1:1)*(x-mu)'));
%f_mult = @(x,mu,sigma) (2*pi)^(-xdim/2)*det(C)^(-0.5)*exp(-0.5*(x-mu)'*C^-1*(x-mu));

Pr_xy=zeros(k,datadim);
for j=1:k
    for i=1:datadim   
        %according to base law:
        Pr_xy(j,i)=f_bin(data(i,:),mu(j,:),sigma(j,:))*a(j);
    end
    %according to base law and complete probability eqn:
    w=Pr_xy./sum(Pr_xy,1);%w(j,i) is Probability of y(i) given x(j)
end






