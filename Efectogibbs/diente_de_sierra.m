function [x]=diente_de_sierra(a,f)
T = 1/f;
Fs = 41000;
dt = 1/Fs;
t = -T:dt:T-dt;
x = sawtooth(2*pi*f*t);
x=a*x;
plot(t,x)
grid on
end