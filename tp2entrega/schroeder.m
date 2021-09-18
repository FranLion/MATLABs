function [s]=schroeder(f)

[m n]=size(f);

for i=1:n
    
    s(:,i)=flip(cumsum(flip(f(:,i))/sum(f(:,i))));

end

end