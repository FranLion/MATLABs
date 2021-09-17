function [s]=schroeder(h)

[m n]=size(h);

for i=1:n
    s(:,i)=flip(cumsum(flip(h(:,i))/sum(h(:,i))));
end

end