function [s,vn]=octavefilter(y,bandsperoctave)
k=1;
fs=48000;
if bandsperoctave==1
    order=6;
elseif bandsperoctave==3
    order=8;
else
    error('Filtro invalido')
end
    
f=fdesign.octave(bandsperoctave,'Class 1','N,F0',order,fs);
v=validfrequencies(f);
vn=v(find(v>99/(fs/2) & v<6000/(fs/2)));
center=vn;
vn=vn*24000;
s=zeros(size(y,1),length(vn));
for i=center
    f.F0=i;
    t=design(f,'butter');
    s(:,k)=filter(t,y);
    k=k+1;
end
end