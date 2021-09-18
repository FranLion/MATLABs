function [m, b]=cuadradosminimos(x,y)
n=length(y);
m=(n*sum(y.*x)-sum(x)*sum(y))/(n*sum(x.^2)-sum(x)^2);
b=(sum(y)-m*sum(x))/n;
end