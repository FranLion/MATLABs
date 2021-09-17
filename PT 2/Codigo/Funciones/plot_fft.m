function [h] = plot_fft (x,tiempo,Fs)
%% PLOT_FFT
   %La funcion 'plot_fft' plotea la señal entrante 'x' normalizada en
   %funcion de la frecuencia.
%  Inputs:
%       x = Señal de entrada que se desea graficar
%       tiempo = Tiempo de duración en [s] de la señal
%       Fs = Frecuencia de muestreo de la señal
    n = tiempo*Fs;
    P = fft(x);                      
    P1 = abs(P/n);                      % Se calcula el espectro de dos lados de P1.
    P2 = P1(1:n/2+1);                   % Luego se calcula el espectro en una sola cara de P2
    P2(2:end-1) = 2*P2(2:end-1);        % y la longitud de señal de valor para n.
    P2 = P2/abs(max(P2));               
    f = Fs*(0:(n/2))./n;                % se define el dominio de frecuencia.
    P2 = 20*log10(P2);                  
    semilogx(f,P2);xlabel('Frecuencia [Hz]');ylabel('Amplitud normalizada [dB]');
    ylim([-120 0]);xlim([1 25000]); grid on;
    %% Guardado del grafico 
    h = figure('visible','off');
    semilogx(f,P2);xlabel('Frecuencia [Hz]');ylabel('Amplitud normalizada [dB]');
    ylim([-120 0]);xlim([1 25000]); grid on;
end
