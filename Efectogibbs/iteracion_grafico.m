function iteracion_grafico(n_iteraciones,paso,choise,f,A)
T = 1/f;
for i = 1:n_iteraciones
    clf
    [y_fourier,y_t,t,porcentaje_gibbs] = aprox_por_fourier(choise,i,f,A);
    plot(t,y_t,t,y_fourier); titulo = char(['N = ' string(i)]);
    title(titulo);grid on
    xlim([(-3/2)*T (3/2)*T]);
    ylim([-1.5*A 1.5*A]);
    pause(paso)
end
