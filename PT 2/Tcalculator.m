function [t010,t525,t535]=Tcalculator(v)
    
    vmax=find(v==max(v),1,'last');
    j=find(max(v)-v>=5);
    t5=j(j>vmax);
    n=find(max(v)-v<=10);
    t010=n(n>=vmax);
    t525=t5(max(v)-v(t5)<=25);
    t535=t5(max(v)-v(t5)<=35);
    
end