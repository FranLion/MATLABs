function coeficientesdientedesierra(a,f)
T = 1/f;
Fs = 41000;
dt = 1/Fs;
t = -T:dt:T-dt;
% x = sawtooth(2*pi*f*t);
% x=a*x;
% plot(t,x)
% grid on

K=1/f

a0=(2/K)*int(a*sawtooth(2*pi*f*t),0,1/f)

a0=1/2*a0

end

