% Front end

function GUITP2(~,~)

Interfaz

end

function Interfaz(~,~)

% Figuras y objetos

Figdata = dialog('Name','Trabajo practico segunda parte',...
    'Position',[550,150,710,310],'WindowStyle','normal');

% Tabla

UIT = uitable(Figdata,'RowName',{'EDT' 'T10' 'T20' 'T30'},'Position',[5,5,700,150]);

% Textos y titulos

Texto.LF = uicontrol(Figdata,'Style','text','String','',...
    'Position',[100,160,160,35],'FontSize',10);

Texto.TituloLF = uicontrol(Figdata,'Style','text','String',...
    'Archivo cargado: ','Position',[10,165,100,25],'FontSize',10);

Texto.filtro = uicontrol(Figdata,'Style','text','String',...
    'Seleccione un tipo de filtrado: ','Position',[240,200,200,50],'FontSize',10);

Texto.primerpaso = uicontrol(Figdata,'Style','text','String',...
    'Primer paso: ','Position',[7,265,150,20],'FontSize',10,'Fontweight','Bold');

Texto.segundopaso = uicontrol(Figdata,'Style','text','String',...
    'Segundo paso: ','Position',[223,265,150,20],'FontSize',10,'Fontweight','Bold');

Texto.tercerpaso = uicontrol(Figdata,'Style','text','String',...
    'Tercer paso: ','Position',[470,265,150,17],'FontSize',...
    10,'Fontweight','Bold');%Textos indicativos y titulos

% Botones

    % Pulsables

Loadfile = uicontrol(Figdata,'Style','pushbutton','tag',...
    'Loadfile','String','Cargar archivo','Position',[7,230,150,30],...
    'FontSize',10,'FontWeight','bold');

Loadfile.Units = 'normalized';

CalcularBT = uicontrol(Figdata,'Style','pushbutton','Visible',...
    'on','String','Calcular','Position',[500,230,150,30],...
    'FontSize',10,'FontWeight','bold');

    % Radiales

RAD.Tercio = uicontrol(Figdata,'Style','radiobutton','String',...
    'Un tercio de octava','Position',[250,165,180,25]);

RAD.Octava= uicontrol(Figdata,'Style','radiobutton','String',...
    'Una octava','Position',[390,165,100,25]);

% Callbacks

Texto.LF.Callback = {@cargar,Texto};

Loadfile.Callback = {@cargar,Texto,Loadfile};

CalcularBT.Callback = {@calcular,UIT,RAD};

RAD.Tercio.Callback = {@seleccionfiltrado,RAD,CalcularBT};

RAD.Octava.Callback = {@seleccionfiltrado,RAD,CalcularBT};

end

% Back end

function  cargar(~,~,Texto,Loadfile)

W = waitbar(0,'...Cargando archivo...');

pasos=3;

waitbar(1/pasos,W)

[archivo,ruta] = uigetfile('*.wav','Abrir un archivo de datos, asegurese que este en el Path');
waitbar(2/pasos,W)

if archivo==0
    
    return;
    
else
    
    dat_archivo=strcat(ruta,archivo);
    
    A = importdata(dat_archivo, 't', 1);
    
    [B,fs]=audioread(archivo);
    
    B=B';
    
    Texto.LF.String = archivo;
    
    Loadfile.UserData = archivo;
    
    save('lamagiavariable','archivo','B','fs');
    
end

waitbar(3/pasos,W)

close(W)

end%Funcion que carga el archivo a la interfaz

function seleccionfiltrado(~,~,RAD,CalcularBT,UIT)

W = waitbar(0,'...Procesando filtros...');

pasos=2;

waitbar(1/pasos,W)

load('lamagiavariable','archivo','B','fs');

waitbar(2/pasos,W)

if  RAD.Tercio.Value == 1 && RAD.Octava.Value == 1
    
    errordlg('Seleccione solo un metodo de filtrado')
    
    CalcularBT.Visible = 'off';
    
elseif RAD.Tercio.Value == 1 && RAD.Octava.Value == 0
    
    CalcularBT.Visible = 'on';
    
    bandxoct = 3;
    
    [r]=filtros(B,bandxoct,fs);
    
    [h]=hil(r);
    
    Z=0;
    
    save('lamagiavariable','archivo','B','h','Z','fs');
   
    save('logical','Z');
    
elseif RAD.Octava.Value ==1 && RAD.Tercio.Value ==0
    
    CalcularBT.Visible = 'on';
    
    bandxoct = 1;
    
    [r] = filtros(B,bandxoct,fs);
    
    [h]=hil(r);
    
    Z=1;
    
    save('lamagiavariable','archivo','B','h','Z','fs');
    
    save('logical','Z');
    
end

close(W)

end %Funcion que selecciona un filtrado...
%                                                      y aplica hilbert 

function calcular(~,~,UIT,CalcularBT,RAD)

W = waitbar(0,'...Calculando...');

pasos=6;

waitbar(1/pasos,W)

load('lamagiavariable','archivo','B','h','fs');

load('logical','Z');

waitbar(2/pasos,W)

if Z == 1
    
    Colname1 = {'31.5','63','125','250','500','1000','2000','4000','8000'};
    
    UIT.ColumnName = Colname1 ;
    
    Colname1 = {'31.5','63','125','250','500','1000','2000','4000','8000'};
    
    POP.String = {Colname1} ;
    
    save('logical2','Z','Colname1');
    
elseif Z == 0
    
    Colname2 = {'25','31.5','40','50','63','80','100',...
        '125','160','200','250','315','400','500','630','800','1000',...
        '1250','1600','2000','2500','3150','4000','5000','6300','8000',...
        '10000','12500','16000','20000'};
    
    UIT.ColumnName = Colname2 ;
    
    Colname2 = {'25','31.5','40','50','63','80','100',...
        '125','160','200','250','315','400','500','630','800','1000',...
        '1250','1600','2000','2500','3150','4000','5000','6300','8000',...
        '10000','12500','16000','20000'};
    
    POP.String = {Colname2} ;
    
    save('logical2','Z','Colname2');
    
else
    
    return
    
end

waitbar(3/pasos,W)

[s] = schroeder(h);

save('lamagiavariable','archivo','B','h','s','fs');

waitbar(4/pasos,W)

[c] = parametrosgrals(s,fs);

save('lamagiavariable','archivo','B','h','s','c','fs');

waitbar(5/pasos,W)

[tabla,tablab,descriptores] = Pendiente(c);

tabla = tabla;

tablab = tablab;

UIT.Data = descriptores;

save('lamagiavariable','archivo','B','h','s','c','fs','descriptores','tabla','tablab');

waitbar(6/pasos,W)

close(W)

end% Funcion que aplica Schroeder y calcula los 
%                                             Parametros descriptores
%                                             volcados luego en la tabla