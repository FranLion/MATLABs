function td=schroederlimit(mm)
    j=find(mm==max(mm));
    u=[max(mm):(max(mm)-mm(end))/(j(end)-length(mm)):mm(end)]';
    v=mm(j(end):end);
    td=find(u-v==max(u-v));
    td=td(end)+j(end)-1;
    td=round(td*1.1);
end