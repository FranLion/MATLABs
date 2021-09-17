function [s] = sine_sweepPlot(f1,f2,T) % f1= Frecuencia 1; f2= Frecuencia 2; T= Tiempo en segundos;
    if f1==f2
        msgbox ('frecuencias angulares iguales, error en el barrido');    
    else
    % sine sweep:
    K=(T*f1*2*pi)/log(f2/f1); % generacion del sine sweep logaritmico 
    L=T/log(f2/f1); 
    t=0:1/44100:T; % vector de tiempo generado desde tiempo inicial cero con paso 1/frecuencia de sampleo
    x=sin(K*(exp(t/L)-1)); % funcion sinesweep original "x(t)"
    plot(t,x); title ('Sine-sweep');xlabel('tiempo [s]');ylabel('Amplitud'); grid on;
    end
end