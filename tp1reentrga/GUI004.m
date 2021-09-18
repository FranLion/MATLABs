% GUI004

function GUI004(~,~)

% Declaraciones y Variables Globales

devices = audiodevinfo;

% Figuras y objetos

FigRI = figure('Visible','on','Name','Adquisicion de respuesta al impulso','MenuBar','none','Position',[750,250,500,450]);

% Edit texts

DuracionRR = uicontrol(FigRI,'Style','edit','string','','position',[120,310,120,20]);

DuracionRI = uicontrol(FigRI,'Style','edit','string','','position',[380,230,70,25]);

Frecuenciainicial = uicontrol(FigRI,'Style','edit','string','','position',[380,200,70,25]);

Frecuenciafinal = uicontrol(FigRI,'Style','edit','string','','position',[380,170,70,25]);

Nombredearchivo = uicontrol(FigRI,'Style','edit','string','','position',[380,140,70,25]);

% Botones

    % Pulsables
ReproducirRR = uicontrol(FigRI,'Style','pushbutton','String','Reproducir','Position',...
    [300,300,150,40]);

ReproducirRI = uicontrol(FigRI,'Style','pushbutton','String','Reproducir y grabar','Position',...
    [300,70,150,50]);

% Popups

Dispositivosin = uicontrol(FigRI,'Style','popupmenu','String',{devices.input.Name},'Position',...
    [300,410,150,25]);

Dispositivosout = uicontrol(FigRI,'Style','popupmenu','String',{devices.output.Name},'Position',...
    [300,380,150,25]);

GraficosSS = uicontrol(FigRI,'Style', 'popupmenu',...
    'String',{'Tiempo vs Amplitud','Frecuencia vs Presion'},'Position',[300,15,150,25]);

% Callbacks

GraficosSS.Callback = {@GraficosexchangeSS,DuracionRI,Frecuenciainicial,Frecuenciafinal,GraficosSS};

ReproducirRR.Callback = {@ruidorosa,DuracionRR};

ReproducirRI.Callback = {@adquisicionRI,DuracionRI,Frecuenciainicial,Frecuenciafinal,Nombredearchivo};

% Titulos

% RR

TituloRR = uicontrol(FigRI,'Style','text','String','Ruido rosa','Position',[0,340,150,25]);

TitulodurRR = uicontrol(FigRI,'Style','text','String','Duracion:','Position',[20,300,70,25]);

% RI

TituloRI = uicontrol(FigRI,'Style','text','String','Adquisicion de respuesta al impulso','Position',[15,265,340,25]);

TitulodurRI = uicontrol(FigRI,'Style','text','String','Duracion:','Position',[290,230,62,25]);

TitulofiRI = uicontrol(FigRI,'Style','text','String','Frecuencia inicial:','Position',[290,200,70,25]);

TituloffRI = uicontrol(FigRI,'Style','text','String','Frecuencia final:','Position',[290,170,70,25]);

TitulonaRI = uicontrol(FigRI,'Style','text','String','Nombre de archivo:','Position',[290,140,70,25]);

% Devices

TituloDispositivosin = uicontrol(FigRI,'Style','text','String','Seleccionar dispositivo de entrada de audio: ','Position',[23,410,190,25]);

TituloDispositivosout = uicontrol(FigRI,'Style','text','String','Seleccionar dispositivo de salida de audio:  ','Position',[20,380,190,25]);

% Ejes

ejesRI = axes(FigRI,'Units','pixels','Position',[50,40,200,200]);

% Normalizacion

ejesRI.Units = 'normalized';

TitulodurRR.Units = 'normalized';

TituloRR.Units = 'normalized';

TituloDispositivosin.Units = 'normalized';

TituloDispositivosout.Units = 'normalized';

Dispositivosout.Units = 'normalized';

TituloRI.Units = 'normalized';

TitulodurRI.Units = 'normalized';

GraficosSS.Units = 'normalized';

Dispositivosin.Units = 'normalized';

TitulofiRI.Units = 'normalized';

TituloffRI.Units = 'normalized';

TitulonaRI.Units = 'normalized';

ReproducirRR.Units = 'normalized';

ReproducirRI.Units = 'normalized';

DuracionRR.Units = 'normalized';

DuracionRI.Units = 'normalized';

Frecuenciafinal.Units = 'normalized';

Frecuenciainicial.Units = 'normalized';

Nombredearchivo.Units = 'normalized';

% Resizing
    
TituloRR.FontSize = 15 ;

TituloRI.FontSize = 15 ;

% Funciones

    function ruidorosa(~,~,DuracionRR)
        
       S = str2double(DuracionRR.String);
       
       ruido_rosa(S);
        
    end

    function adquisicionRI(~,~,DuracionRI,Frecuenciainicial,Frecuenciafinal,Nombredearchivo)
        
        f1 = str2double(Frecuenciainicial.String);
        
        f2 = str2double(Frecuenciafinal.String);

        T = str2double(DuracionRI.String);
        
        ns = num2str(Nombredearchivo.String);
        
        sine_sweepfft(f1,f2,T,ns);
        
    end

    function GraficosexchangeSS(~,~,DuracionRI,Frecuenciainicial,Frecuenciafinal,GraficosSS)
        
        if  GraficosSS.Value(GraficosSS.Value==1)== 1
            
            T = str2double(DuracionRI.String);
            
            f1 = str2double(Frecuenciainicial.String);
            
            f2 = str2double(Frecuenciafinal.String);
            
            sine_sweepPlot(f1,f2,T);
            
        else
   
            f1 = str2double(Frecuenciainicial.String);
            
            f2 = str2double(Frecuenciafinal.String);
            
            T = str2double(DuracionRI.String);
   
            plotfft(f1,f2,T);
            
        end
    end
       
end