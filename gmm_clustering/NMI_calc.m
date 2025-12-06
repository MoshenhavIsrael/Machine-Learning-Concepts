function NMI=NMI_calc(mutual_dist)
xdim=size(mutual_dist,1);
ydim=size(mutual_dist,2);
x_dist=sum(mutual_dist,2);
y_dist=sum(mutual_dist,1);
x_entropy=-(x_dist.*log2(x_dist));
y_entropy=-(y_dist.*log2(y_dist));
MI=mutual_dist.*log2(mutual_dist./(x_dist*y_dist));
for i=1:xdim
    if isnan(x_entropy(i))
        x_entropy(i)=0;
    end
    for j=1:ydim
        if isnan(MI(i,j))
            MI(i,j)=0;
        end
    end
end
for i=1:ydim
    if isnan(y_entropy(i))
        y_entropy(i)=0;
    end
end
x_entropy=sum(x_entropy);
y_entropy=sum(y_entropy);
MI=sum(MI,'all');
NMI=MI/mean([y_entropy,x_entropy]);

end