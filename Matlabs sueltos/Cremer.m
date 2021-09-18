function [R] = Cremer(A)
    e = A.espesor;
    p = A.densidad;
    E = A.young;
    nint = A.perdidas;
    o = A.poisson;
    B = (E*(e^3))/(12*(1-(o^2)));
    m = p*e;
    fcritica = ((343^2)/(2*pi))*sqrt(m/B);
    fdensidad = ((E)/(2*pi*p))*(sqrt(m/B));
    btoct = [20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
    R = zeros(1,length(btoct));
    fperdidas = nint + m./(485.*sqrt(btoct));
    for i=1:length(btoct);
        if btoct(i)<(fcritica)
            R(i) = 20*log10(m*btoct(i))-47;
        elseif btoct(i)>fdensidad
            R(i) = 20*log10(m*btoct(i))-47;
        else
            R(i) = (20*log10(m*btoct(i)))-(10*log10(1*pi/(4*fperdidas(i))))-(10*log10(fcritica/(btoct(i)-fcritica)))-47;         
        end
    end
    clear e p E nint o
end

