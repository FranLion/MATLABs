function [h] = irwav(y_t)
%% IRWAV (Impulse Response .wav) 
%   Inputs:
%     y_t = La respuesta del sistema a una exitación impulsiva
%
% Nota: La señal 'y_t' debe ser cargada en formato .wav
%    Por ejemplo:
%           irwav('nombre_del_audio.wav')
[y,Fs] = audioread(y_t); % Procesamiento del audio como vector de valores
t_audio = numel(y)/Fs ; % Duración del audio
filtroinversopath = [pwd '\Pinknoise, Sine-sweep y Filtro inverso\filtroinverso.wav'];
k = audioread(filtroinversopath) ;% Se carga el filtro inverso
k = [zeros(1,(length(y)-length(k))/2) k' zeros(1,(length(y)-length(k))/2)] ; % Se rellena el filtro inverso para que las dimensiones

% FFT's
Y = fft(y);
K = fft(k');

% Generación del h(t)
H = Y.*K;
h = ifft(H) ;
h = (h/max(abs(h)));

end