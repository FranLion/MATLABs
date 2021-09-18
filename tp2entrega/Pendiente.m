function [tabla,tablab,descriptores]=Pendiente(c)

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
    
    descriptores=[edt;t100;t200;t300];
    tabla=(1./[edt;t100;t200;t300]).*60;
    tablab=b;
    
end

end