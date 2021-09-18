function [R] = sharp( A )
    x = A.alto;
    y = A.largo;
    e = A.espesor;
    p = A.densidad;
    E = A.young;
    o = A.poisson
    nint = A.perdidas;
    B = (E*(e^3))/(12*(1-(o^2)));
    m = p*e;
    fcritica = ((343^2)/(2*pi))*sqrt(m/B);
    fdensidad = (E/2*pi*1.18)*sqrt(m/B);
    btoct = [20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
    R = zeros(1,length(btoct));
    fperdidas = nint + m./(485.*sqrt(btoct));
    for i=1:length(btoct);
        if btoct(i)<(0.5*fcritica)
            R(i) = (10*log10(1+((1*pi*m*btoct(i))/(1.18*343))^2))-5.5;
        elseif btoct(i)>=fcritica
            R1 = 10*log10( 1 + ((1*pi*m*btoct(i))/(1.18*343))^2) + 10*log10((2*btoct(i)*fperdidas(i))/(1*pi*fcritica));
            R2 = 10*log10(1+((1*pi*m*btoct(i))/(1.18*343))^2) - 5.5;
            R(i) = min(R1,R2);
        else
            a = (10*log10(1+((1*pi*m*0.5*fcritica)/(1.18*343))^2))-5.5;
            b = nint + m./(485.*sqrt(fcritica));
            c = 10*log10( 1 + ((1*pi*m*fcritica)/(1.18*343))^2) + 10*log10((2*b*fcritica)/(1*pi*fcritica));
            d = 0.5*fcritica:fcritica;
            e = [a c];
            f = [0.5*fcritica fcritica];
            g = interp1(f,e,d);
            R(i) = g(btoct(i)-length(g));          
        end
    end
    clear R1 R2 x y e p E nint o a b c d e f g
   
    

    
            

end

