function [ R ] = Davy(A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    l1 = A.alto;
    l2 = A.largo;
    t = A.espesor;
    p = A.densidad;
    E = A.young;
    nint = A.perdidas;
    o = A.poisson;
    po = 1.18 ; %Densidad del aire [Kg/m3]
    c0 = 343 ; %Velocidad sonido en el aire [m/s]
    averages = 3; % Promedio definido por Davy
    m = p*t; %Masa superficial [Kg/m2]
    filtro=[20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
    dB = 0.236 ;
    octave = 3;
    B = (E/(1-o^2)) * ((t^3)/12) ; % Rigidez a la flexión
    Fc = (c0^2/(2*pi))*(sqrt(m/B));
    for i=1:length(filtro)
        f = filtro(i) ;
        Ntot=nint + (m/(485*sqrt(f)));
        ratio = f/Fc;
        limit = 2^(1/(2*octave));
        if (ratio < 1 / limit) || (ratio > limit)
            TLost = Single_leaf_Davy(f,p,E,o,t,Ntot,l2,l1);
        else
            Avsingle_leaf = 0;
        
        
            for j = 1:averages
                factor = 2 ^ ((2*j-1-averages)/(2*averages*octave));
                aux=10^(-Single_leaf_Davy(f*factor,p,E,o,t,Ntot,l2,l1)/10);
                Avsingle_leaf = Avsingle_leaf + aux;
            end
            TLost = -10*log10(Avsingle_leaf/averages);
        end
        R(i)= TLost ;
    end
end

function [single_leaf] = Single_leaf_Davy(frequency, density, Young, Poisson, thickness,lossfactor, length, width)
%Definición de constantes:

    po = 1.18 ; %Densidad del aire [Kg/m3]
    c0 = 343 ; %Velocidad sonido [m/s]
    cos21Max = 0.9; %Ángulo limite definido en el trabajo de Davy
    surface_density = density * thickness;
    critical_frequency = sqrt(12 * density * (1 - Poisson ^ 2) / Young) * c0 ^ 2 / (2 * thickness *pi);
    normal = po * c0 / (pi * frequency * surface_density);
    normal2 = normal * normal;
    e = 2 * length * width / (length + width);
    cos2l = c0 / (2 * pi * frequency * e);
    if cos2l > cos21Max
        cos2l = cos21Max;
    end
    tau1 = normal2 * log((normal2 + 1) / (normal2 + cos2l));%Con logaritmo en base e (ln)
    ratio = frequency / critical_frequency;
    r = 1 - 1 / ratio;
    if r < 0
        r = 0;
    end
    G = sqrt(r);
    rad = Sigma(G, frequency, length, width);
    rad2 = rad * rad;
    netatotal = lossfactor + rad * normal;
    z = 2 / netatotal;
    y = atan(z) - atan(z * (1 - ratio));
    tau2 = normal2 * rad2 * y / (netatotal * 2 * ratio);
    tau2 = tau2 * shear(frequency, density, Young, Poisson, thickness);
    if frequency < critical_frequency
        tau = tau1 + tau2;
    else
        tau = tau2;
    end
    single_leaf = -10 * log10(tau); 
end

function [rad] = Sigma(G, freq, width, length)

%Definición de constantes:
    c0 = 343 ; %Velocidad sonido [m/s]
    w = 1.3;
    beta = 0.234;
    n = 2; 
    S = length * width;
    U = 2 * (length + width);
    twoa = 4 * S / U;
    k = 2 * pi * freq / c0;
    f = w * sqrt(pi / (k * twoa));
    if f > 1
        f = 1;
    end
    h = 1 / (sqrt(k * twoa / pi) * 2 / 3 - beta);
    q = 2 * pi / (k * k * S);
    qn = q ^ n;
    if G < f
        alpha = h / f - 1;
        xn = (h - alpha * G) ^ n;
    else
        xn = G ^ n;
    end
    rad = (xn + qn)^(-1 / n);
end

function [out] = shear(frequency, density, Young, Poisson, thickness)

    omega = 2 * pi * frequency;
    chi = (1 + Poisson) / (0.87 + 1.12 * Poisson);
    chi = chi * chi;
    X = thickness * thickness / 12;
    QP = Young / (1 - Poisson * Poisson);
    C = -omega * omega;
    B = C * (1 + 2 * chi / (1 - Poisson)) * X;
    A = X * QP / density;
    kbcor2 = (-B + sqrt(B * B - 4 * A * C)) / (2 * A);
    kb2 = sqrt(-C / A); 
    G = Young / (2 * (1 + Poisson));
    kT2 = -C * density * chi / G;
    kL2 = -C * density / QP;
    kS2 = kT2 + kL2;
    ASI = 1 + X * (kbcor2 * kT2 / kL2 - kT2);
    ASI = ASI * ASI;
    BSI = 1 - X * kT2 + kbcor2 * kS2 / (kb2 * kb2);
    CSI = sqrt(1 - X * kT2 + kS2 * kS2 / (4 * kb2 * kb2));
    out = ASI / (BSI * CSI);
end
