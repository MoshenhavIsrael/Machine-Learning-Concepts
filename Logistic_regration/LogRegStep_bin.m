

%create new score function and its dif'
score=0;
Dscore=zeros(size(w'));
%start with y=0
y=0;
probability_0=@(z) log(1-sigmoid(z))/(N1+N2);
for t=1:N1
    xt=double(train1(t,:));
    score=score+probability_0(xt*w);
    if score<-1E10
        fprintf("score very negative at y=0, t=%i",t)
    end
    Dscore=Dscore+(y-sigmoid(xt*w))*xt;
end

y=1;
probability_1=@(z) log(sigmoid(z))/(N1+N2);
for t=1:N2
    xt=double(train2(t,:));
    score=score+probability_1(xt*w);
    if score<-1E10
        fprintf("score very negative at y=1, t=%i",t)
    end
    Dscore=Dscore+(y-sigmoid(xt*w))*xt;
end
w=w+tau.*Dscore';
