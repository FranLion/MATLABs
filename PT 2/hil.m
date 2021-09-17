function [h]=hil(r)  

% el parametro de entrada es la senial ya filtrada

[m,n]=size(r);

for i=1:n
   h(:,i)=abs(hilbert(r(:,i)));
   
end


end