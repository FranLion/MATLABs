function [y_fourier,y_t,t,tn,porcentaje_gibbs,ECM] = aprox_por_fourier(choise,n_terms,f,A)
%% SIGNAL y COEFICIENTES DE FOURIER
T = 1/f; 
ext_inf = -T/2;
ext_sup = T/2;
Fs = 44100;
t = -(3/2)*T:1/Fs:(3/2)*T-(1/Fs);

syms n

if choise == 0 % Tren de pulsos
    y_t_single = [ 0 0 1 1];
    y_t = [y_t_single , y_t_single , y_t_single]; %Se repite 3 periodos
    y_t = A*y_t;
    tn = [-3*T/2 -T -T -T/2 -T/2 0 0 T/2 T/2 T T 3*T/2]; 
    % 'y' para el error cuadradito medio
    for k=1:T*Fs
        if k <= (T/2)*Fs
            y_ecm(k)=0;
        elseif k > (T/2)*Fs
            y_ecm(k)=A*1;
        end
    end
    % Coeficientes de Fourier
    a_0 = (A*1);
    a_n(n) = sym((0));
    b_n(n) = sym(-A*(((-1)^(n)-1)/(n*pi)));
elseif choise == 1 % Diente de sierra
    y_t_single = [-1 1];
    y_t = [ y_t_single , y_t_single , y_t_single]; %Se repite 3 periodos
    y_t = A*y_t;
    tn = [-3*T/2 -T/2 -T/2 T/2 T/2 3*T/2];
    
    % 'y' para el error cuadradito medio
    for k=1:T*Fs
        y_ecm(k) = A*k/((T/2)*Fs) - A;
    end
    
    % Coeficientes de Fourier
    a_0 = (0);
    a_n(n) = sym((0));
    b_n(n) = sym((-2*((-1)^(n))*A)/(pi*n));
elseif choise == 2 % Triangular
    y_t_single = [0 1];
    y_t = [ y_t_single , y_t_single , y_t_single 0]; %Se repite 3 periodos
    y_t = A*y_t;
    tn = [ -3*T/2 -T -T/2 0 T/2 T 3*T/2];
    % 'y' para el error cuadradito medio
    for k=1:T*Fs
        if k <= (T/2)*Fs
            y_ecm(k)= A*k/((T/2)*Fs) ;
        elseif k > (T/2)*Fs
            y_ecm(k)= -A*k/((T/2)*Fs) + 2*A;
        end
    end
    % Coeficientes de Fourier
    a_0 = (A);
    a_n(n) = sym((4*A)/(((2*n-1)*pi)^2));
    b_n(n) = sym((0));
end

%% POLINOMIO DE FOURIER
y_fourier = (a_0/2)*ones(1,length(t));
for i = 1:n_terms
    if choise == 2 
        ene = 2*i-1;
    else
        ene = i;
    end
    y_fourier = y_fourier + double(a_n(ene))*cos(((2*ene*pi)/T).*t) + double(b_n(ene))*sin(((2*ene*pi)/T).*t);
end


porcentaje_gibbs = (2*abs(max(y_fourier) - max(y_t))/(max(y_t) - min(y_t))*100);


ECM = 0;
for j = 1:T*Fs-1
    ECM = ECM + ((y_ecm(j)-y_fourier(j))^2)/(T*Fs-1);
end

ECM = ECM/A;

end