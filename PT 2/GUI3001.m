% Main
function GUI3001
    GUI()
end

% Front-end
function GUI()
% Front-end.

    Figdata = dialog('Position',[200 80 856 640],'Name','Calculo de descriptores','WindowStyle','normal');
    
    ax=axes('Parent',Figdata,'Units','Pixels','Position',[285 150 560 450]);   %crea ejes en la interfaz
    
    xlabel(ax,'Tiempo [s]','FontSize',12,'FontWeight','bold')
    
    ylabel(ax,'Nivel [dB]','FontSize',12,'FontWeight','bold')
    
    title(ax,'Respuesta al impulso','FontSize',14)
    
    tabledata=uitable('Parent',Figdata,...
        'Position',[10 10 838 77],'RowName',{'EDT' 'T20' 'T30'});  %crea una tabla en la interfaz
    
    tipodebanda = uicontrol('Parent',Figdata,...
        'Position',[119 468 100 30],'Style','popup',...
        'String',{'Octava' 'Tercio de octava'});   %crea un control del tipo popup menu para seleccionar el tipo de filtro a aplicar
    
    selectplot = uicontrol('Parent',Figdata,...
        'Position',[10 315 90 15],'Style','popup','String',{''}); %crea un control del tipo popup menu para seleccionar que banda visualizar en el grafico
    
    selectmethod = uicontrol('Parent',Figdata,...
        'Position',[127 198 90 15],'Style','popup',...
        'String',{'Hilbert Transform' 'Moving Filter' 'Schoeder'}); %crea un contorl del tipo popup menu para seleccionar el metodo del cual se quieren ver los resultados
    
    selectmethod.Callback={@selectmethodcallback,tabledata,selectmethod}; 
    
    selecciongrafico = uicontrol('Parent',Figdata,...
        'Position',[110 260 110 95],'Style','listbox','Max',12,'ListboxTop',12,...
        'String',{'Hilbert Transform','Hilbert EDT','Hilbert T20','Hilbert T30',...
        'Moving Filter','Moving Filter EDT','Moving Filter T20','Moving Filter T30',...
        'Schroeder','Schroeder EDT','Schroeder T20','Schroeder T30'}); %crea un control del tipo listbox para poder seleccionar lo que se quiere graficar
        selecciongrafico.Callback={@selectplotcallback,ax,selectplot,selecciongrafico};%el callback se define despues para poder pasarle al mismo control como variable, por lo que es necesario definirla antes
        selectplot.Callback={@selectplotcallback,ax,selectplot,selecciongrafico};%el callback se define despues para poder pasarle al mismo control como variable, por lo que es necesario definirla antes
    
    text.selectmethod = uicontrol('Parent',Figdata,...
        'Position',[55 365 93 15],'Style','text',...
        'String','Opciones Gráficas');%texto indicativo
    
    text.selectmethod = uicontrol('Parent',Figdata,...
        'Position',[10 194 107 15],'Style','text',...
        'String','Visualizar resultados:');%texto indicativo
    
    text.selectplot = uicontrol('Parent',Figdata,...
        'Position',[10 340 78 15],'Style','text',...
        'String','Graficar banda:');%texto indicativo
    
    text.selectfilt = uicontrol('Parent',Figdata,...
        'Position',[10 479 87 15],'Style','text',...
        'String','Seleccionar filtro:');%texto indicativo
    
    text.audioselected = uicontrol('Parent',Figdata,...
        'Position',[10 509 100 15],'Style','text',...
        'String','Audio seleccionado:');%texto indicativo
    
    text.audioname = uicontrol('Parent',Figdata,...
        'Position',[110 509 110 15],'Style','text');%texto indicativo
    
    savetable=uicontrol('Parent',Figdata,'Position',[65 160 90 24],...
        'Style','pushbutton',...
        'String','Guardar Tabla',...
        'Callback',{@savetablecallback,tabledata}); %crea un control del tipo pushbutton para guardar la tabla de datos
    
    saveplot=uicontrol('Parent',Figdata,'Position',[10 271 90 24],...
        'Style','pushbutton',...
        'String','Guardar Gráfico',...
        'Callback',{@saveplotcallback,selectplot,ax,Figdata}); %crea un control del tipo pushbutton para guardar el grafico actual
    
    loadfile=uicontrol('Parent',Figdata,'Position',[10 540 210 60],...
        'Style','pushbutton','String','Cargar Audio',...
        'FontSize',16); %crea un control del tipo pushbutton para cargar un audio a la interfaz
        loadfile.Callback={@Cargar,loadfile,text};%el callback se define despues para poder pasarle al mismo control como variable, por lo que es necesario definirla antes

    calculate=uicontrol('Parent',Figdata,'Position',[10 410 210 60],...
        'Style','pushbutton','String','Calcular',...  
        'FontSize',16,...
        'Callback',{@calculatecallback,tabledata,selectmethod,tipodebanda,loadfile,selectplot});%crea un control del tipo pushbutton para iniciar los calculos
end

function selectplotcallback(~,~,ax,selectplot,selecciongrafico)
%funcion que se encarga de graficar lo que el usuario desee
   if isempty(selectplot.UserData)==0 %bypass en caso de que no haya datos calculados
     hold off %reemplaza los graficos actuales
     fs=selectplot.UserData{7};
     i=selectplot.Value;
     k=1;
     if isempty(selecciongrafico.Value(selecciongrafico.Value==1))==0 %si existe el valor 1 en el vector plotchoose.Value ejecuta los comandos de adentro del if
         dbhs=selectplot.UserData{1};
         plot(ax,0:1/fs:length(dbhs(:,i))/fs-1/fs,dbhs(:,i),'b')
         leg(k)={'Hilbert Transform'}; %crea una posicion en el cell leg que va a usarse de legend
         k=k+1;
         hold on %conserva lo graficado para que el siguiente no lo reemplace 
     end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==2))==0
        dbhs010=selectplot.UserData{4}{i};
        m=dbhs010(1,1); %pendiente de la recta del ajuste de cuadrados minimos
        b=dbhs010(2,1);%ordenada al origen de la recta del ajuste de cuadrados minimos
        t=0:1/fs:(-100-b)/m-1/fs;%vector tiempo de la recta
        plot(ax,t,m*t+b,':r','MarkerSize',42)
        leg(k)={'Hilbert EDT'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==3))==0
        dbhs525=selectplot.UserData{4}{i};
        m=dbhs525(1,2);
        b=dbhs525(2,2);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,':g','MarkerSize',42)
        leg(k)={'Hilbert T20'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==4))==0
        dbhs535=selectplot.UserData{4}{i};
        m=dbhs535(1,3);
        b=dbhs535(2,3);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,':y','MarkerSize',42)
        leg(k)={'Hilbert T30'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==5))==0
        mm=selectplot.UserData{2};
        plot(ax,0:1/fs:length(mm(:,i))/fs-1/fs,mm(:,i),'m','MarkerSize',14)
        leg(k)={'Moving Filter'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==6))==0
        mm010=selectplot.UserData{5}{i};
        m=mm010(1,1);
        b=mm010(2,1);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,'-.r','MarkerSize',18)
        leg(k)={'Moving Filter EDT'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==7))==0
        mm525=selectplot.UserData{5}{i};
        m=mm525(1,2);
        b=mm525(2,2);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,'-.g','MarkerSize',18)
        leg(k)={'Moving Filter T20'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==8))==0
        mm535=selectplot.UserData{5}{i};
        m=mm535(1,3);
        b=mm535(2,3);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,'-.y','MarkerSize',18)
        leg(k)={'Moving Filter T30'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==9))==0
        dbsc=selectplot.UserData{3};
        plot(ax,0:1/fs:length(dbsc{i})/fs-1/fs,dbsc{i},'k')
        leg(k)={'Schroeder'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==10))==0
        dbsc010=selectplot.UserData{6}{i};
        m=dbsc010(1,1);
        b=dbsc010(2,1);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,'--r','MarkerSize',18)
        leg(k)={'Schroeder EDT'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==11))==0
        dbsc525=selectplot.UserData{6}{i};
        m=dbsc525(1,2);
        b=dbsc525(2,2);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,'--g','MarkerSize',18)
        leg(k)={'Schroeder T20'};
        k=k+1;
        hold on
    end
    if isempty(selecciongrafico.Value(selecciongrafico.Value==12))==0
        dbsc535=selectplot.UserData{6}{i};
        m=dbsc535(1,3);
        b=dbsc535(2,3);
        t=0:1/fs:(-100-b)/m-1/fs;
        plot(ax,t,m*t+b,'--y','MarkerSize',18)
        leg(k)={'Schroeder T30'};
        k=k+1;
        hold on
    end
    xlabel(ax,'Tiempo [s]','FontSize',12,'FontWeight','bold')
    ylabel(ax,'Nivel [dB]','FontSize',12,'FontWeight','bold')
    title(ax,'Respuesta Impulsiva','FontWeight','bold','FontSize',14)
    legend(leg)
    
   end
end

function selectmethodcallback(~,~,table,selectmethod)
if isempty(table.UserData)==0 %si elhay datos guardados en el UserData de la tabla ejecuta los comandos de adentro del if
    table.Data=table.UserData{selectmethod.Value}; %cambia los datos que se muestran en la tabla por los datos del metodo seleccionado
end
end

function savetablecallback(~,~,tabledata)
try
if isempty(tabledata.Data)==0 %si elhay datos guardados en el UserData de la tabla ejecuta los comandos de adentro del if
    [b,a]=uiputfile({'*.txt';'*.dat';'*.csv';'*.xls';'*.xlsm';'*.xlsx'},'Guardar Tabla'); %abre una ventana para que el usuario elija un nombre, ubicacion y extension para el archivo que se va a guardar
    if isequal(a,b,0)==0 %si se selecciono como y donde guardar la informacion ejecuta los comandos de adentro del if
    t=array2table(tabledata.Data); %crea una tabla que no se ve con los datos de la tabla de la interfaz para poder guardarla
    for i=1:size(tabledata.ColumnName,1)
        ColumnName{i}=['B' tabledata.ColumnName{i}]; %agrega una B a los nombres de las columnas para poder guardarlos como nombres de variables
    end
    t.Properties.VariableNames=ColumnName;  
    t.Properties.RowNames=tabledata.RowName;
    writetable(t,[a b],'WriteRowNames',true) %guarda la nueva tabla con el nombre y carpeta seleccionados 
    end
end
catch
    error('Error al guardar la tabla');
end
end

function calculatecallback(~,~,tabledata,selectmethod,tipodebanda,loadfile,selectplot)
try
    if isempty(loadfile.UserData)==0 %si hay algun archivo cargado ejecuta el interior del if
        [y, fs]=audioread(loadfile.UserData); %lee el archivo que se selecciono
        [s, v]=octavefilter(y,2*tipodebanda.Value-1); %filtra la señal por tercio de octava o octava segun se haya seleccionado
        hs=abs(hilbert(s)); %suaviza la señal mediante el metodo de Hilbert
        hs(hs==0)=eps; %reemplaza los posibles valores que sean iguales a cero para evitar indeterminaciones cuando se pase a dB la señal
        hs=hs./(ones(size(hs,1),1)*max(hs)); %normaliza cada una de las bandas segun el valor maximo de cada una
        dbhs=20*log10(hs); %pasa a dB la señal suavizada con Hilbert
        wait_bar=waitbar(0,'Calculando 0%','WindowStyle','modal'); %crea una waitbar para que el usuario sepa si se esta calculando 
        for i=1:size(hs,2) %realiza los calculos para cada uno de los canales
            mm(:,i)=mediamovil(dbhs(:,i),2000); %suaviza la señal con el filtro de media movil 
            td=schroederlimit(mm(:,i)); %calcula el limite de integracion para el metodo de Schroeder
            dbsc{i}=20*log10(abs(schroeder(hs(:,i),td))); %suaviza la señal con el metodo de Schroeder y la pasa a dB
            vdbsc=dbsc{i};
            vdbhs=dbhs(:,i);
            vmm=mm(:,i);
            [t010dbsc,t525dbsc,t535dbsc]=Tcalculator(vdbsc);%calcula las posiciones de las muestras que se encuentran entre los niveles requeridos para calcular EDT T20 T30
            [t010mm,t525mm,t535mm]=Tcalculator(vmm);
            [t010dbhs,t525dbhs,t535dbhs]=Tcalculator(vdbhs);
            [m010dbsc,b010dbsc]=cuadradosminimos(t010dbsc/fs-1/fs,vdbsc(t010dbsc)); %ajusta mediante cuadrados minimos el a los valores del intervalo de interes
            [m010dbhs,b010dbhs]=cuadradosminimos(t010dbhs/fs-1/fs,vdbhs(t010dbhs));%este metodo se realiza para cada uno de los metodos y para cada uno de los descriptores
            [m010mm,b010mm]=cuadradosminimos(t010mm/fs-1/fs,vmm(t010mm));%el valor de las absisas se pasa en segundos
            [m525dbsc,b525dbsc]=cuadradosminimos(t525dbsc/fs-1/fs,vdbsc(t525dbsc));
            [m525dbhs,b525dbhs]=cuadradosminimos(t525dbhs/fs-1/fs,vdbhs(t525dbhs));
            [m525mm,b525mm]=cuadradosminimos(t525mm/fs-1/fs,vmm(t525mm));
            [m535dbsc,b535dbsc]=cuadradosminimos(t535dbsc/fs-1/fs,vdbsc(t535dbsc));
            [m535dbhs,b535dbhs]=cuadradosminimos(t535dbhs/fs-1/fs,vdbhs(t535dbhs));
            [m535mm,b535mm]=cuadradosminimos(t535mm/fs-1/fs,vmm(t535mm));
            polidbsc{i}=[[m010dbsc,b010dbsc]' [m525dbsc,b525dbsc]' [m535dbsc,b535dbsc]'];%guarda en un cell cada una de las pendientes y ordenadas al origen de para poder graficar
            polidbhs{i}=[[m010dbhs,b010dbhs]' [m525dbhs,b525dbhs]' [m535dbhs,b535dbhs]'];%guarda distintos cell segun el suavizado seleccionado
            polimm{i}=[[m010mm,b010mm]' [m525mm,b525mm]' [m535mm,b535mm]'];
            Ths(:,i)=[-60/m010dbhs;-60/m525dbhs;-60/m535dbhs];%calcula el RT60 dividiendo -60 por la pendiente de la recta de ajuste y lo guarda en una variable
            Tmm(:,i)=[-60/m010mm;-60/m525mm;-60/m535mm];%para cada columna corresponde un canal 
            Tsc(:,i)=[-60/m010dbsc;-60/m525dbsc;-60/m535dbsc];%guarda en distintas variables los resultados de los distintos metodos utilizados
            waitbar(i/size(hs,2),wait_bar,['Calculando ' num2str(round((i*100)/size(hs,2))) '%']); %actualiza el valor del waitbar
        end
        selectplot.UserData={dbhs,mm,dbsc,polidbhs,polimm,polidbsc,fs}; %guarda en el UserData de selectplot todas las bandas de las señales suavizadas con distintos metodos y la informacion de las rectas de ajuste lineal
        selectplot.String={round(v)}; %define como bandas para graficar las frecuencias centrales validas
        tabledata.UserData={Ths,Tmm,Tsc}; %guarda en el UserData de la tabla los resultados para los distintos metodos
        tabledata.Data=tabledata.UserData{selectmethod.Value}; %selecciona como datos para mostrar en la tabla al metodo seleccionado actualmente
        tabledata.ColumnWidth={floor((tabledata.Position(3)-41)/(12*tipodebanda.Value-6))}; %define ancho de las columnas de la tabla
        tabledata.Position(3)=tabledata.Extent(3)-2; %define ancho de la tabla
        tabledata.ColumnName={round(v)};%define nombre de las columnas de la tabla
        delete(wait_bar)     %elimina la waitbar
    end
catch
    error('Error al calcular');
end
end

function saveplotcallback(~,~,selectplot,ax,d)
%guarda el grafico actual
try
if isempty(selectplot.UserData)==0 %si hay datos para graficar guardados ejecuta los comandos de adentro del if
    f=figure('Position',[50 50 620 470],'Visible','off'); %crea una figura no visible
    ax.Parent=f;%define a los ejes en la nueva figura
    position=ax.Position;%guarda la posicion original de los ejes
    ax.Position=[55 50 560 390]; %centra a los ejes en la nueva figura
    [b,a]=uiputfile({'*.jpg';'*.png';'*.fig'},'Guardar Gráfico');%abre una ventana para seleccionar el nombre, la ubicacion y la extension con la que se va a guardar el archivo
    if isequal(a,b,0)==0 %si se selecciono nonbre ubicacion y extension, guarda el archivo
        saveas(f,[a b])
    end
    ax.Position=position;%restituye la posicion original 
    ax.Parent=d;%define a los ejes en la interfaz
end
catch
    error('Error al guardar el gráfico');
end
end

function Cargar(~,~,loadfile,text)
try
[archivo,ruta]=uigetfile({'*.wav'},'Cargar Audio'); %abre una ventana para seleccionar nombre ubicacion y extension del archivo que se va a cargar
    if isequal(ruta,archivo,0)==0 %si se seleccionaron datos para cargar, guarda el nombre, ubicacion y extension del archivo 
        text.audioname.String=archivo;
        loadfile.UserData=[ruta archivo];
    end
catch
    error('Error al cargar el audio');
end
end