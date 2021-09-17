function [EDT,T10,T20,T30] = calcular_parametros(h_t_suavizada,t_plot_shroeder)
%   Inputs:
%       h_t_suavizada = Vector de valores de la señal suavizada
%   Outputs:
%       EDT = Early Decay Time en [s]
%       T20 = Tiempo de 
global a_0 a_1;
x_i = t_plot_shroeder;
y_i = h_t_suavizada;
%% EDT
x1_EDT = find(y_i < max(y_i),1,'first');
x2_EDT = find(y_i < (max(y_i)-10),1,'first');
y_i_EDT = (y_i(x1_EDT:x2_EDT));
x_i_EDT = (x_i(x1_EDT:x2_EDT));
[a_0.EDT,a_1.EDT] = cuad_min(x_i_EDT,y_i_EDT);
EDT = (-60)/a_1.EDT;
%% T10
x1_T10 = find(y_i < (max(y_i)-5),1,'first');
x2_T10 = find(y_i < (max(y_i)-15),1,'first');
x_i_T10 = (x_i(x1_T10:x2_T10));
y_i_T10 = (y_i(x1_T10:x2_T10));
[a_0.T10,a_1.T10] = cuad_min(x_i_T10,y_i_T10);
T10 = (-60)/a_1.T10;
%% T20
x1_T20 = find(y_i < (max(y_i)-5),1,'first');
x2_T20 = find(y_i < (max(y_i)-25),1,'first');
x_i_T20 = (x_i(x1_T20:x2_T20));
y_i_T20 = (y_i(x1_T20:x2_T20));
[a_0.T20,a_1.T20] = cuad_min(x_i_T20,y_i_T20);
T20 = (-60)/a_1.T20;
%% T30
x1_T30 = find(y_i < (max(y_i)-5),1,'first');
x2_T30 = find(y_i < (max(y_i)-35),1,'first');
x_i_T30 = (x_i(x1_T30:x2_T30));
y_i_T30 = (y_i(x1_T30:x2_T30));
[a_0.T30,a_1.T30] = cuad_min(x_i_T30,y_i_T30);
T30 = (-60)/a_1.T30;
end