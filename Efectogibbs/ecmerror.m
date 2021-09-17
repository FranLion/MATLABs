function [ECM,Gibbsp,m]=ecmerror(s,a,f,e)

Fs=44100;
T=1/f;
dt=1/Fs;
t=-T:dt:T-dt;
n=100000;

if s==1   %tren de pulso
    t1=[0:dt:T/2-dt];
    t2=[T/2:dt:T-dt];
    t=[t1 t2];
    y1=zeros(1,length(t1));
    y2=ones(1,length(t2));
    y=[y1 y2];
    y3=[y y];
    y3=a*y3;
    a0=a;
    for m=1:n
        bn=(-a/(pi*m))+(a/(pi*m))*((-1)^m);
        fourie(m,:)=bn*sin(2*pi*f*m.*t);
        poli=(a0/2)+sum(fourie,1);
        poli2=[poli poli];
        tt=linspace(0,2*T,length(poli2));
        ECM=(1/length(y3))*(sum((poli2-y3).^2));
        
        if e>ECM
            break
        end
    end
    
    ECM;
    m;
    
    Gibbs=(max(poli)-min(poli))/(a);
    Gibbsp=(Gibbs*100)-100
    
    
    plot(tt,poli2)
    hold on
    plot(tt,y3)
    grid on
    legend('Senial','Aproximacion')
    xlabel Tiempo
    ylabel Amplitud
    
elseif s==2  % Diente de sierra
    t1=-T:dt:-T/2-dt;
    t2=-T/2:dt:T/2-dt;
    t3=T/2:dt:T-dt;
    y1=2*a*f*t1+2*a;
    y2=2*a*f*t2;
    y3=2*a*f*t3-2*a;
    t=[t1 t2 t3];
    y=[y1 y2 y3];
    for m=1:n
        bn=(2*a*((-1)^(m+1)))/(m*pi);
        fourie(m,:)=bn*sin(2*pi*f*m.*t);
        poli=sum(fourie,1);
        ECM=(1/length(y))*(sum((poli-y).^2));
        
        if e>ECM
            break
        end
    end
    ECM;
    m;
    
    Gibbs=(max(poli)-min(poli))/(2*a);
    Gibbsp=(Gibbs*100)-100
    
    plot(t,y)
    hold on
    plot(t,poli)
    grid on
    legend('Senial','Aproximacion')
    xlabel Tiempo
    ylabel Amplitud
elseif s==3 % Triangular
    Fs=1000*f;
    dt=1/Fs;
    t1=0:dt:T/2-dt;
    t2=T/2:dt:T-dt;
    y1=2*a*f*t1;
    y2=-2*a*f*t2+2*a;
    t=[t1 t2];
    y=[y1 y2];
    a0=a;
    for m=1:n
        an=((2*a)/(m*pi)^2)*(((-1)^m)-1);
        bn=0;
        fourie(m,:)=an*cos(2*pi*f*m.*t);
        poli=(a0/2)+sum(fourie,1);
        ECM=(1/length(y))*(sum((poli-y).^2));
        
        if e>ECM
            break
        end
    end
    
    ECM;
    m;
    Gibbsp=0
    
    plot(t,y)
    hold on
    plot(t,poli)
    grid on
    legend('Senial','Aproximacion')
    xlabel Tiempo
    ylabel Amplitud
    
    
end
end