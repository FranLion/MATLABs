%% ###########################################################################
%  ######              TRABAJO PRACTICO 1: ENTREGA FINAL                ######
%  ###### "Caracterización de aula a partir de la medición de respuesta ######
%  ######                  impulsiva con Sine-sweep"                    ######
%  ###########################################################################
%  ######                       ESTUDIANTES                             ######
%  ######         *Castelli, Corina.     *Lareo, Matias.                ######
%  ######         *Espíndola, Agustín.   *Passano, Nahuel.              ######
%  ###########################################################################

%% ###### GRAPHIC USER INTERFACE ######
f = figure('Visible','off','units','normalized','Position',[0 0 1 0.93],...
    'Name','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
    'NumberTitle','off','toolbar','none');f.MenuBar = 'none';

%% ###### TITULO y LOGO ######
% Titulo
titulo = uicontrol('style','text',...
        'string','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
        'units','normalized','position',[0.15 0.865 0.70 0.11],'fontsize',24,...
        'backgroundcolor',[3/255 0 104/255]  ,'foregroundcolor',[1 1 1],'fontweight','bold');

% Logo
logo = axes('units','normalized','position',[0.04 0.865 0.10 0.11]);
axes(logo);
imshow('UNTREF-LOGO.png');

%% ###### INFORMACIÓN PREVIA ######
%Titulo
informacionprevia = uicontrol('style','text','string','Información previa',...
        'units','normalized','position',[0.03 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
info_dia_t = uicontrol('Style','text',...
            'String','Dia de la medición (DD-MM-AAAA): ', ...
            'Units','Normalized','position',[0.05 0.72 0.13 0.050]);
info_hora_t = uicontrol('Style','text',...
            'String','Hora de la medición (HH:MM): ', ...
            'Units','Normalized','position',[0.05 0.68 0.13 0.050]);
info_temp_t = uicontrol('Style','text',...
            'String','Temperatura ambiente en [°C]: ', ...
            'Units','Normalized','position',[0.05 0.64 0.13 0.050]);
info_hum_t = uicontrol('Style','text',...
            'String','Humedad en %: ', ...
            'Units','Normalized','position',[0.05 0.60 0.13 0.050]);
info_rf_t = uicontrol('Style','text',...
            'String','Nivel de ruido de fondo equivalente en [dB]: ', ...
            'Units','Normalized','position',[0.05 0.56 0.13 0.050]);
info_ancholargoalto_t = uicontrol('Style','text',...
            'String','Ancho x Largo x Alto  de la sala en [m]: ', ...
            'Units','Normalized','position',[0.062 0.505 0.11 0.050]);
info_volm_t = uicontrol('Style','text',...
            'String','Volumen de los muebles (aproximado) en [m^3]: ', ...
            'Units','Normalized','position',[0.05 0.45 0.13 0.050]);
info_x1_t = uicontrol('Style','text',...
            'String','x', ...
            'Units','Normalized','position',[0.205 0.517 0.03 0.03]);
info_x2_t = uicontrol('Style','text',...
            'String','x', ...
            'Units','Normalized','position',[0.255 0.517 0.03 0.03]);
% Editboxs
info.dia = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.735 0.13 0.040]);
info.hora = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.695 0.13 0.040]);
info.temp = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.66 0.13 0.040]);
info.hum = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.62 0.13 0.040]);
info.rf = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.57 0.13 0.040]);
info.ancho = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.515 0.03 0.040]);
info.largo = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.23 0.515 0.03 0.040]);
info.alto = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.28 0.515 0.03 0.040]);
info.volm = uicontrol('Style','edit','string','',...
            'units','normalized','position',[0.18 0.455 0.13 0.040]);
    % Edits por default
    % Hora
        reloj = clock; hora = sprintf('%d:%d',reloj(4),reloj(5));
        info.hora.String = hora ;
    % Fecha
        fecha = sprintf('%d-%d-%d',reloj(3),reloj(2),reloj(1));
        info.dia.String = fecha;
% Pushbutton
info_guardado_csv = uicontrol('style','pushbutton','string','Guardar en formato .csv',...
            'units','normalized','position',[0.06 0.39 0.11 0.050],...
            'callback',{@guardarinfo_csv,info});
info_guardado_xls = uicontrol('style','pushbutton','string','Guardar en formato .xls',...
            'units','normalized','position',[0.19 0.39 0.11 0.050],...
            'callback',{@guardarinfo_xls,info});
        
%% ###### GRÁFICOS ######
% Titulo
graficos = uicontrol('style','text','string','Gráficos',...
        'units','normalized','position',[0.35 0.46 0.62 0.050],'fontsize',20,...
        'backgroundcolor',[1 98/255 98/255]);
% Textbox
graf_name_t = uicontrol('style','text','fontweight','bold','fontangle','italic','fontsize',15,...
   'units','normalized','position',[0.35 0.41 0.62 0.040],'fontangle','italic');
    graf_name_t.String = '';

% Axes
axes_t = axes('units','normalized','position',[0.38 0.08 0.26 0.32]);xlabel('Tiempo [s]');
    ylabel('Amplitud normalizada [mV]');grid on;ylim([-1 1]);
axes_f = axes('units','normalized','position',[0.69 0.08 0.27 0.32]);xlabel('Frecuencia [Hz]');
    ylabel('Amplitud normalizada [dB]');grid on;axes_f.XScale = 'log' ;xlim([1 25000]);ylim([-120 0]);


%% ###### CALIBRACIÓN ######
% Titulo
calibracion = uicontrol('style','text','string','Calibración de la fuente',...
        'units','normalized','position',[0.03 0.30 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
cal_seg_t = uicontrol('style','text','string','Tiempo de ruido rosa en [s]: ',...
    'units','normalized','position',[0.05 0.202 0.13 0.040]);
% Editboxs
cal_seg_e = uicontrol('style','edit','string','','units','normalized',...
    'position',[0.18 0.21 0.13 0.040]);
    % Editbox por defecto
    cal_seg_e.String = '30';
% Pushbuttons
cal_rep_pb = uicontrol('style','pushbutton','string','Reproducir','units','normalized',...
   'position',[0.06 0.12 0.11 0.05],'callback',{@playpn,cal_seg_e});
cal_val_pb = uicontrol('style','pushbutton','string','Generar gráfico','units','normalized',...
    'position',[0.19 0.12 0.11 0.05],'callback',{@graphpn,cal_seg_e,axes_t,axes_f,graf_name_t});

%% ###### GENERACIÓN DEL SINE-SWEEP ######
% Titulo
gensinesweep = uicontrol('style','text','string','Generación del Sine-sweep',...
        'units','normalized','position',[0.35 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
gensinesweep_fmin_t = uicontrol('style','text','string','Frecuencia mínima del Sine-sweep en [Hz]: ',...
    'units','normalized','position',[0.37 0.72 0.13 0.04]);
gensinesweep_fmax_t = uicontrol('style','text','string','Frecuencia máxima del Sine-sweep en [Hz]: ',...
    'units','normalized','position',[0.37 0.66 0.13 0.04]);
gensinesweep_seg_t = uicontrol('style','text','string','Tiempo del Sine-sweep en [s]: ',...
    'units','normalized','position',[0.37 0.60 0.13 0.04]);
% Editboxs
gensinesweep_fmin_e = uicontrol('style','edit','string','','units','normalized',...
    'position',[0.51 0.72 0.11 0.04]);
gensinesweep_fmax_e = uicontrol('style','edit','string','8000','units','normalized',...
    'position',[0.51 0.665 0.11 0.04]);
gensinesweep_fseg_e = uicontrol('style','edit','string','30','units','normalized',...
    'position',[0.51 0.61 0.11 0.04]);
% Pushbuttons
gensinesweep_gen_pb = uicontrol('style','pushbutton','string','Generar y guardar', ...
    'units','normalized','position',[0.38 0.54 0.11 0.05], 'Callback',{@gensn,gensinesweep_fmin_e,...
    gensinesweep_fmax_e,gensinesweep_fseg_e});
gensinesweep_val_pb = uicontrol('style','pushbutton','string','Generar gráfico',...
    'units','normalized','position',[0.51 0.54 0.11 0.05],'callback',{@graphsn,...
    gensinesweep_fmin_e,gensinesweep_fmax_e,gensinesweep_fseg_e,axes_t,axes_f,graf_name_t });

%% ###### ADQUISICIÓN DE DATOS ######
% Titulo
adquisicion = uicontrol('style','text','string','Adquisición de datos',...
        'units','normalized','position',[0.67 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
adq_numtoma_t = uicontrol('style','text','string','N° de reiteración de tomas: ',...
    'units','normalized','position',[0.70 0.69 0.10 0.05]);
adq_pos_t = uicontrol('style','text','string','Posición del microfono: ',...
    'units','normalized','position',[0.70 0.64 0.10 0.05]);
% Editboxs
adq_numtoma_e = uicontrol('style','edit','string','1','units','normalized',...
    'position',[0.805 0.71 0.03 0.04]);
adq_pos_e = uicontrol('style','edit','string','a','units','normalized',...
    'position',[0.805 0.66 0.03 0.04]);
% Figure
    % Cartel de grabación
cartelrec = figure('visible','off','units','normalized','position',[0.35 0.3 0.3 0.4],...
        'NumberTitle','off','toolbar','none');
        cartelrec.MenuBar = 'none';
    cart_tomanro_t = uicontrol('parent',cartelrec,'style','text','units','normalized',...
        'position',[0 0.70 1 0.2],'string','','fontsize',14,'fontangle','italic','fontweight','bold');
    cart_grab_t = uicontrol('parent',cartelrec,'style','text','units','normalized',...
        'position',[0 0.4 1 0.3],'string','...GRABANDO...','fontsize',24,'foregroundcolor'...
        ,[1 0 0]);
    cart_tiempo_t = uicontrol('parent',cartelrec,'style','text','units','normalized',...
        'position',[0 0.2 1 0.3],'string','Tiempo restante: ','fontsize',11);
    cart_timer_t = uicontrol('parent',cartelrec,'style','text','units','normalized',...
        'position',[0 0.15 1 0.3],'fontsize',24);
    cart_aclaracion_t = uicontrol('parent',cartelrec,'style','text','units','normalized',...
        'position',[0.03 0.07 0.97 0.15],'string',['Nota: La duración de la toma esta premeditada '...
        'en torno al futuro procesamiento y análisis de la misma, para así poder obtener parametros acusticos del recinto.']);
    
    % Información sobre el posicionamiento del microfono
informacion_mic = figure('visible','off','units','normalized','position',[0.325 0.2 0.35 0.6],...
        'NumberTitle','off','toolbar','none');
        informacion_mic.MenuBar = 'none';
    infomic = struct;
    % Textboxs
    infomic_title = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0 0.75 1 0.2],'string','Información sobre el posicionamiento de la fuente y microfono',...
        'fontsize',14,'fontweight','bold');
    infomic_pos = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.10 0.68 0.22 0.1],'string','Instrumento','fontsize',10,'fontweight','bold');
    infomic_x = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.42 0.68 0.05 0.1],'string','X','fontsize',10,'fontweight','bold');
    infomic_y = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.60 0.68 0.05 0.1],'string','Y','fontsize',10,'fontweight','bold');
    infomic_z = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.75 0.68 0.1 0.1],'string','Altura','fontsize',10,'fontweight','bold');
    infomic_posa = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.17 0.60 0.1 0.1],'string','Fuente','HorizontalAlignment','left');
    infomic_posb = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.53 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_posc = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.46 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_posd = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.39 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_pose = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.32 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_posf = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.25 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_posg = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.18 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_posh = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.11 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    infomic_posi = uicontrol('parent',informacion_mic,'style','text','units','normalized',...
        'position',[0.13 0.04 0.15 0.1],'string','Microfono','HorizontalAlignment','left');
    
    % Editboxs
    infomic.xa = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.662 0.1 0.04],'string','');
    infomic.ya = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.662 0.1 0.04],'string','');
    infomic.za = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.662 0.1 0.04],'string','');
    
    infomic.posb = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.592 0.05 0.04],'string','');
    infomic.xb = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.592 0.1 0.04],'string','');
    infomic.yb = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.592 0.1 0.04],'string','');
    infomic.zb = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.592 0.1 0.04],'string','');
    
    infomic.posc = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.522 0.05 0.04],'string','');
    infomic.xc = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.522 0.1 0.04],'string','');
    infomic.yc = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.522 0.1 0.04],'string','');
    infomic.zc = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.522 0.1 0.04],'string','');
    
    infomic.posd = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.452 0.05 0.04],'string','');
    infomic.xd = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.452 0.1 0.04],'string','');
    infomic.yd = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.452 0.1 0.04],'string','');
    infomic.zd = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.452 0.1 0.04],'string','');
    
    infomic.pose = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.382 0.05 0.04],'string','');
    infomic.xe = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.382 0.1 0.04],'string','');
    infomic.ye = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.382 0.1 0.04],'string','');
    infomic.ze = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.382 0.1 0.04],'string','');
   
    infomic.posf = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.312 0.05 0.04],'string','');
    infomic.xf = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.312 0.1 0.04],'string','');
    infomic.yf = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.312 0.1 0.04],'string','');
    infomic.zf = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.312 0.1 0.04],'string','');
    
    infomic.posg = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.242 0.05 0.04],'string','');
    infomic.xg = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.242 0.1 0.04],'string','');
    infomic.yg = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.242 0.1 0.04],'string','');
    infomic.zg = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.242 0.1 0.04],'string','');
    
    infomic.posh = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.172 0.05 0.04],'string','');
    infomic.xh = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.172 0.1 0.04],'string','');
    infomic.yh = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.172 0.1 0.04],'string','');
    infomic.zh = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.172 0.1 0.04],'string','');
    
    infomic.posi = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.245 0.102 0.05 0.04],'string','');
    infomic.xi = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.39 0.102 0.1 0.04],'string','');
    infomic.yi = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.57 0.102 0.1 0.04],'string','');   
    infomic.zi = uicontrol('parent',informacion_mic,'style','edit','units','normalized',...
        'position',[0.75 0.102 0.1 0.04],'string','');
    
% Pushbuttons
adq_rec_pb = uicontrol('parent',f,'style','pushbutton','string','Iniciar tomas',...
    'units','normalized','position',[0.85 0.655 0.09 0.10],'callback',...
    {@rec,cartelrec,cart_tiempo_t,cart_tomanro_t,adq_numtoma_e,cart_timer_t,cart_grab_t,adq_pos_e},...
    'foregroundcolor',[1 0 0],'fontweight','bold','fontsize',12);
adq_plot_pb = uicontrol('parent',f,'style','pushbutton','string','Ver grafico',...
    'units','normalized','position',[0.70 0.54 0.11 0.05],'callback',{@graphrec,axes_t,axes_f,graf_name_t,adq_numtoma_e});
adq_save_pb = uicontrol('parent',f,'style','pushbutton','string','Exportar tomas en .wav',...
    'units','normalized','position',[0.83 0.54 0.11 0.05],...
    'callback',{@exportwav,adq_numtoma_e,axes_t,axes_f,graf_name_t});
adq_info_pb = uicontrol('parent',f,'style','pushbutton','string','Información sobre el posicionamiento del microfono y fuente' ,...
     'units','normalized','position',[0.70 0.61 0.24 0.03],'callback',{@pbmic,informacion_mic});

    infomic_pbsave = uicontrol('parent',informacion_mic,'style','pushbutton','units','normalized',...
        'position',[0.40 0.02 0.25 0.05],'string','Guardar información','callback',{@saveinfomic,infomic,informacion_mic});


%% ###### EXTRAS ######
% Información adicional
infoextra = figure('visible','off','units','normalized','position',[0.35 0.4 0.35 0.2],...
        'NumberTitle','off','toolbar','none');
    info_title = uicontrol('parent',infoextra,'style','text','string','Estudiantes','units','normalized',...
        'position',[0 0.6 1 0.2],'fontsize',14);
    info_text = uicontrol('parent',infoextra,'style','text','string',...
        ['Castelli, Corina (castellicr2111@gmail.com) // Espíndola,Agustín (agustinespindola96@gmail.com) // '...
        'Lareo, Matias (matilareo@gmail.com) // Passano, Nahuel (n.passano@hotmail.com)'],'units','normalized',...
        'position',[0.1 0.3 0.8 0.3]);
    info_fs = uicontrol('parent',infoextra,'style','text','string',...
        'Nota: El software trabaja con una frecuencia de muestreo de 44100 [Hz]',...
        'units','normalized','position',[0 0 1 0.2],'fontsize',11);
extra_info_pb = uicontrol('parent',f,'style','pushbutton','string','Información adicional','units','normalized',...
    'position',[0.86 0.925 0.11 0.05],'callback',{@infoadicional,infoextra});
% Finalizar
extra_close_pb = uicontrol('parent',f,'style','pushbutton','string','Finalizar','units','normalized',...
    'position',[0.86 0.865 0.11 0.05],'callback',{@close,f});
%% ###### STARTUP ######
startup = figure('Visible','off','units','normalized','Position',[0.33 0.33 0.35 0.33],...
    'Name','Bienvenido',...
    'NumberTitle','off','toolbar','none');startup.MenuBar = 'none';
% Textboxs
titulostartup_t = uicontrol('parent',startup,'style','text',...
    'string','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
    'units','normalized','position',[0.03 0.75 0.94 0.2],'fontsize',14,...
    'backgroundcolor',[3/255 0 104/255]  ,'foregroundcolor',[1 1 1],'fontweight','bold');
proyecto_t = uicontrol('parent',startup,'style','text',...
     'string','Nombre del proyecto: ','units','normalized','position',[0 0.5 1 0.1],'fontsize',10);
directorio_t = uicontrol('style','text','string','Guardar proyecto en: ','units','normalized',...
    'position',[0 0.28 1 0.1],'fontsize',10);
% Editboxs
proyecto_e = uicontrol('parent',startup,'style','edit',...
        'string','','units','normalized','position',[0.2 0.42 0.6 0.1]);
directorio_e = uicontrol('style','edit','string','','units','normalized',...
        'position',[0.2 0.2 0.5 0.1]);

% Pushbuttons
directorio_pb = uicontrol('parent',startup,'style','pushbutton','string','...','units',...
    'normalized','position',[0.7 0.195 0.1 0.11],'callback',{@directorio,proyecto_e,directorio_e},...
    'fontsize',14,'fontweight','bold');
siguiente_pb = uicontrol('parent',startup,'style','pushbutton','string','Siguiente','units',...
    'normalized','position',[0.75 0.05 0.20 0.1],'callback',{@siguiente,proyecto_e,directorio_e,startup,f});
cargarproyecto_pb = uicontrol('parent',startup,'style','pushbutton','string','Cargar proyecto',...
    'units','normalized','position',[0.05 0.05 0.20 0.1],'callback',{@cargarproyecto,startup,f});
startup.Visible = 'on';

 f.Visible = 'off';
 

%% #################################################################################
%% ################################### FUNCIONES ###################################
%% #################################################################################

%% ###### Start up ######
% Directorio
function directorio(object_handle,event,proyecto_e,directorio_e)
    direct = uigetdir;
    directorio_e.String = direct;
end
% Siguiente
function siguiente(object_handle,event,proyecto_e,directorio_e,startup,f)
    try
        direct = get(directorio_e,'string');
        oldfolder = cd(direct);
        proyect = get(proyecto_e,'string');
        mkdir(proyect); 
        cd(proyect);
            mkdir Información;
            mkdir Resultados;
            mkdir 'Pinknoise, Sine-sweep y Filtro inverso';
            cd 'Pinknoise, Sine-sweep y Filtro inverso';
                mkdir Gráficos;
                cd ..\
            mkdir Tomas
            cd Tomas
                mkdir Formato_mat
                mkdir Formato_wav
                mkdir IRs
                cd ..\
            cd ..\
            addpath(genpath(proyect));
            cd(proyect);
        startup.Visible = 'off';
        f.Visible = 'on';
    catch
        errordlg('Revise los campos','Error')
    end
end

function cargarproyecto(object_handle,event,startup,f)
    try
        direct = uigetdir;
        oldfolder = cd(direct);
        addpath(genpath(direct));
        startup.Visible = 'off';
        f.Visible = 'on';
    catch
        errordlg('Compruebe que ha seleccionado la carpeta correcta','Error');
    end
end

%% ###### Guardar información ######
% Formato .xls (Excel)
function guardarinfo_xls(object_handle,event,info)  
        
    informacionprevia = ["Dia",get(info.dia,'string');"Hora" , get(info.hora,'string'); "Temperatura [°C]" , get(info.temp,'string');...
       "Humedad [%]" , get(info.hum,'string');"Ruido de fondo equivalente [dB]", get(info.rf,'string')...
       ;"Ancho de la sala [m]",get(info.ancho,'string');"Largo de la sala [m]",get(info.largo,'string');...
       "Alto de la sala [m]",get(info.alto,'string');"Volumen de los muebles (aprox)[m^3]", get(info.volm,'string')];
    
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_xls = [path_actual '\Información\Información previa.xls'] ;
    xlswrite(name_xls, informacionprevia ,'A1:B9');
    warndlg('Información guardada correctamente en formato .xls (Excel)',' ')
end

% Formato .csv 
function guardarinfo_csv(object_handle,event,info)
        informacionprevia = table({'Día'; 'Hora'; 'Temperatura [°C]'; 'Humedad [%]';'Ruido de fondo equivalente [dB]';...
    'Ancho de la sala [m]';'Largo de la sala [m]';'Alto de la sala [m]'; 'Volumen de los muebles (aprox) [m^3]'},...
    {get(info.dia,'string'); get(info.hora,'string'); get(info.temp,'string');get(info.hum,'string'); get(info.rf,'string');...
    get(info.ancho,'string');get(info.largo,'string');get(info.alto,'string');get(info.volm,'string')});
    
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Información\Información previa.csv'] ;
    writetable(informacionprevia, name_csv)
    warndlg('Información guardada correctamente en formato .csv',' ');
end
%% ###### Reproduccion del Pinknoise ######
function x = playpn(object_handle,event,cal_seg_e);
    t_pn = get(cal_seg_e,'string');
    t_pn = str2num(t_pn);
    
    if isempty(t_pn)
        errordlg('Rellene los campos faltantes','Error')
    else
        x = pinknoise(t_pn);
        sound(x,44100)
        path_actual = pwd; % Dirección de la carpeta actual en uso
        name_pn = [path_actual '\Pinknoise, Sine-sweep y Filtro inverso\pinknoise.wav'] ;
        audiowrite(name_pn,x,44100);
    end
end
% Grafico del Pinknoise
function graphpn(objet_handle,event,cal_seg_e,axes_t,axes_f,graf_name_t);
    t_pn = get(cal_seg_e,'string');
    t_pn = str2num(t_pn);
    if isempty(t_pn)
        errordlg('Rellene los campos faltantes','Error')
    else
        x = pinknoise(t_pn);
        path_actual = pwd; % Dirección de la carpeta actual en uso
        graf_pn = [path_actual '\Pinknoise, Sine-sweep y Filtro inverso\Gráficos\Pinknoise '] ;
        
        axes(axes_t)
        q = plot_time(x,t_pn,44100) ;
        graf_pn_t = [graf_pn '(Tiempo).fig'];
        saveas(q,graf_pn_t);
        
        axes(axes_f)
        h = plot_fft(x,t_pn,44100) ;
        graf_pn_f = [graf_pn '(Frecuencia).fig'];
        saveas(h,graf_pn_f);

        set(graf_name_t,'string','Ruido rosa');
    end
end

%% ###### Generación del Sinesweep ######
% Generación
function gensn(object_handle, event,gensinesweep_fmin_e,gensinesweep_fmax_e,gensinesweep_fseg_e);
    fmin = get(gensinesweep_fmin_e,'string');
    fmin = str2num(fmin);
    fmax = get(gensinesweep_fmax_e,'string');
    fmax = str2num(fmax);
    tn = get(gensinesweep_fseg_e,'string');
    tn = str2num(tn);
    
    if isempty(fmin) | isempty(fmax) | isempty(tn)
        errordlg('Rellene los campos faltantes','Error')
    else
        [x,k] = sinesweep(fmin,fmax,tn);
        path_actual = pwd; % Dirección de la carpeta actual en uso
        name_ss = [path_actual '\Pinknoise, Sine-sweep y Filtro inverso\sinesweep.wav'] ;
        name_invss = [path_actual '\Pinknoise, Sine-sweep y Filtro inverso\filtroinverso.wav'];
        audiowrite(name_ss,x,44100)
        audiowrite(name_invss,k,44100)
        warndlg('Sine-sweep y su filtro inverso generados correctamente. Han sido guardados en la carpeta "Pinknoise, Sine-sweep y Filtro inverso" en formato .wav',' ')
    end
end
% Grafico del Sinesweep
function graphsn(object_handle,event,gensinesweep_fmin_e,gensinesweep_fmax_e,gensinesweep_fseg_e,axes_t,axes_f,graf_name_t)
    fmin = get(gensinesweep_fmin_e,'string');
    fmin = str2num(fmin);
    fmax = get(gensinesweep_fmax_e,'string');
    fmax = str2num(fmax);
    tn = get(gensinesweep_fseg_e,'string');
    tn = str2num(tn);
    
    if isempty(fmin) | isempty(fmax) | isempty(tn)
        errordlg('Rellene los campos faltantes','Error')
    else
        [x,k] = sinesweep(fmin,fmax,tn);
        path_actual = pwd; % Dirección de la carpeta actual en uso
        graf_ss = [path_actual '\Pinknoise, Sine-sweep y Filtro inverso\Gráficos\Sine-sweep '] ;
        graf_finv = [path_actual '\Pinknoise, Sine-sweep y Filtro inverso\Gráficos\Filtro inverso '];
        
        axes(axes_t) % Grafico temporal
        q = plot_time(x,tn,44100);
        graf_ss_t = [graf_ss '(Tiempo).fig'];
        saveas(q,graf_ss_t);
        q = plot_time(k,tn,44100);
        graf_finv_t = [graf_finv '(Tiempo).fig'];
        saveas(q,graf_finv_t);
        
        axes(axes_f) % Grafico frecuencial
        h = plot_fft(x,tn,44100);
        graf_ss_f = [graf_ss '(Frecuencia).fig'];
        saveas(h,graf_ss_f);
        h = plot_fft(k,tn,44100);
        graf_finv_f = [graf_finv '(Frecuencia).fig'];
        saveas(h,graf_finv_f);
        
        set(graf_name_t,'string','Sine-sweep logarítmico');
    end
end
%% ###### ADQUISICIÓN DE DATOS ######
% Grabación de la toma 
function toma_i = rec(object_handle, event,cartelrec,cart_tiempo_t,cart_tomanro_t,adq_numtoma_e,...
    cart_timer_t,cart_grab_t,adq_pos_e)
    [y , Fs] = audioread('sinesweep.wav');
    t_ss = numel(y)./Fs;
    reiteracion = get(adq_numtoma_e,'string');
    reiteracion = str2double(reiteracion);
    posicion = get(adq_pos_e,'String');
    for i=1:reiteracion
        numtoma = ['"Toma N°' num2str(i) '(' posicion ')"'];
        cart_tomanro_t.String = numtoma;
        cart_tomanro_t.Visible = 'on';
        cart_timer_t.String = [num2str(2*t_ss+1) ' [s]'];
        cart_grab_t.String = ['...GRABANDO...'];
        cart_grab_t.ForegroundColor = [1 0 0];
        cart_tiempo_t.Visible = 'on';
        cartelrec.Visible = 'on';
        rec_i = audiorecorder(Fs,16,1);
        record(rec_i,1+2*t_ss)
        pause(1) ;
        sound(y,Fs);
        for j=0:2*t_ss-1
            cart_timer_t.String = [num2str(2*t_ss-j) ' [s]'];
            pause(1)
        end
        pause(1)
        cartelrec.Visible = 'off';
        pause(1)
        toma_i = getaudiodata(rec_i,'double');
        path_actual = pwd; % Dirección de la carpeta actual en uso
        name_toma = [path_actual '\Tomas\Formato_mat\Toma_n' num2str(i) '_' posicion '.mat'] ;
        save(name_toma,'toma_i')
        if i == reiteracion
            msgbox('Las tomas se guardaron correctamente en la carpeta "Tomas\Formato_mat"')
        else
            cart_grab_t.String = 'Aguarde a que comienze la siguiente toma en:';
            cart_grab_t.ForegroundColor = [0 0 0];
            cart_tomanro_t.Visible = 'off';
            cart_tiempo_t.Visible = 'off';
            pause(1)
            cartelrec.Visible = 'on';
            for k=1:4
                cart_timer_t.String = [num2str(5-k) ' [s]'];
                pause(1)
            end
            cartelrec.Visible = 'off';
            pause(1)
        end
    end
    clear y Fs

end

% Graficar señal grabada
function graphrec(object_handle,event,axes_t,axes_f,graf_name_t,adq_numtoma_e)
    try
        cd Tomas\Formato_mat
        [file,path] = uigetfile('*.mat','Seleccione la toma que desea graficar','Toma_n_.mat');
        cd ..\..
        string(file);
        path_actual = pwd;
        loadtoma = [path_actual '\Tomas\Formato_mat\' file] ;
        y = load(loadtoma);
        y = y.toma_i;
        Fs = 44100;
        tiempo = numel(y)./Fs ; 
        axes(axes_t)
        plot_time(y,tiempo,Fs)
        axes(axes_f)
        plot_fft(y,tiempo,Fs)
        name_toma = file;
        set(graf_name_t,'string',name_toma);
    catch
    end
end

% Exportar wav
function exportwav(object_handle,event,adq_numtoma_e,axes_t,axes_f,graf_name_t,adq_pos_list)
    try
        cd Tomas\Formato_mat
        [file,path] = uigetfile('*.mat','Seleccione las tomas que desee exportar en .wav','Toma_n_.wav','MultiSelect','on');
        cd ..\..
        file = string(file);
        path_actual = pwd;
        for i=1:length(file)
            loadtoma = [path_actual '\Tomas\Formato_mat\' char(file(i))] ;
            y = load(loadtoma);
            y = y.toma_i;
            tomawav = char(file(i));
            tomawav = tomawav(1:end-4);
            name_toma = [path_actual '\Tomas\Formato_wav\' tomawav '.wav'];
            audiowrite(name_toma,y,44100)
        end
        msgbox('Tomas exportadas en .wav correctamente en la carpeta "Tomas\Formato_wav"')
    catch
    end
end

% Informacion sobre el posicionamiento del microfono
function pbmic(object_handle,event,informacion_mic)
    informacion_mic.Visible = 'on';
end
function saveinfomic(object_handle,event,infomic,informacion_mic)
    tableinfomic = table({'Fuente';['Microfono ' infomic.posb.String];['Microfono ' infomic.posc.String];...
        ['Microfono ' infomic.posd.String];['Microfono ' infomic.pose.String];['Microfono ' infomic.posf.String];...
        ['Microfono ' infomic.posg.String];['Microfono ' infomic.posh.String];['Microfono ' infomic.posi.String]}...
        ,{infomic.xa.String;infomic.xb.String;infomic.xc.String;infomic.xd.String;infomic.xe.String;...
        infomic.xf.String;infomic.xg.String;infomic.xh.String;infomic.xi.String},{infomic.ya.String;infomic.yb.String;...
        infomic.yc.String;infomic.yd.String;infomic.ye.String;infomic.yf.String;infomic.yg.String;...
        infomic.yh.String;infomic.yi.String},{infomic.za.String;infomic.zb.String;infomic.zc.String;infomic.zd.String;...
        infomic.ze.String;infomic.zf.String;infomic.zg.String;infomic.zh.String;infomic.zi.String});
    tableinfomic.Properties.VariableNames = {'Instrumento' 'X' 'Y' 'Altura'}
    
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Información\Información sobre posicionamiento de microfono y fuente.csv'] ;
    writetable(tableinfomic, name_csv);
    informacion_mic.Visible = 'off';
    warndlg('Información guardada correctamente en formato .csv',' ');
end


%% ###### EXTRA ######
function infoadicional(object_handle,event,infoextra)
    infoextra.Visible = 'on';
end
function close(object_handle,event,f)
    msgbox('Muchas gracias por utilizar el software')
    f.Visible = 'off';
end
