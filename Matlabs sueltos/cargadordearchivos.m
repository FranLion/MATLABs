function cargadordearchivos(~,~)

[archivo,ruta]=uigetfile('*.wav','Abrir un archivo de datos');

if archivo==0
    return;
else
    dat_archivo=strcat(ruta,archivo);
    A = importdata(dat_archivo, 't', 1);
    B=audioread(archivo);
    B=B';
end
end