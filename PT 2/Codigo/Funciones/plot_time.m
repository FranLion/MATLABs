function [q] = plot_time(x,tiempo,Fs)
%% PLOT_TIME
% La funci�n 'plot_time' plotea la se�al entrante 'x' previamente 
% normalizada en funci�n del tiempo.
%
%   Inputs:
%       x = Se�al de entrada que se desea graficar
%       tiempo = Tiempo de duraci�n en [s] de la se�al
%       Fs = Frecuencia de muestreo de la se�al
    t = 0:1/Fs:(tiempo - (1/Fs));
    x = x./max(x); % Normalizado
    plot(t,x);xlabel('Tiempo [s]');ylabel('Amplitud normalizada [mV]');grid on;ylim([-1 1]);
    %% Guardado del grafico 
    q = figure('visible','off');
    plot(t,x);xlabel('Tiempo [s]');ylabel('Amplitud normalizada [mV]');grid on;ylim([-1 1]); 
end