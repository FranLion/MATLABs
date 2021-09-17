function [r]=filtros(J,bandxoct,fs)

if bandxoct~=3 && bandxoct~=1
    
    disp('las bandas por octava tienen que ser 1 o 3')
    
else
    
    fi =fdesign.octave(bandxoct,'Class 1','N,F0',6,1000,fs);
    
    v=validfrequencies(fi);
    
    for i=1:length(v)
        fi.F0=v(i);
        a = design(fi);
        r(:,i)=filter(a,J);
    end
    
end

end