function [encuentro] = Lundeby(t,h_t,Fs)
h_squared = h_t;

total = length(h_t);
tail = round((total*90)/100);
h_rf = (h_squared(tail:end));
rf_tail = mean(h_rf) ;

maximo = find(h_squared == max(h_squared),1,'first');
minimo = find(h_squared < (rf_tail+10),1,'first');
h_caida = (h_squared(maximo:minimo))';
t_caida = t(maximo:minimo); 
[a_0_caida,a_1_caida] = cuad_min(t_caida,h_caida);
recta_caida = a_0_caida + a_1_caida * t;

encuentro = find(recta_caida < rf_tail,1,'first');

end