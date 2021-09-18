% fft para grabacion

d=audioread('Toma_n1_a.wav')';

Y = fft(d);

% fft para filtro inverso

x=audioread('filtroinversoPOSTA.wav')';
x=[zeros(1,683550) x zeros(1,683550)];

Z=fft(x);

% resupuesta al impulso

ri=Y.*Z;
J=ifft(ri);
J=J(1, find(J==max(J)):find(J==max(J))+(44100*3));
J=J/max(abs(J));
ti=linspace(0,length(J)/44100,length(J));


% disenio del filtro

fi =fdesign.octave(1,'Class 1','N,F0',6,1000,44100);
v=validfrequencies(fi);
for i=1:length(v);
     fi.F0=v(i);
     a = design(fi);
     r(:,i)=filter(a,J);
end

r;

% hilbert

for i=1:9
   h(:,i)=abs(hilbert(r(:,i)));
end

h;

% filtro de media movil

fmm=dsp.MovingAverage('Method','Sliding window','SpecifyWindowLength',true ...
           ,'WindowLength',6615)

for i=1:9
    f(:,i)=step(fmm,h(:,i));
end

f;

% schroeder

for i=1:9
    s(:,i)=flip(cumsum(flip(h(:,i))/sum(h(:,i))));
end

s;

% ploteos

seni=20*log10(r(:,1)/max(r(:,1)));

hil=20*log10(h(:,1)/max(h(:,1)));

movil=20*log10(f(:,1)/max(f(:,1)));

schoe=20*log10(s(:,1)/max(s(:,1)));

plot(ti,seni); hold on; plot(ti,hil,'r'); plot(ti,movil,'y'); plot(ti,schoe,'k'); 












