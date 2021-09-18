function s = plotfft(f1,f2,T) % f1= Frecuencia 1; f2= Frecuencia 2; T= Tiempo en segundos;
if f1==f2
    msgbox ('frecuencias angulares iguales, error en el barrido');
else
    
    Fs = 44100;            % Sampling frequency
    Ti = 1/Fs;             % Sampling period
    L = Fs*T;             % Length of signal
    ti = (0:L-1)*Ti;        % Time vector
    f = Fs*(0:(L/2))/L;
    
    % sine sweep:
    
    K=(T*f1*2*pi)/log(f2/f1); % generacion del sine sweep logaritmico
    Li=T/log(f2/f1);
    t=0:1/44100:T; % vector de tiempo generado desde tiempo inicial cero con paso 1/frecuencia de sampleo
    x=sin(K*(exp(t/Li)-1)); % funcion sinesweep original "x(t)"
    
%     plot(t,x); title ('Sine-sweep');xlabel('tiempo [s]');ylabel('Amplitud'); grid on;
%     sound(x,44100); %reproduccion del sine sweep
%     audiowrite('sine_sweep.wav',x,44100);
    
    Y = fft(x);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    P1=20*log10(P1/(max(abs(P1))));
    semilogx(f,P1); grid on; title ('Sine sweep'); xlabel ('frecuencia [Hz]'); ylabel ('Amplitud [dB]');
    
end
end