[y,Fs] = audioread('IR_Toma_n1_e.wav');
t_audio = numel(y)/Fs ; % Duración del audio
t_plot = 0:1/Fs:t_audio-1/Fs;

A_t = abs(hilbert(y));
A_t = A_t/max(abs(A_t));
E_t = 20*log10(A_t/max(A_t));
L(td:-1:1)=(cumsum(hA(td:-1:1))/sum(hA(1:td)));
subplot(2,1,1)
plot(t_plot,E_t);xlabel('Tiempo [s]');ylabel('SPL [dB]');
subplot(2,1,2)
plot(t_plot,A_t);xlabel('Tiempo [s]');ylabel('Amplitud [mV]');

