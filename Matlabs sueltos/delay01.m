% uiopen('C:\Users\frank\Desktop\UNTREF\Señales y sistemas\SEÑALES Y SISTEMAS UNTREF\Matlab\2° Clase [OK]\Live-Script\vocal.wav',1)
% t = 0:seconds(1/fs):seconds(info.Duration);
% t = t(1:end-1);
% z=data;
% % z=z.*(0.04);
% y=data+(0.5).*(data-z);
% plot(t,y);
% %sound (y);
% subplot (1,2,1)
% plot(t,y);
% subplot (1,2,2)
% plot(t,data);
% load ('vocal,wav');

% SIN DELAY

% [y, fs] = audioread('vocal.wav');
% 
% info = audioinfo('vocal.wav');
% 
% duracion = seconds(numel(y)/fs);
% 
% t = 0:seconds(1/fs):seconds(info.Duration);
% 
% t = t(1:end-1);
% 
% plot(t,y);
% 
% grid on;
% 
% xlabel('Tiempo');
% 
% ylabel('Señal de audio');
% 
% sound(y,fs);

% DELAY

[y, fs] = audioread('vocal.wav');

info = audioinfo('vocal.wav');

duracion = seconds(numel(y)/fs);
 
t= [0:1/fs:info.Duration-1/fs];

y=y';

delay = [zeros(1,length(y)/4),y];

t= [t,zeros(1,length(y)/4)];

plot(t,delay);

grid on;

xlabel('Tiempo');

ylabel('Señal de audio');


% sound(y,fs);




