function [s] = adquisicion_RI(f1,f2,T,ns) % f1= Frecuencia 1; f2= Frecuencia 2; T= Tiempo en segundos; ns='nombre_de_tu_wav'
    if f1==f2
        msgbox ('frecuencias angulares son iguales interrumpiendo secuencia');    
    else
    % sine sweep:
    K=(T*f1*2*pi)/log(f2/f1); % generacion del sine sweep logaritmico 
    L=T/log(f2/f1); 
    t=0:1/44100:T; % vector de tiempo generado desde tiempo inicial cero con paso 1/frecuencia de sampleo
    x=sin(K*(exp(t/L)-1)); % funcion sinesweep original "x(t)"
    %   plot(t,x); title ('Sine sweep');xlabel('tiempo [s]');ylabel('Amplitud'); griwhyd on;
    %   audiowrite('sine_sweep1.wav',x,44100);
    r=audiorecorder(44100,16,1); %funcion para grabar audio con microfonos conectados a la computadora (frecuencia de sample, numero de bits por sample, canal de audio)
    record(r); 
    sound(x,44100); % reproduccion del sine sweep
    pause(T); % duracion de la grabacion, T=duracion del sine sweep
    stop(r); % detener la grabacion
    mySpeech = getaudiodata(r); %tomar la informacion de audio generada por la funcion getaudiodata y convertirlo en un datatype doble
    int2str(ns); %transforma ns de variable a string, 'int' integer, '2' two - a, 'str' string
    c=[ns,'.wav']; %esta linea agrega '.wav' a ns para especificar el formato de audio en la funcion audriowrite'
    audiowrite(c,mySpeech,44100); 
    % modulacion:
    m=(f1./((K/L)*exp(t/L)));
    % filtro invertido:
    h=flipr(t);
    s=sin(K*(exp(h/L)-1)); % funcion sinesweep para el filtro "x(-t)"
    k=m.*s; k=k/max(abs(k)); % normalizacion del sine sweep inverso
    % plot(t,k); title ('Sine sweep filtro');xlabel('tiempo (segundos)');ylabel('amplitud');
    % convolucion (sinesweep-filtroinverso):
    z=conv(k,mySpeech);% convolucion entre k y myspeech
    t2=0:1/88200:length(z)/88200-1/88200
    plot(t2,z); title ('convolucion'); xlabel('tiempo (segundos)');ylabel('amplitud');
    end
end