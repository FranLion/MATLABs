function [q] = plot_time(x,tiempo,Fs)
%% PLOT_TIME
% La función 'plot_time' plotea la señal entrante 'x' previamente 
% normalizada en función del tiempo.
%
%   Inputs:
%       x = Señal de entrada que se desea graficar
%       tiempo = Tiempo de duración en [s] de la señal
%       Fs = Frecuencia de muestreo de la señal
    t = 0:1/Fs:(tiempo - (1/Fs));
    x = x./max(x); % Normalizado
    plot(t,x);xlabel('Tiempo [s]');ylabel('Amplitud normalizada [mV]');grid on;ylim([-1 1]);
    %% Guardado del grafico 
    q = figure('visible','off');
    plot(t,x);xlabel('Tiempo [s]');ylabel('Amplitud normalizada [mV]');grid on;ylim([-1 1]); 
end