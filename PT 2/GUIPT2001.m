% function GUIPT2001(~,~)

% Figuras y objetos

Figdata = figure('Visible','on','Name','Procesado de señales','MenuBar','none','Position',[550,150,1000,800]);

% Tabla

UIT = uitable(Figdata,'RowName',{'EDT' 'T10' 'T20' 'T30'},'Position',[5,5,990,150]);

% Textos y titulos

Texto.LF = uicontrol(Figdata,'Style','text','String','','Position',[120,700,150,25],'FontSize',10,'UserData',struct('val',0,'diffMax',1));

Texto.TituloLF = uicontrol(Figdata,'Style','text','String','Archivo cargado: ','Position',[10,700,100,25],'FontSize',10);

Texto.TituloOCT = uicontrol(Figdata,'Style','text','String','Filtrar por: ','Position',[10,650,63,25],'FontSize',10);

% Botones

% Pulsables

Loadfile = uicontrol(Figdata,'Style','pushbutton','tag','Loadfile','String','Cargar archivo','Position',[10,750,150,30],'FontSize',10,'FontWeight','bold');

Loadfile.Units = 'normalized';

CalcularBT = uicontrol(Figdata,'Style','pushbutton','Visible','on','String','Calcular','Position',[10,550,150,30],'FontSize',10,'FontWeight','bold');

% Radiales

RAD.Tercio = uicontrol(Figdata,'Style','radiobutton','String','Un tercio de octava','Position',[10,610,130,25]);

RAD.Octava= uicontrol(Figdata,'Style','radiobutton','String','Una octava','Position',[190,610,100,25]);

% Popups

% POP.Cosa1 = uicontrol(Figdata,'Style','popupmenu','String',{'Cosa numero 2','Cosa numero 3'},'Position',...
%     [10,500,150,30]);

POP.SCMM = uicontrol(Figdata,'Style','popupmenu','String',{'Schroeder','Media movil'},'Position',...
    [190,500,150,30]);

% Graficos

Grafico = axes(Figdata,'Units','Pixels','Position',[490,330,500,430]);

title(Grafico,'Respuesta Impulsiva','FontWeight','bold','FontSize',12);

xlabel(Grafico,'Tiempo [S]','FontSize',10,'FontWeight','bold');

ylabel(Grafico,'Amplitud [dB]','FontSize',10,'FontWeight','bold');


% Callbacks

% POP.SCMM.Callback = {@calcular};

% POP.Cosa2.Callback = {@calcular,Tuco2};

% UIT.Callback = {UIT};

Texto.LF.Callback = {@cargar,Texto};

Loadfile.Callback = {@cargar,Texto,Loadfile};

CalcularBT.Callback = {@seleccionfiltrado};

RAD.Tercio.Callback = {@seleccionfiltrado,RAD};

RAD.Octava.Callback = {@seleccionfiltrado,RAD};



% Funciones

function Z = cargar(~,~,Texto,Loadfile)

[archivo,ruta] = uigetfile('*.wav','Abrir un archivo de datos');

if archivo==0
    
    return;
    
else
    
    dat_archivo=strcat(ruta,archivo);
    
    A = importdata(dat_archivo, 't', 1);
    
    B=audioread(archivo);
    
    B=B';
    
    Texto.LF.String = archivo;
   
    Loadfile.UserData = archivo;
    
    Z=archivo;
    
end

end   

    function tacuen=seleccionfiltrado(~,~,RAD,CalcularBT,Z,Loadfile)
        
%         Z=findobj('tag','Loadfile');

        Z=Loadfile.UserData;
        
        if  RAD.Tercio.Value == 1 && RAD.Octava.Value == 1
            
            errordlg('Seleccione solo un metodo de filtrado')
            
            CalcularBT.Visible = 'off';
            
        elseif RAD.Tercio.Value == 1 && RAD.Octava.Value == 0
            
            CalcularBT.Visible = 'on';
            
            bandxoct = 3;
            
            [r]=filtros(Z,bandxoct,44100);
            
            [h]=hil(r);
            
        elseif RAD.Octava.Value ==1 && RAD.Tercio.Value ==0
            
            CalcularBT.Visible = 'on';
            
            bandxoct = 1;
            
            [r]=filtros(Z,bandxoct,44100);
            
            [h]=hil(r);
            
            return
            
        end
        
    end
% end
% 
%      function mmovilScrhoeder(~,~)
%         
%         [f]=mediamovil(h);
%         
%     end
% 
%   end