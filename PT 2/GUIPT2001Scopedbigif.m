function GUIPT2001Scopedbigif(~,~)

% Figuras y objetos

Figdata = figure('Visible','on','Name','Procesado de señales','MenuBar','none','Position',[550,150,1000,800]);

% Tabla

UIT = uitable(Figdata,'RowName',{'EDT' 'T10' 'T20' 'T30'},'Position',[5,5,990,150]);

% Textos y titulos

TextoLF = uicontrol(Figdata,'Style','text','String','','Tag','TextoLF','Position',[120,700,150,25],'FontSize',10,'UserData',struct('val',0,'diffMax',1));

TextoTituloLF = uicontrol(Figdata,'Style','text','String','Archivo cargado: ','Position',[10,700,100,25],'FontSize',10);

TextoTituloOCT = uicontrol(Figdata,'Style','text','String','Filtrar por: ','Position',[10,650,63,25],'FontSize',10);

% Botones

% Pulsables

Loadfile = uicontrol(Figdata,'Style','pushbutton','tag','Loadfile','String','Cargar archivo','Position',[10,750,150,30],'FontSize',10,'FontWeight','bold');

Loadfile.Units = 'normalized';

CalcularBT = uicontrol(Figdata,'Style','pushbutton','Visible','on','String','Calcular','Position',[190,550,150,30],'FontSize',10,'FontWeight','bold');

% Radiales

RAD.Tercio = uicontrol(Figdata,'Style','radiobutton','String','Un tercio de octava','Position',[10,610,130,25]);

RAD.Octava= uicontrol(Figdata,'Style','radiobutton','String','Una octava','Position',[190,610,100,25]);

% Popups

% POP.Cosa1 = uicontrol(Figdata,'Style','popupmenu','String',{'Cosa numero 2','Cosa numero 3'},'Position',...
%     [10,500,150,30]);

POP.SCMM = uicontrol(Figdata,'Style','popupmenu','String',{'Schroeder','Media movil'},'Position',...
    [10,545,150,30]);

% Graficos

Grafico = axes(Figdata,'Units','Pixels','Position',[490,330,500,430]);

title(Grafico,'Respuesta Impulsiva','FontWeight','bold','FontSize',12);

xlabel(Grafico,'Tiempo [S]','FontSize',10,'FontWeight','bold');

ylabel(Grafico,'Amplitud [dB]','FontSize',10,'FontWeight','bold');

% Callbacks

% POP.Cosa2.Callback = {@calcular,Tuco2};

% UIT.Callback = {UIT};
% 
% POP.SCMM.Callback = {@seleccionmetodo,POP};

TextoLF.Callback = {@cambiartexto,TextoLF};

Loadfile.Callback = {@cargar,TextoLF};

CalcularBT.Callback = {@calcular,POP,CalcularBT,@seleccionmetodo,POP,CalcularBT};

RAD.Tercio.Callback = {@seleccionfiltrado,RAD};

RAD.Octava.Callback = {@seleccionfiltrado,RAD};

end

% Funciones

    function  [Z] = cargar(hObject,Callbackdata,ruta,archivo)
        
        [archivo,ruta] = uigetfile('*.wav','Abrir un archivo de datos');
        
        if archivo==0
            
            return;
            
        else
            
            dat_archivo=strcat(ruta,archivo);
            
            A = importdata(dat_archivo, 't', 1);
            
            B=audioread(archivo);
            
            B=B';
          
            Z = hObject.String;
            
            
        end
        
    end
    
    function cambiartexto(hObject,Callbackdata,Z)
    h = findobj('Tag','Loadfile');
    Z = h.String;
    hObject.String=Z;
    end
    
    
    
    function [h] = seleccionfiltrado(~,~,RAD,Z)
        
        %         Z=findobj('tag','Loadfile');
        
        %         Z=guidata(Z);
        
        Z = Loadfile.UserData;
        
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


    function [f] = seleccionmetodo(~,~,POP,h,CalcularBT)
        
        if POP.SCMM.Value == 1 && CalcularBT.Value == 1
            
            [f] = schroeder(h);
            
        else
            
            [f] = mediamovil(h);
            
            [m n] = size(h);
            
            fmm=dsp.MovingAverage('Method','Sliding window','SpecifyWindowLength',true ...
                ,'WindowLength',6615);
            
            for i=1:n
                
                f(:,i)=step(fmm,h(:,i));
            
            end
            
        end
        
    end



    function [K] = calcular(~,~,POP,CalcularBT,f)
        
        function c=parametrosgral(s)
            for i=1:9
                s(:,i)=20*log10(s(:,i)/max(abs(s(:,i))));
            end
            c=cell(8,9);
            for i=1:9
                pm=max(find(s(:,i)==max(s(:,i))));
                s(:,i)=s(pm:end,i);
                z=floor(abs(s(:,i)));
                pc=min(find(z==10));
                EDT=s(1:pc,i);
                c{1,i}=EDT;
                pc1=min(find(z==5));
                pc10=min(find(z==15));
                pc20=min(find(z==25));
                pc30=min(find(z==35));
                T10=s(pc1:pc10,i);
                c{3,i}=T10;
                T20=s(pc1:pc20,i);
                c{5,i}=T20;
                T30=s(pc1:pc30,i);
                c{7,i}=T30;
                xedt=0:1/44100:pc/44100-1/44100;
                c{2,i}=xedt;
                x10=pc1/44100:1/44100:pc10/44100;
                c{4,i}=x10;
                x20=pc1/44100:1/44100:pc20/44100;
                c{6,i}=x20;
                x30=pc1/44100:1/44100:pc30/44100;
                c{8,i}=x30;
            end
        end
        
        function [tabla,tablab]=Pendiente(c)
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
                
                tabla=(1./[edt;t100;t200;t300]).*60;
                tablab=b;
                
            end
        end
        
        function ploteorectas(band)
            M=tabla(:,band);
            
            O=tablab(:,band);
            
            Y=O-M*ti;
            
            hold on
            plot(ti,Y(1,:))
            hold on
            plot(ti,Y(2,:))
            hold on
            plot(ti,Y(3,:))
            hold on
            plot(ti,Y(4,:))
        end
        
    end