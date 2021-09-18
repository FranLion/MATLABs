function [ R ] = ISO( A )
    l1= A.alto;
    l2 = A.largo;
    t = A.espesor;
    p = A.densidad;
    E = A.young;
    nint = A.perdidas;
    o = A.poisson;
    c0 = 343;
    btoct = [20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
    cl = sqrt(E/p);
    mp = p*t;
    B = (E*(t^3))/(12*(1-(o^2)));
    fc = (c0^2/(2*pi))*(sqrt(mp/B));
    sigma1 = 1./sqrt(1-(fc./btoct));
    sigma2 = 4*l1*l2.*(btoct./c0).^2;
    sigma3 = sqrt((2*pi*btoct.*(l1+l2))./(16*c0));
    f11 = ((c0^2)/(4*fc))*((1/l2^2)+(1/l1^2));
    fperdidas = nint + mp./(485.*sqrt(btoct));
    D =  sqrt(btoct./fc);
    k0 = (2*pi.*btoct)./c0;
    A= -0.964-(0.5+l2/(pi*l1))*log(l2/l1)+(5*l2)/(2*pi*l1)-1./(4*pi*l1*l2.*(k0.^2));
    R = zeros(1,length(btoct));
    for i=1:length(btoct)
        d1 = ((1-D(i)^2)*log((1+D(i))/(1-D(i)))+2*D(i))/(4*(pi^2)*((1-D(i)^2)^1.5));
        if f11<=fc/2
            if btoct(i)>=fc
                sigma = sigma1(i);
            else
                if btoct(i)>(fc/2)
                    d2 = 0;
                else
                    d2 = (8*c0*(1-2*D(i)^2))/((fc^2)*(pi^4)*l1*l2*D(i)*sqrt(1-(D(i)^2)));
                end
                sigma = ((2*(l1+l2)*c0)/(l1*l2*fc))*d1 + d2;
                if f11>btoct(i) && f11<(fc/2) && sigma>sigma2(i)
                    sigma = sigma2(i);
                end    
            end
        else
            if  btoct(i)<fc && sigma2(i)<sigma3(i)
               sigma = sigma2(i);
            elseif btoct(i)>fc && sigma1(i)<sigma3(i)
                sigma = sigma1(i);
            else
                sigma = sigma3(i);
            end
        end
        if sigma >2
            sigma = 2;
        end
        sigmaf = 0.5*(log(k0(i)*sqrt(l1*l2))-A(i));
        if sigmaf >2;
            sigmaf = 2;
        end
        if btoct(i)>1.05*fc
            tao = ((2*1.18*c0/(2*pi*btoct(i)*mp))^2)*(pi*fc*sigma^2)/(2*btoct(i)*fperdidas(i));
        elseif btoct(i)<=1.05*fc && btoct(i)>=0.95*fc
            tao=((2*1.18*c0/(2*pi*btoct(i)*mp))^2)*(pi*sigma^2)/(2*fperdidas(i));
        else
            tao=((2*1.18*c0/(2*pi*btoct(i)*mp))^2)*(2*sigmaf+((l1+l2)^2)/(l1^2+l2^2)*sqrt(fc/btoct(i))*(sigma^2)/fperdidas(i));
        end    
        R(i) = -10*log10(tao);                
    end

