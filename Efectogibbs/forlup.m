function forlup (s,a,f,n)

Fs=44100;
T=1/f;
dt=1/Fs;
t=0:dt:T-dt;
% syms t

for i = 0:n

    if s == 1
    y=rectangularPulse(0,T/2,t);
    y2=[y,y];
    y2=a*y2;
    a0=a
    an=0
%     bn=(-a/(pi*n))*(-1^n)+a/(pi*n)
    bn=(2/T)*(sum(y.*sin(n*2*pi*f*t)));

    elseif s == 2
    y= sawtooth(2*pi*f*t);
    y=a*y;
    a0=0
    an=0
    bn=(2/T)*(sum(y.*sin(n*2*pi*f*t)));
%     bn=(2*(-1^(n+1)))/(n*pi*f^2)
%     bn=(2/T)*(sum(x.*sin(n*2*pi*f*t2)));    
%     a0=(2/T)*(sum(x.*cos(0*2*pi*f*t2)));
%     disp('a0: '); disp(a0);
%     an=(2/T)*(sum(x.*cos(n*2*pi*f*t2)));
%     disp('bn: ');disp(bn);
    
    else
        break
    
    end
    
end

disp('bn: ');disp(bn);
disp('an: ');disp(an);
disp('a0: ');disp(a0);
end
