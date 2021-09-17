% Front end

function Interfaz(~,~)

% Figuras y objetos

Fondo = figure('Name','Final Señales y sistemas',...
    'Position',[500,150,1000,500],'Units','Normalized','toolbar','none');

%% Panel Senial
panelsenal = uipanel('Parent',Fondo,'Title','Procesamiento de señal',...
    'Position',[.01 .01 .98 .98],'Units','normalized');

%% Titulo

Titulofinal = uicontrol('Parent',panelsenal,'Style','text','String','Trabajo Final Effecto de Gibbs',...
    'Position',[450 450 290 25],'FontSize',15,'Units','normalized');

%% Panel Resultados
panelresultados = uipanel('Parent',panelsenal,'Title','Resultados',...
    'Position',[.01 .0 .2 .36],'Units','normalized','Visible','on');

%% Logo
logo = axes('Parent',panelresultados,'position',[.0 .0 1 .4]);
axes(logo);
imshow('UNTREF-LOGO.png');
% axis off
% axis image
%% Ejes

ax1 = axes('Parent',panelsenal,'Position',[0.26 0.14 0.73 0.8]);
grid on
xlabel Tiempo
ylabel Amplitud

%% Seleccioncriterio

critradbut = uibuttongroup('Parent',panelsenal,'Title',...
    'Criterio de corte','Position',[.01 .88 .2 .12],...
    'SelectionChangedFcn',@criteria);

r1 = uicontrol('Parent',critradbut,'Style',...
    'radiobutton',...
    'String','Aproximacion por serie de Fourier',...
    'Position',[5 26 170 15],...
    'Units','Normalized');

r2 = uicontrol('Parent',critradbut,'Style','radiobutton',...
    'String','Error cuadratico medio',...
    'Position',[5 8 170 15],...
    'Units','Normalized');

%% Panel Fourier

panparFour = uipanel('Parent',panelsenal,'Title','Parametros Fourier',...
    'Position',[.01 .44 .20 .44],'Units','normalized','Visible','On');

%% Parametros Fourier

amplitudtitulo = uicontrol('Parent',panparFour,'Style',...
    'text','String','Amplitud: ','Position',[10 35 80 60],'Units','normalized');

frecuenciatitulo = uicontrol('Parent',panparFour,'Style',...
    'text','String','Frecuencia: ',...
    'Position',[120 35 80 60],'Units','normalized');

armonicostitulo = uicontrol('Parent',panparFour,'Style',...
    'text','String','Armonicos: ',...
    'Position',[100 175 90 15],'Units','normalized');

tiposenialtitulo = uicontrol('Parent',panparFour,'Style',...
    'text','String','Senial: ',...
    'Position',[5 175 80 15],'Units','normalized');

amplitudbox = uicontrol('Parent',panparFour,'Style',...
    'edit','String','','Position',[10 50 70 15],'Units','normalized');

frecuenciabox = uicontrol('Parent',panparFour,'Style',...
    'edit','String','','Position',[120 50 70 15],'Units','normalized');

armonicosespecificos = uicontrol('Parent',panparFour,'Style',...
    'text','String','Numero especifico: ',...
    'Position',[5 30 100 15],'Units','normalized','Visible',...
    'off');

armonicosbox = uicontrol('Parent',panparFour,'Style',...
    'edit','String','60','Position',[10 10 70 15],'Units',...
    'normalized','Visible','off');

%% Boton Calculo Fourier

CalcularFourier = uicontrol('Parent',panelsenal,'Style',...
    'Pushbutton','String','Calcular por Serie de Fourier',...
    'Position',[10 170 195 36],'Units','normalized','Callback',@calcularFourier);

%% Popups Fourier

Selectorsenial = uicontrol('Parent',panparFour,'Style',...
    'popupmenu','String',{'Tren de pulsos',...
    'Diente de Sierra','Triangular'},'Value',1,'Position',...
    [10 135 80 36],'Units','normalized');

Selectorarmonicos = uicontrol('Parent',panparFour,'Style',...
    'popupmenu','String',{'10',...
    '20','50','Otro'},'Value',1,'Position',...
    [100 135 80 36],'Units','normalized','Callback',@armonicoschange);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Panel ECM

panparecm = uipanel('Parent',panelsenal,'Title','Parametros ECM',...
    'Position',[.01 .44 .20 .44],'Units','normalized','Visible','off');

%% Parametros ECM

amplitudtituloecm = uicontrol('Parent',panparecm,'Style',...
    'text','String','Amplitud: ','Position',[10 35 80 60],'Units','normalized');

frecuenciatituloecm = uicontrol('Parent',panparecm,'Style',...
    'text','String','Frecuencia: ','Position',[120 35 80 60],'Units','normalized');

amplitudboxecm = uicontrol('Parent',panparecm,'Style',...
    'edit','String','','Position',[10 50 70 15],'Units','normalized');

frecuenciaboxecm = uicontrol('Parent',panparecm,'Style',...
    'edit','String','','Position',[120 50 70 15],'Units','normalized');

errorboxecm = uicontrol('Parent',panparecm,'Style',...
    'edit','String','','Position',[10 15 70 15],'Units','normalized');

tituloerrorecm = uicontrol('Parent',panparecm,'Style',...
    'text','String','Error:','Position',[5 30 80 15],'Units','normalized');

tiposenialtitulo = uicontrol('Parent',panparecm,'Style',...
    'text','String','Senial: ',...
    'Position',[5 175 80 15],'Units','normalized');

%% Popups ECM

Selectorsenialecm = uicontrol('Parent',panparecm,'Style',...
    'popupmenu','String',{'Tren de pulsos',...
    'Diente de Sierra','Triangular'},'Value',1,'Position',...
    [10 135 80 36],'Units','normalized');

%% Boton Calculo ECM

CalcularECM = uicontrol('Parent',panelsenal,'Style',...
    'Pushbutton','String','Calcular por ECM','Position',[10 170 195 36],'Units','normalized','Callback',@calcularecm,'Visible','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

%% Titulos Resultados

tituGibbs=uicontrol('Parent',panelresultados,'Style','text',...
    'String','Effecto de Gibbs:','Position',...
    [0 130 115 20],'Units','normalized','FontSize',11);

tituECM=uicontrol('Parent',panelresultados,'Style','text',...
    'String','ECM:','Position',...
    [0 90 90 20],'Units','normalized','FontSize',11);

tituarmonicos=uicontrol('Parent',panelresultados,'Style','text',...
    'String','Armonicos ','Position',...
    [0 65 110 20],'Units','normalized','FontSize',11,'Visible','off','Callback',@criteria);

ResGibbs=uicontrol('Parent',panelresultados,'Style','text',...
    'String','-- [%]','Position',...
    [109     129 100 20],'Units','normalized','FontSize',9);

ResECM=uicontrol('Parent',panelresultados,'Style','text',...
    'String','---','Position',...
    [105 85 100 25],'Units','normalized','FontSize',9);

Resm=uicontrol('Parent',panelresultados,'Style','text',...
    'String','---','Position',...
    [105 65 100 20],'Units','normalized','FontSize',9,'Visible','off','Callback',@criteria);

%% end

% Back end

s=0;

f=0;

n=0;

a=0;

e=0;

    function criteria(~,~)
        
        if    r1.Value==1
            
            panparFour.Visible = 'on';
            
            panparecm.Visible = 'off';
            
            CalcularFourier.Visible= 'on';
            
            CalcularECM.Visible= 'off';
            
            tituarmonicos.Visible= 'off';
            
            Resm.Visible= 'off';
            
        elseif r2.Value==1
            
            panparFour.Visible = 'off';
            
            panparecm.Visible = 'on';
            
            CalcularECM.Visible= 'on';
            
            CalcularFourier.Visible= 'off';
            
            tituarmonicos.Visible= 'on';
            
            Resm.Visible= 'on';
            
        end
    end

    function armonicoschange(~,~)
        
        if Selectorarmonicos.Value==1
            
            n=10;
            
            armonicosbox.Visible='off';
            
            armonicosespecificos.Visible='off';
            
        elseif Selectorarmonicos.Value==2
            
            n=20;
            
            armonicosbox.Visible='off';
            
            armonicosespecificos.Visible='off';
            
        elseif Selectorarmonicos.Value==3
            
            n=50;
            
            armonicosbox.Visible='off';
            
            armonicosespecificos.Visible='off';
            
        elseif Selectorarmonicos.Value==4
            
            armonicosbox.Visible='on';
            
            armonicosespecificos.Visible='on';
            
            n=str2double(armonicosbox.String);
            
        end
        
    end

    function calcularFourier (~,~)
        
        clear ECM
        
        cla
        
        
        
        try   f=str2num(frecuenciabox.String);
            
            a=str2double(amplitudbox.String);
            
            if Selectorarmonicos.Value==1
                
                n=10;
                
                armonicosbox.Visible='off';
                
                armonicosespecificos.Visible='off';
                
            elseif Selectorarmonicos.Value==2
                
                n=30;
                
                armonicosbox.Visible='off';
                
                armonicosespecificos.Visible='off';
                
            elseif Selectorarmonicos.Value==3
                
                n=50;
                
                armonicosbox.Visible='off';
                
                armonicosespecificos.Visible='off';
                
            elseif Selectorarmonicos.Value==4
                
                armonicosbox.Visible='on';
                
                armonicosespecificos.Visible='on';
                
                n=str2double(armonicosbox.String);
                
            end
            
            if (Selectorsenial.Value==1)==1
                
                s = 1;
                
                [Gibbsp,ECM]=senales32(s,a,f,n);
                
                ResGibbs.String=strcat(num2str(Gibbsp),'[%]');
                
                ResECM.String=ECM;
                
            elseif Selectorsenial.Value==2
                
                s = 2;
                
                [Gibbsp,ECM]=senales32(s,a,f,n);
                
                ResGibbs.String=strcat(num2str(Gibbsp),'[%]');
                
                ResECM.String=ECM;
                
            elseif Selectorsenial.Value==3
                
                s = 3;
                
                [Gibbsp,ECM]=senales32(s,a,f,n);
                
                ResGibbs.String= 'No tiene effecto de Gibbs';
                
                ResECM.String=ECM;
                
            end
        catch errordlg('Seleccion de parametros invalida','Error');
        end
    end

    function calcularecm (~,~)
        
        clear ECM
        
        cla
        
        try a=str2double(amplitudboxecm.String);
            
            e=str2double(errorboxecm.String);
            
            f=str2double(frecuenciaboxecm.String);
            
            if (Selectorsenialecm.Value==1)==1
                
                s = 1;
                
                [ECM,Gibbsp,m]=ecmerror(s,a,f,e);
                
                ResGibbs.String=strcat(num2str(Gibbsp),'[%]');
                
                ResECM.String=ECM;
                
                Resm.String=m;
                
            elseif Selectorsenialecm.Value==2
                
                s = 2;
                
                [ECM,Gibbsp,m]=ecmerror(s,a,f,e);
                
                ResGibbs.String=strcat(num2str(Gibbsp),'[%]');
                
                ResECM.String=ECM;
                
                Resm.String=m;
                
            elseif Selectorsenialecm.Value==3
                
                s = 3;
                
                [ECM,Gibbsp,m]=ecmerror(s,a,f,e);
                
                ResGibbs.String='approx. 0[%]';
                
                ResECM.String=ECM;
                
                Resm.String=m;
                
            end
            
        catch err=errordlg('Seleccion de parametros invalida','Error');
            
        end
        
    end

end