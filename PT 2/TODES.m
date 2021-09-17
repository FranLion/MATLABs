function RI(toma)

grabacion=audioread(toma)';

filtro=audioread('filtroinversoPOSTA.wav')';

% fft para la grabacion

Y = fft(grabacion);

% fft para filtro inverso


filtro=[zeros(1,683550) filtro  zeros(1,683550)];

Z=fft(filtro);

% resupuesta al impulso

ri=Y.*Z;

J=ifft(ri);

J=J(1, find(J==max(J)):find(J==max(J))+(44100*3));

J=J/max(abs(J));

audiowrite('RI.wav',J,44100);

end

function [r]=filtros(J,bandxoct)

if bandxoct~=3 && bandxoct~=1
    
    disp('las bandas por octava tienen que ser 1 o 3')
    
else
    
    fi =fdesign.octave(bandxoct,'Class 1','N,F0',6,1000,44100);
    v=validfrequencies(fi);
    for i=1:length(v);
        fi.F0=v(i);
        a = design(fi);
        r(:,i)=filter(a,J);
    end
    
end

end

function [h]=hil(r)  

% el parametro de entrada es la senial ya filtrada

[m n]=size(r);

for i=1:n
   h(:,i)=abs(hilbert(r(:,i)));
end


end

function [f]=mediamovil(h)

[m n]=size(h);

fmm=dsp.MovingAverage('Method','Sliding window','SpecifyWindowLength',true ...
           ,'WindowLength',6615)

for i=1:n
    f(:,i)=step(fmm,h(:,i));
end

end

function [s]=schroeder(r)

[m n]=size(r);

for i=1:9
    s(:,i)=flip(cumsum(flip(h(:,i))/sum(h(:,i))));
end

end

function c=parametrosgral(s)
for i=1:9
    s(:,i)=20*log10(s(:,i)/max(abs(s(:,i))));
end
c=cell(8,9);
for i=1:9
pm=max(find(s(:,i)==max(s(:,i))));
s(:,i)=s(pm:end,i);
z=floor(abs(s(:,i)));
pc=min(find(z==10));
EDT=s(1:pc,i);
c{1,i}=EDT;
pc1=min(find(z==5));
pc10=min(find(z==15));
pc20=min(find(z==25));
pc30=min(find(z==35));
T10=s(pc1:pc10,i);
c{3,i}=T10;
T20=s(pc1:pc20,i);
c{5,i}=T20;
T30=s(pc1:pc30,i);
c{7,i}=T30;
xedt=0:1/44100:pc/44100-1/44100;
c{2,i}=xedt;
x10=pc1/44100:1/44100:pc10/44100;
c{4,i}=x10;
x20=pc1/44100:1/44100:pc20/44100;
c{6,i}=x20;
x30=pc1/44100:1/44100:pc30/44100;
c{8,i}=x30;
end
end

function [tabla,tablab]=Pendiente(c)
[m n]=size(c);
for i=1:n
    c(:,i);
    for j=1:4
        x=c(2*j,i);
        y=c(2*j-1,i);
        x=cell2mat(x);
        y=cell2mat(y);
        l=length(y);
        sx=sum(x);
        sy=sum(y);
        sxy=sum(x'.*y);
        sxx=sum(x.*x);
        m=(sxy-(sx*sy)/l)/((sxx)-(sx^2)/l);
        yprom=sum(y)/l;
        xprom=sum(x)/l;
        b(j,i)=yprom-m*xprom;
        if j==1
            edt(:,i)=-60/m;
        elseif j==2
            t100(:,i)=-60/m;
        elseif j==3
            t200(:,i)=-60/m;
        elseif j==4
            t300(:,i)=-60/m;
        end
    end
    
    tabla=(1./[edt;t100;t200;t300]).*60;
    tablab=b;
    
end
end

function ploteorectas(band)
M=tabla(:,band)
O=tablab(:,band);
Y=O-M*ti;
hold on
plot(ti,Y(1,:))
hold on
plot(ti,Y(2,:))
hold on
plot(ti,Y(3,:))
hold on
plot(ti,Y(4,:))
end