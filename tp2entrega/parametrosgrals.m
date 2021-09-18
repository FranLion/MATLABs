function [c]=parametrosgrals(s,fs)

[m n]=size(s);

for i=1:n
    
    s(:,i)=20*log10(s(:,i)/max(abs(s(:,i))));

end

c=cell(8,n);
    
for i=1:n

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
    xedt=0:1/fs:pc/fs-1/fs;
    c{2,i}=xedt;
    x10=pc1/fs:1/fs:pc10/fs;
    c{4,i}=x10;
    x20=pc1/fs:1/fs:pc20/fs;
    c{6,i}=x20;
    x30=pc1/fs:1/fs:pc30/fs;
    c{8,i}=x30;
    

end

end