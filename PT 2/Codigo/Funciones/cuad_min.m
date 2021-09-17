function [a_0 , a_1] = cuad_min(t_plot_shroeder,shroeder)
x_i = t_plot_shroeder ;
y_i = shroeder;

if size(x_i) ~= size(y_i)
    y_i = y_i';
end

A = ones(length(x_i),2) ;
A (:,2) = (x_i)';
B = (y_i)' ;
vector = ((inv((A')*A)*(A'))*B)' ;
a_0 = vector(1);
a_1 = vector(2);

end