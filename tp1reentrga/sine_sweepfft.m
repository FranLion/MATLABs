function sine_sweepfft(f1,f2,T,ns) % f1= Frecuencia 1; f2= Frecuencia 2; T= Tiempo en segundos; ns= nombre de archivo; fi = filtro inverso si o no

try
    
    deviceReader = audioDeviceReader;
    
    dispositivos = getAudioDevices(deviceReader);
    
    deviceReader = audioDeviceReader;
    
    deviceReader.SamplesPerFrame = 1024;
    
    deviceReader.SampleRate = 44100;
    
    setup(deviceReader) ;% Función de MATLAB para autoconfigurar objetos y dismunir la carga computacional
    
catch
    
    errordlg('error en la configuracion de dispositivos')
    
end

try
    
    % sine sweep:
    
    int2str(ns);
    
    c=[ns,'.wav'];
    
    d=[ns,'FI.wav'];
    
    K=(T*f1*2*pi)/log(f2/f1); % generacion del sine sweep logaritmico
    
    L=T/log(f2/f1);
    
    t=0:1/44100:T; % vector de tiempo generado desde tiempo inicial cero con paso 1/frecuencia de sampleo
    
    x=sin(K*(exp(t/L)-1));
    
    %Filtro inverso;
    
    x=sin(K*(exp(t/L)-1));
    w = (K/L)*exp(t/L);
    m = f1./(2*pi*w);
    h = m.*fliplr(x);
    h = 0.9.*(h/abs(max(h)));
    
    %   f = 44100*(0:((44100*T)/2))/(44100*T);
    %   L1=44100*T; %largo de la señal
    
    plot(t,x); title ('Sine-sweep');xlabel('tiempo [s]');ylabel('Amplitud'); grid on;
    
catch
    
    errordlg('argumentos de entrada invalidos')
    
end

% plot(t,x); title ('Sine-sweep');xlabel('tiempo [s]');ylabel('Amplitud'); grid on;

try
    
    fileWriter = dsp.AudioFileWriter(c); tic ; sound(x,44100); %reproduccion del sine sweep
    
    T= T+1; % aca se agrega 1 segundo antes de la grabacion, solicitado por el profesor en la primera entrega
    
    while toc < T+15 % Bucle de frame
        
        audioFromDevice = deviceReader();
        
        fileWriter(audioFromDevice);
        
        audiowrite(d,h,44100);
        
    end
    


release(deviceReader)

release(fileWriter)

catch
    
    errordlg('error en la grabacion')

end

end