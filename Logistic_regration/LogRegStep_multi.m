
%create new score function and its dif'
score=0;
Dscore=zeros(size(w));
%create exps for the sigmoid function
%probability_0=@(z) log(1-sigmoid(z))/(N1+N2);
for k=1:10
    exponents=exp(double(trains{k})*w);
    %calculate probability by sigmoid function
    sigmoids=exponents./sum(exponents,2);
    %the score/likelihood is sum of the probabilities' logs 
    %(we took just the k column because of the indicator in the eq)
    score=score+sum(log(sigmoids(:,k)));
    if score<-1E10
        fprintf("score very negative at k=%i",k)
    end
    %calc the derive in 2 parts
    for i=1:10
        Dscore(:,i)=Dscore(:,i)-double(trains{k}')*sigmoids(:,i)/N(k);
    end
    Dscore(:,k)=Dscore(:,k)+sum(trains{k},1)'./N(k);
end
%update w according to gradient ascent
w=w+tau.*Dscore;
