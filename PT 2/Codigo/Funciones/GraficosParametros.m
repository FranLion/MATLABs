function [plot_EDT,plot_T10,plot_T20,plot_T30,plot_schroeder] = GraficosParametros(banda)
global suavizadoporbanda
[EDT,T10,T20,T30] = calcular_parametros(suavizadoporbanda{banda}.z,suavizadoporbanda{banda}.t_plot_shroeder);
TituloBanda = string(round(suavizadoporbanda{banda}.band));
plot(suavizadoporbanda{banda}.t_plot,suavizadoporbanda{banda}.w);title(TituloBanda)
hold on
t = suavizadoporbanda{banda}.t_plot_shroeder;

hold on
global a_0 a_1
recta_EDT = a_0.EDT + a_1.EDT * t;
plot_EDT = plot(t,recta_EDT,'g','LineWidth',1.5);
recta_T10 = a_0.T10 + a_1.T10 * t;
plot_T10 = plot(t,recta_T10,'y','LineWidth',1.5);
recta_T20 = a_0.T20 + a_1.T20 * t;
plot_T20 = plot(t,recta_T20,'r','LineWidth',1.5);
recta_T30 = a_0.T30 + a_1.T30 * t;
plot_T30 = plot(t,recta_T30,'m','LineWidth',1.5);
% plot(suavizadoporbanda{banda}.t_plot,suavizadoporbanda{banda}.h_t_MAF,'LineWidth',1);
plot_schroeder = plot(t,suavizadoporbanda{banda}.z,'k','LineWidth',2);
legend('E(t)','EDT','T10','T20','T30','Schroeder')
ylim([-150 0]);
end