%% ###### SEGUNDA PARTE ######

dspfigure = figure('Visible','off','units','normalized','Position',[0 0 1 0.96],...
    'Name','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
    'NumberTitle','off','toolbar','none');dspfigure.MenuBar = 'none';

%% ###### TITULO y LOGO ######
% Titulo
titulodsp = uicontrol('parent',dspfigure,'style','text',...
        'string','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
        'units','normalized','position',[0.15 0.865 0.70 0.11],'fontsize',24,...
        'backgroundcolor',[3/255 0 104/255]  ,'foregroundcolor',[1 1 1],'fontweight','bold');

% Logo
logodsp = axes('units','normalized','position',[0.04 0.865 0.10 0.11]);
axes(logodsp);
imshow('UNTREF-LOGO.png');

grafico_fondo = uicontrol('parent',dspfigure,'style','text','units','normalized','position',[0.41 0.3 0.1 0.45],'string',''...
     ,'BackGroundColor',[200/255 200/255 200/255]);
grafico_fondo_1 = uicontrol('parent',dspfigure,'style','text','units','normalized','position',[0.6 0.08 0.37 0.15],'string',''...
     ,'BackGroundColor',[200/255 200/255 200/255]);

% Popupmenu 
graficodsp_bandaspumoct = uicontrol('parent',dspfigure,'style','popup','units','normalized','position',....
    [0.42 0.65 0.08 0.05],'string',{'125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]'}...
    ,'Visible','off','Value',4);
% Popupmenu 
graficodsp_bandaspumter = uicontrol('parent',dspfigure,'style','popup','units','normalized','position',....
    [0.42 0.65 0.08 0.05],'string',{'125 [Hz]';'160 [Hz]';'200 [Hz]';'250 [Hz]';'315 [Hz]';'400 [Hz]';'500 [Hz]';...
    '630 [Hz]';'800 [Hz]';'1000 [Hz]';'1250 [Hz]';'1600 [Hz]';'2000 [Hz]';'2500 [Hz]';'3150 [Hz]'...
    ;'4000 [Hz]';'5000 [Hz]';'6300 [Hz]';'8000 [Hz]'},'Visible','off','Value',10);

%% ########## TABLA ########

tabla.titulo = uicontrol('parent',dspfigure,'style','text','string','Tabla de resultados',...
        'units','normalized','position',[0.03 0.26 0.35 0.05],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
tabladsp = uitable('Parent', dspfigure,'units','normalized','Position',[0.03 0.08 0.55 0.16],...
    'RowName',{'EDT [s]','TR10 [s]','TR20 [s]','TR30 [s]'},'BackgroundColor',[0.7 0.75 0.8]);
    % Pushbutton de 'Exportar tabla' está al final del Back-end por
    % cuestiones de sintaxis de MatLab
%% ###### FILTROS Y SELECCION DE IR ######
% Textbox

filtros_titulo = uicontrol('parent',dspfigure,'style','text','string','Tipos de filtros y selección de IR',...
        'units','normalized','position',[0.03 0.59 0.35 0.05],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
filtros_impulsotext = uicontrol('parent',dspfigure,'style','text','string','Impulsos creados','units','normalized',...
        'position',[0.04 0.53 0.1 0.05],'fontsize',11);

% Buttongroup Extremos
filtros_exitacion_bg = uibuttongroup('parent',dspfigure,'units','normalized','position',[0.15 0.40 0.22 0.08],'title',...
    'Bandas de exitación: ','fontsize',10) ; 
% Popup Menu's
filtros_exitacion_inf = uicontrol('parent',filtros_exitacion_bg,'style','popupmenu','units','normalized','position',[0.05 0 0.4 0.8],...
    'string',' ');
filtros_exitacion_a = uicontrol('parent',filtros_exitacion_bg,'style','text','units','normalized','position',[0.45 0 0.1 0.8],...
    'string','a','fontsize',11);
filtros_exitacion_sup = uicontrol('parent',filtros_exitacion_bg,'style','popupmenu','units','normalized','position',[0.55 0 0.4 0.8],...
    'string',' ');
% Buttongroup Filtro
filtros_buttongroup = uibuttongroup('parent',dspfigure,'units','normalized','position',[0.15 0.49 0.22 0.07],'title',...
    'Tipo de filtro: ','fontsize',10,'SelectionChangedFcn',{@selectfiltro,filtros_exitacion_inf,filtros_exitacion_sup}) ; 

% Radiobuttons
    filt_octava = uicontrol('parent',filtros_buttongroup,'units','normalized','style','radiobutton','position',[0.1 0 0.4 1],...
        'string','Octava');
    filt_teroctava = uicontrol('parent',filtros_buttongroup,'units','normalized','style','radiobutton','position',[0.5 0 0.4 1],...
        'string','Tercio de Octava');
    filt_octava.Value = 0;
    filt_teroctava.Value = 0;
% Listbox
filtros_listbox = uicontrol('parent',dspfigure,'style','list','string','','units','normalized','position',...
    [0.04 0.365 0.1 0.18]);
%Actualización inicial del listbox.    
try
    cd Tomas
        impulsos = dir('IRs');
        cd ..\
    listadeimpulsos = struct2cell(impulsos);
    listadeimpulsos = listadeimpulsos(1,3:end);
    filtros_listbox.String = listadeimpulsos;
catch
end
% Pushbutton's
filtros_addir = uicontrol('parent',dspfigure','style','pushbutton','string','Añadir IR externo','units','normalized',...
        'position',[0.04 0.33 0.1 0.03],'callback',{@irexterno,filtros_listbox});

    % Los dos botones que restan estan al final del back-end por cuestiones
    % de sintaxis de MatLab

%% ###### GRAFICOS DSP ######

% Textbox's
graficosdsp_titulo = uicontrol('parent',dspfigure,'style','text','string','Gráficos',...
        'units','normalized','position',[0.4 0.79 0.57 0.050],'fontsize',20,...
        'backgroundcolor',[1 98/255 98/255]);

graficodsp_bandatext = uicontrol('parent',dspfigure,'style','text','units','normalized','position',[0.41 0.705 0.1 0.035],'string',...
    'Banda','fontsize',12,'BackGroundColor',[200/255 200/255 200/255]);
% Checkboxs
graficodsp.schroedercheck = uicontrol('parent',dspfigure,'style','checkbox','units','normalized','position',[0.43 0.615 0.06 0.035],...
    'string','Schroeder','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.EDTcheck = uicontrol('parent',dspfigure,'style','checkbox','units','normalized','position',[0.43 0.565 0.06 0.035],...
    'string','EDT','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.T10check = uicontrol('parent',dspfigure,'style','checkbox','units','normalized','position',[0.43 0.515 0.06 0.035],...
    'string','T10','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.T20check = uicontrol('parent',dspfigure,'style','checkbox','units','normalized','position',[0.43 0.465 0.06 0.035],...
    'string','T20','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.T30check = uicontrol('parent',dspfigure,'style','checkbox','units','normalized','position',[0.43 0.415 0.06 0.035],...
    'string','T30','BackGroundColor',[200/255 200/255 200/255]);
% Axes
graficodsp_axes = axes('units','normalized','position',[0.57 0.3 0.4 0.45]);xlabel('');ylabel('');title('');

% Pushbutton
graficosdsp_plot = uicontrol('parent',dspfigure,'style','pushbutton','string','Graficar','units','normalized',...
    'position',[0.42 0.365 0.08 0.035],'callback',...
    {@graficardsp,graficodsp_bandaspumoct,graficodsp_bandaspumter,graficodsp_axes,filt_octava,filt_teroctava,filtros_listbox,graficodsp});
graficodsp_export = uicontrol('parent',dspfigure,'style','pushbutton','string','Exportar gráfico','units','normalized',...
    'position',[0.42 0.325 0.08 0.035]);

%% ###### CREACIÓN DEL IMPULSO #####
%Textbox
imp.titulo = uicontrol('parent',dspfigure,'style','text','string','Generación del IR',...
        'units','normalized','position',[0.03 0.79 0.35 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
imp.descripcion = uicontrol('parent',dspfigure,'style','text','units','normalized','string',...
    ['El generador de IR funciona convolucionando la toma seleccionada con el ' ...
    'filtro inverso generado en el momento de la medición'],'position',[0.035 0.66 0.175 0.08]);
    imp.descripcion.HorizontalAlignment = 'center';

% Pushbuttons

imp.selecciondetomas_wav = uicontrol('parent',dspfigure,'style','pushbutton','units','normalized',...
    'position',[0.22 0.68 0.14 0.05],'string','Selección de tomas en formato .wav','callback',...
    {@selecciondetomaswav,filtros_listbox});
%% Pushbuttons Filtrado

filtros_process = uicontrol('parent',dspfigure,'style','pushbutton','string','Procesar impulso','units','normalized',...
        'position',[0.15 0.33 0.11 0.05],'fontsize',11,'callback',...
        {@processsignal,filtros_listbox,filt_octava,filt_teroctava,tabladsp,graficodsp_bandaspumter,graficodsp_bandaspumoct,graficodsp,filtros_exitacion_inf,filtros_exitacion_sup});
filtros_promedio = uicontrol('parent',dspfigure,'style','pushbutton','string','Promediar impulsos','units','normalized',...
        'position',[0.26 0.33 0.11 0.05],'fontsize',11,'callback',...
        {@promediosignal,filt_octava,filt_teroctava,tabladsp,filtros_exitacion_inf,filtros_exitacion_sup});
    
%% Pushbutton Exportar tabla

tabla_exportar = uicontrol('parent',dspfigure,'style','pushbutton','string','Exportar tabla',...
        'units','normalized','position',[0.48 0.02 0.1 0.05],'callback',{@exportar_csv,tabladsp});
 
%% #######################################################################
%% ###########################FUNCIONES###################################
%% Generador de IRS
% Importar tomas en wav
function selecciondetomaswav(object_handle,event,filtros_listbox)
    cd Tomas\Formato_wav
        [file,path] = uigetfile('*.wav','Seleccione las tomas que desee generar el IR','','MultiSelect','on');
        cd ..\..
        file = string(file);
        path_actual = pwd;
        for i=1:length(file)
            nametoma = [ char(path) char(file(i))] ;
            [h] = irwav(nametoma);
            % Metodo para recortar el IR 
            h_inf = find(abs(h) == max(abs(h)));
            [h] = h(h_inf:(h_inf+2*44100));
            nameir = [path_actual '\Tomas\IRs\IR_' char(file(i))];
            audiowrite(nameir,h,44100);
        end
        cd Tomas
            impulsos = dir('IRs');
            cd ..\
        listadeimpulsos = struct2cell(impulsos);
        listadeimpulsos = listadeimpulsos(1,3:end);
        filtros_listbox.String = listadeimpulsos;
        msgbox('La generación de IRs fue exitosa');
end

% Añadir IR externo
function irexterno(object_handle,event,filtros_listbox)
    [file,path] = uigetfile('*.wav','Seleccione las IR que desea importar','','MultiSelect','on');
    file = string(file);
    for i=1:length(file)
        cd Tomas
        copyfile([path char(file(i))],'IRs');
        cd ..\
    end
    cd Tomas
        impulsos = dir('IRs');
        cd ..\
    listadeimpulsos = struct2cell(impulsos);
    listadeimpulsos = listadeimpulsos(1,3:end);
    filtros_listbox.String = listadeimpulsos;
    
end
% Asignación de las bandas de exitacion
function selectfiltro(source,event,filtros_exitacion_inf,filtros_exitacion_sup)
    filtro = event.NewValue.String;
    switch filtro
        case 'Octava'
            filtros_exitacion_inf.String = {'31.5 [Hz]' '63 [Hz]' '125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]' '16000 [Hz]'};
            filtros_exitacion_sup.String = {'31.5 [Hz]' '63 [Hz]' '125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]' '16000 [Hz]'};
            filtros_exitacion_inf.Value = 3;
            filtros_exitacion_sup.Value = 9;
        case 'Tercio de Octava'
            filtros_exitacion_inf.String = {'25 [Hz]';'31.5 [Hz]';'40 [Hz]';'50 [Hz]';'63 [Hz]';'80 [Hz]';...
    '100 [Hz]';'125 [Hz]';'160 [Hz]';'200 [Hz]';'250 [Hz]';'315 [Hz]';'400 [Hz]';'500 [Hz]';...
    '630 [Hz]';'800 [Hz]';'1000 [Hz]';'1250 [Hz]';'1600 [Hz]';'2000 [Hz]';'2500 [Hz]';'3150 [Hz]'...
    ;'4000 [Hz]';'5000 [Hz]';'6300 [Hz]';'8000 [Hz]';'10000 [Hz]';'12500 [Hz]';'16000 [Hz]'};
            filtros_exitacion_sup.String = {'25 [Hz]';'31.5 [Hz]';'40 [Hz]';'50 [Hz]';'63 [Hz]';'80 [Hz]';...
    '100 [Hz]';'125 [Hz]';'160 [Hz]';'200 [Hz]';'250 [Hz]';'315 [Hz]';'400 [Hz]';'500 [Hz]';...
    '630 [Hz]';'800 [Hz]';'1000 [Hz]';'1250 [Hz]';'1600 [Hz]';'2000 [Hz]';'2500 [Hz]';'3150 [Hz]'...
    ;'4000 [Hz]';'5000 [Hz]';'6300 [Hz]';'8000 [Hz]';'10000 [Hz]';'12500 [Hz]';'16000 [Hz]'};
            filtros_exitacion_inf.Value = 8;
            filtros_exitacion_sup.Value = 26;
    end
end
 %% Procesamiento de la señal
 function processsignal(~,~,filtros_listbox,filt_octava,filt_teroctava,tabladsp,graficodsp_bandaspumter,graficodsp_bandaspumoct,graficodsp,filtros_exitacion_inf,filtros_exitacion_sup)
     loadingbar = waitbar(0,'...Procesando señal...'); 
     pasos = 8;
    try        
        impulso = get(filtros_listbox,'String');
        index = get(filtros_listbox,'Value');
        impulso = impulso(index);           % Obtencion de la selección del listbox
        impulso = char(impulso);
     catch
        errordlg('Seleccione un IR','Error')
     end
     graficodsp.schroedercheck.Value = 1;
     graficodsp.EDTcheck.Value = 1;
     graficodsp.T10check.Value = 1;
     graficodsp.T20check.Value = 1;
     graficodsp.T30check.Value = 1;
      waitbar(1/pasos);
     path_actual = pwd;
     h_t = [path_actual '\Tomas\IRs\' impulso]; % Cargado del IR
     [h_t, Fs] = audioread(h_t);
      waitbar(2/pasos)
    if get(filt_octava,'Value') == 1
        div_oct = 1;                   % Selección del tipo de filtro
        graficodsp_bandaspumoct.Visible = 'on';
        graficodsp_bandaspumter.Visible = 'off';
        if Fs == 44100
            tabladsp.ColumnName = {'31.5 [Hz]' '63 [Hz]' '125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]'};
        elseif Fs == 48000
            tabladsp.ColumnName = {'31.5 [Hz]' '63 [Hz]' '125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]' '16000 [Hz]'};
        end
    elseif get(filt_teroctava,'Value') == 1 
        div_oct = 3;
        graficodsp_bandaspumter.Visible = 'on';
        graficodsp_bandaspumoct.Visible = 'off';
        tabladsp.ColumnName = {'25 [Hz]';'31.5 [Hz]';'40 [Hz]';'50 [Hz]';'63 [Hz]';'80 [Hz]';...
    '100 [Hz]';'125 [Hz]';'160 [Hz]';'200 [Hz]';'250 [Hz]';'315 [Hz]';'400 [Hz]';'500 [Hz]';...
    '630 [Hz]';'800 [Hz]';'1000 [Hz]';'1250 [Hz]';'1600 [Hz]';'2000 [Hz]';'2500 [Hz]';'3150 [Hz]'...
    ;'4000 [Hz]';'5000 [Hz]';'6300 [Hz]';'8000 [Hz]';'10000 [Hz]';'12500 [Hz]';'16000 [Hz]'};
    else
        errordlg('Seleccione un tipo de filtro','Error')
    end
     waitbar(3/pasos)
    max_signal = find(abs(h_t) == max(abs(h_t)),1,'first');
    h_t = h_t(max_signal:end);
    [h_t_filtrada,fcentrales] = filtbutterwav(h_t,div_oct,1000,Fs);
    vector_max = max(h_t_filtrada);
    matriz_max = ones(length(h_t),1)*vector_max;
    h_t_filtrada = h_t_filtrada./matriz_max;
    waitbar(4/pasos)
    columnas = length(h_t_filtrada(1,:));
    for i=1:columnas
        [t_plot,w,h_t_MAF,t_plot_shroeder,z] = suavizadoconlim(h_t_filtrada(:,i),Fs);
        suavizadoperband.band = fcentrales(i);
        suavizadoperband.t_plot = t_plot;
        suavizadoperband.w = w;
        suavizadoperband.h_t_MAF = h_t_MAF;
        suavizadoperband.t_plot_shroeder = t_plot_shroeder;
        suavizadoperband.z = z;
        suavizadoporbanda{i} = suavizadoperband;
    end
     waitbar(5/pasos)
    for j=1:columnas
        h_t_suavizada = suavizadoporbanda{j}.z;
        t_plot_shroeder = suavizadoporbanda{j}.t_plot_shroeder;
        [EDT,T10,T20,T30] = calcular_parametros(h_t_suavizada,t_plot_shroeder);
        parametros.band = fcentrales(j);
        parametros.EDT = EDT;
        parametros.T10 = T10;
        parametros.T20 = T20;
        parametros.T30 = T30;
        parametrosporbanda{j} = parametros;
    end
    waitbar(6/pasos)
    matrizresultados = zeros(4,columnas);
    for k=1:columnas
        matrizresultados(1,k) = parametrosporbanda{k}.EDT ;
        matrizresultados(2,k) = parametrosporbanda{k}.T10 ;
        matrizresultados(3,k) = parametrosporbanda{k}.T20 ;
        matrizresultados(4,k) = parametrosporbanda{k}.T30 ;
    end
    ex_inf = get(filtros_exitacion_inf,'Value');
    ex_sup = get(filtros_exitacion_sup,'Value');
    [filas,columnas] = size(matrizresultados);     
    matrizresultados = mat2cell(matrizresultados,ones(filas,1),ones(1,columnas));
    waitbar(7/pasos)
    try
    for extremo_inf=1:(ex_inf-1)
        for rowindex=1:4 
        matrizresultados{rowindex,extremo_inf} = '-';
        end
    end
    catch
    end
    rowindex = 0;
    try
    for extremo_sup=(ex_sup+1):columnas
        for rowindex=1:4 
        matrizresultados{rowindex,extremo_sup} = '-';
        end
    end
    catch
    end
    
    tabladsp.Data = matrizresultados;
    waitbar(8/pasos)
    close(loadingbar)
    save('suavizadorbanda.mat',suavizadoporbanda);
%     save('Fs.mat',Fs);
%     save('matrizresultados.mat',matrizresultados);
%     save suavizadoporbanda
 end
 %% PROMEDIOS SIGNALS
 function promediosignal(object_handle,event,filt_octava,filt_teroctava,tabladsp,filtros_exitacion_inf,filtros_exitacion_sup)
    try
        cd Tomas\IRs
            [file,path] = uigetfile('*.wav','Seleccione las IRs que desea promediar','','MultiSelect','on');
            cd ..\..
        file = string(file);
    catch
    end
    loadingbar = waitbar(0,'...Procesando Señales...');
    pasos = 11;

    for p=1:length(file)            % Comienzo del ciclo for para el promediado
        waitbar(1/pasos)
        name_IR = [path char(file(p))];
        [h_t, Fs] = audioread(name_IR);
            if get(filt_octava,'Value') == 1
            div_oct = 1;                   % Selección del tipo de filtro
                if Fs == 44100
                    tabladsp.ColumnName = {'31.5 [Hz]' '63 [Hz]' '125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]'};
                elseif Fs == 48000
                    tabladsp.ColumnName = {'31.5 [Hz]' '63 [Hz]' '125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]' '16000 [Hz]'};
                end
            elseif get(filt_teroctava,'Value') == 1 
                div_oct = 3;
                tabladsp.ColumnName = {'25 [Hz]';'31.5 [Hz]';'40 [Hz]';'50 [Hz]';'63 [Hz]';'80 [Hz]';...
    '100 [Hz]';'125 [Hz]';'160 [Hz]';'200 [Hz]';'250 [Hz]';'315 [Hz]';'400 [Hz]';'500 [Hz]';...
    '630 [Hz]';'800 [Hz]';'1000 [Hz]';'1250 [Hz]';'1600 [Hz]';'2000 [Hz]';'2500 [Hz]';'3150 [Hz]'...
    ;'4000 [Hz]';'5000 [Hz]';'6300 [Hz]';'8000 [Hz]';'10000 [Hz]';'12500 [Hz]';'16000 [Hz]'};
            else
                errordlg('Seleccione un tipo de filtro','Error');
            end
        waitbar(2/pasos)    
        max_signal = find(abs(h_t) == max(abs(h_t)),1,'first');
        h_t = h_t(max_signal:end);
        [h_t_filtrada,fcentrales] = filtbutterwav(h_t,div_oct,1000,Fs);
        vector_max = max(h_t_filtrada);
        matriz_max = ones(length(h_t),1)*vector_max;
        h_t_filtrada = h_t_filtrada./matriz_max;
        waitbar(3/pasos)
        for i=1:length(h_t_filtrada(1,:))
            [t_plot,w,h_t_MAF,t_plot_shroeder,z] = suavizadoconlim(h_t_filtrada(:,i),Fs);
            suavizadoperband.band = fcentrales(i);
            suavizadoperband.t_plot = t_plot;
            suavizadoperband.w = w;
            suavizadoperband.h_t_MAF = h_t_MAF;
            suavizadoperband.t_plot_shroeder = t_plot_shroeder;
            suavizadoperband.z = z;
            suavizadoporbanda{i} = suavizadoperband;
        end
        waitbar(4/pasos)
        for j=1:length(h_t_filtrada(1,:))
            h_t_suavizada = suavizadoporbanda{j}.z;
            t_plot_shroeder = suavizadoporbanda{j}.t_plot_shroeder;
            [EDT,T10,T20,T30] = calcular_parametros(h_t_suavizada,t_plot_shroeder);
            parametros.band = fcentrales(j);
            parametros.EDT = EDT;
            parametros.T10 = T10;
            parametros.T20 = T20;
            parametros.T30 = T30;
            parametrosporbanda{j} = parametros;
        end
        waitbar(5/pasos)
        matrizresultados = zeros(4,length(h_t_filtrada(1,:)));
        for k=1:length(h_t_filtrada(1,:))
            matrizresultados(1,k) = parametrosporbanda{k}.EDT ;
            matrizresultados(2,k) = parametrosporbanda{k}.T10 ;
            matrizresultados(3,k) = parametrosporbanda{k}.T20 ;
            matrizresultados(4,k) = parametrosporbanda{k}.T30 ;
        end
        promedio_matriz{p} = matrizresultados;
        waitbar(6/pasos)
    end
    waitbar(7/pasos)
    acumulador = zeros(4,length(h_t_filtrada(1,:)));
    for pfinal=1:length(file)
        acumulador = acumulador + promedio_matriz{pfinal};
    end
    waitbar(8/pasos)
    promedio_parametros = acumulador./length(file);
    matrizresultados = promedio_parametros;
    waitbar(9/pasos)
    ex_inf = get(filtros_exitacion_inf,'Value');
    ex_sup = get(filtros_exitacion_sup,'Value');
    [filas,columnas] = size(matrizresultados);     
    matrizresultados = mat2cell(matrizresultados,ones(filas,1),ones(1,columnas));
    waitbar(10/pasos)
    try
    for extremo_inf=1:(ex_inf-1)
        for rowindex=1:4 
        matrizresultados{rowindex,extremo_inf} = '-';
        end
    end
    catch
    end
    rowindex = 0;
    try
    for extremo_sup=(ex_sup+1):columnas
        for rowindex=1:4 
        matrizresultados{rowindex,extremo_sup} = '-';
        end
    end
    catch
    end
    
    tabladsp.Data = matrizresultados;
    waitbar(11/pasos)
    close(loadingbar)
 end
 %% GRAFICAR PARAMETROS
 function graficardsp(~,~,graficodsp_bandaspumoct,graficodsp_bandaspumter,graficodsp_axes,filt_octava,filt_teroctava,filtros_listbox,graficodsp,suavizadoporbanda)
    if get(filt_octava,'Value')==1
        filtro_pum = get(graficodsp_bandaspumoct,'Value');
        banda = filtro_pum + 2 ;
        titulobanda = get(graficodsp_bandaspumoct,'String');
        titulobanda = titulobanda(filtro_pum);
    elseif get(filt_teroctava,'Value')==1
        filtro_pum = get(graficodsp_bandaspumter,'Value');
        banda = filtro_pum + 7 ;
        titulobanda = get(graficodsp_bandaspumter,'String');
        titulobanda = titulobanda(filtro_pum);
    end
        axes(graficodsp_axes);
        cla(graficodsp_axes)
        [plot_EDT,plot_T10,plot_T20,plot_T30,plot_schroeder] = GraficosParametros(banda,suavizadoporbanda);
        if get(graficodsp.schroedercheck,'Value') == 1
            set(plot_schroeder,'Visible','on');
        else
            set(plot_schroeder,'Visible','off');
        end
        if get(graficodsp.EDTcheck,'Value')==1
            set(plot_EDT,'Visible','on');
        else
            set(plot_EDT,'Visible','off');
        end
        if get(graficodsp.T10check,'Value')==1
            set(plot_T10,'Visible','on');
        else 
            set(plot_T10,'Visible','off');
        end
        if get(graficodsp.T20check,'Value')==1
            set(plot_T20,'Visible','on');
        else
            set(plot_T20,'Visible','off');
        end
        if get(graficodsp.T30check,'Value')==1
            set(plot_T30,'Visible','on');
        else
            set(plot_T30,'Visible','off');
        end
        tituloIR_name = get(filtros_listbox,'String');
        tituloIR_value = get(filtros_listbox,'Value');
        tituloIR = tituloIR_name(tituloIR_value);
        titulo = [char(tituloIR) ' - ' char(titulobanda)];
        title(titulo,'Interpreter','none');xlabel('Tiempo [s]');ylabel('E(t) [dB]')
 end
 %% Exportar Tabla
function exportar_csv(object_handle,event,tabladsp)
 M =  tabladsp.Data ;
 J = numel(M);
 if J == 36 
    tabla_1 = table({' ';'EDT';'T10';'T20';'T30'},{'31.5[Hz]';M(1,1);M(2,1);M(3,1);M(4,1)},...
          {'63[Hz]';M(1,2);M(2,2);M(3,2);M(4,2)},...
          {'250[Hz]';M(1,3);M(2,3);M(3,3);M(4,3)},...
          {'500[Hz]';M(1,4);M(2,4);M(3,4);M(4,4)},...
          {'1000[Hz]';M(1,5);M(2,5);M(3,5);M(4,5)},...
          {'2000[Hz]';M(1,6);M(2,6);M(3,6);M(4,6)},...
          {'4000[Hz]';M(1,7);M(2,7);M(3,7);M(4,7)},...
          {'8000[Hz]';M(1,8);M(2,8);M(3,8);M(4,8)});
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Resultados\ParametrosAcusticos_FiltroOctava.csv'] ;
    writetable(tabla_1,name_csv)
    warndlg('Resultados guardadados correctamente en formato .csv dentro de la carpeta "Resultados"',' ');
 
 elseif J == 40
    tabla_1 = table({' ';'EDT';'T10';'T20';'T30'},{'31.5[Hz]';M(1,1);M(2,1);M(3,1);M(4,1)},...
          {'63[Hz]';M(1,2);M(2,2);M(3,2);M(4,2)},...
          {'250[Hz]';M(1,3);M(2,3);M(3,3);M(4,3)},...
          {'500[Hz]';M(1,4);M(2,4);M(3,4);M(4,4)},...
          {'1000[Hz]';M(1,5);M(2,5);M(3,5);M(4,5)},...
          {'2000[Hz]';M(1,6);M(2,6);M(3,6);M(4,6)},...
          {'4000[Hz]';M(1,7);M(2,7);M(3,7);M(4,7)},...
          {'8000[Hz]';M(1,8);M(2,8);M(3,8);M(4,8)},...
          {'16000[Hz]';M(1,9);M(2,9);M(3,9);M(4,9)});
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Resultados\ParametrosAcusticos_FiltroOctava.csv'] ;
    writetable(tabla_1,name_csv)
    warndlg('Resultados guardadados correctamente en formato .csv dentro de la carpeta "Resultados"',' ');
 
 else     
     tabla_2 = table({' ';'EDT';'T10';'T20';'T30'},{'25[Hz]';M(1,1);M(2,1);M(3,1);M(4,1)},{'31.5[Hz]';M(1,2);M(2,2);M(3,2);M(1,2)},...
         {'40[Hz]';M(1,3);M(2,3);M(3,3);M(4,3)},{'50[Hz]';M(1,4);M(2,4);M(3,4);M(4,4)},{'63 [Hz]';M(1,5);M(2,5);M(3,5);M(4,5)},...
         {'80 [Hz]';M(1,6);M(2,6);M(3,6);M(4,6)},{'100[Hz]';M(1,7);M(2,7);M(3,7);M(4,7)},{'125[Hz]';M(1,8);M(2,8);M(3,8);M(4,8)},...
         {'160[Hz]';M(1,9);M(2,9);M(3,9);M(4,9)},{'200 [Hz]';M(1,10);M(2,10);M(3,10);M(4,10)},{'250 [Hz]';M(1,11);M(2,11);M(3,11);M(4,11)},...
         {'315[Hz]';M(1,12);M(2,12);M(3,12);M(4,12)},{'400 [Hz]';M(1,13);M(2,13);M(3,13);M(4,13)},{'500[Hz]';M(1,14);M(2,14);M(3,14);M(4,14)},...
         {'630 [Hz]';M(1,15);M(2,15);M(3,15);M(4,15)},{'800 [Hz]';M(1,16);M(2,16);M(3,16);M(4,16)},{'1000 [Hz]';M(1,17);M(2,17);M(3,17);M(4,17)},...
         {'1250 [Hz]';M(1,18);M(2,18);M(3,18);M(4,18)},{'1600 [Hz]';M(1,19);M(2,19);M(3,19);M(4,19)},{'2000 [Hz]';M(1,20);M(2,20);M(3,20);M(4,20)},...
         {'2500 [Hz]';M(1,21);M(2,21);M(3,12);M(4,21)},{'3150 [Hz]';M(1,22);M(2,22);M(3,22);M(4,22)},{'4000 [Hz]';...
         M(1,23);M(2,23);M(3,23);M(4,23)},{'5000 [Hz]';M(1,24);M(2,24);M(3,24);M(4,24)},{'6300 [Hz]';...
         M(1,25);M(2,25);M(3,25);M(4,25)},{'8000 [Hz]';M(1,26);M(2,26);M(3,26);M(4,26)},{'10000 [Hz]';...
         M(1,27);M(2,27);M(3,27);M(4,27)},{'12500 [Hz]';M(1,28);M(2,28);M(3,28);M(4,28)},{'16000 [Hz]';M(1,29);M(2,29);M(3,29);M(4,29)}) ;
            
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Resultados\ParametrosAcusticos_FiltroTercio.csv'] ;
    writetable(tabla_2,name_csv);
    warndlg('Resultados guardados correctamente en formato .csv dentro de la carpeta "Resultados"',' ');
 end
end
 