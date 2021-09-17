function [x , k] = sinesweep(f_min_ss,f_max_ss,T_ss)
%% SINESWEEP
%   Inputs:
%     f_min_ss = Frecuencia inicial del Sine-Sweep
%     f_max_ss = Frecuencia final del Sine-Sweep
%     T_ss = Tiempo de duración en segundos del Sine-Sweep
%   Outputs:
%     x = Vector de valores del Sine-Sweep
%     k = Vector de valores del filtro inverso
    fs=44100 ;
    t = 0:1/fs:T_ss - (1/fs) ; % Definición del intervalo de tiempo
    n_plot = 0:1/(T_ss):(fs - 1/(T_ss));
    K = (T_ss*2*pi*f_min_ss)/log(f_max_ss/f_min_ss) ; % Coeficientes del
    L = T_ss/log(f_max_ss/f_min_ss) ;                 % Sine-sweep
    x = sin(K.*( exp(t./L)-1)) ; % Sine-Sweep Logarítmico ;
    x = x/max(abs(x)) ; % Normalizado
    
    w = (K./L).*exp(t./L) ; % Coeficientes del
    m = (f_min_ss)./w ;     % filtro inverso
    k = m.*fliplr(x) ; % Filtro inverso
    k = k/max(abs(k)) ; % Normalizado
end