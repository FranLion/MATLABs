function [h_t_filt,fcentrales] = filtbutterwav(h_t,div_oct,fc,Fs)
%% FILTRADO TIPO 'butterworth' DE h(t) EN (1/N)-BANDA DE OCTAVA  
%   Inputs:    
%       h_t = Se�al en formato .wav que se desea filtrar
%       div_oct = Division por octava
%       fc = Frecuencia central del filtro
%
% Referencia: Documentaci�n de MatLab 2017b (Windows 10)

if div_oct == 1
    orden = 6;
elseif div_oct == 3
    orden = 8;
end
f = fdesign.octave(div_oct,'Class 1','N,F0',orden,fc,Fs);
fcentrales = validfrequencies(f);

if div_oct == 3
    fcentrales = fcentrales(1:29);
end

numfcentrales = length(fcentrales);   
h_t_filt = zeros(length(h_t),numfcentrales); % Inicializaci�n de la matriz donde se
                                             % ubicara la se�al filtrada.

for i=1:numfcentrales
     f.F0 = fcentrales(i); % Crea un filtro dependiendo de la frecuencia central
     filtertype(i) = design(f,'butter'); % Generaci�n del filtro tipo 'butterworth'
     h_t_filt(:,i) = filter(filtertype(i),h_t); %Aplicaci�n del filtro a la se�al h_t
end

end


