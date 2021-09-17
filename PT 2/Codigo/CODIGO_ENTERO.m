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
f = figure('Visible','off','units','normalized','Position',[0 0 1 0.96],...
    'Name','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
    'NumberTitle','off','toolbar','none');f.MenuBar = 'none';
tgroup = uitabgroup ('Parent',f);
tab_1= uitab('Parent',tgroup, 'Title', 'Medición' );
tab_2 = uitab('Parent',tgroup,'Title','Proceso de señales');
%% ###### TITULO y LOGO ######
% Titulo
titulo = uicontrol('parent', tab_1,'style','text',...
        'string','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
        'units','normalized','position',[0.15 0.865 0.70 0.11],'fontsize',24,...
        'backgroundcolor',[3/255 0 104/255]  ,'foregroundcolor',[1 1 1],'fontweight','bold');

% Logo
logo = axes('parent', tab_1,'units','normalized','position',[0.04 0.865 0.10 0.11]);
axes(logo);
imshow('UNTREF-LOGO.png');

%% ###### INFORMACIÓN PREVIA ######
%Titulo
informacionprevia = uicontrol('parent', tab_1,'style','text','string','Información previa',...
        'units','normalized','position',[0.03 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
info_dia_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Dia de la medición (DD-MM-AAAA): ', ...
            'Units','Normalized','position',[0.05 0.72 0.13 0.050]);
info_hora_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Hora de la medición (HH:MM): ', ...
            'Units','Normalized','position',[0.05 0.68 0.13 0.050]);
info_temp_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Temperatura ambiente en [°C]: ', ...
            'Units','Normalized','position',[0.05 0.64 0.13 0.050]);
info_hum_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Humedad en %: ', ...
            'Units','Normalized','position',[0.05 0.60 0.13 0.050]);
info_rf_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Nivel de ruido de fondo equivalente en [dB]: ', ...
            'Units','Normalized','position',[0.05 0.56 0.13 0.050]);
info_ancholargoalto_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Ancho x Largo x Alto  de la sala en [m]: ', ...
            'Units','Normalized','position',[0.062 0.505 0.11 0.050]);
info_volm_t = uicontrol('parent', tab_1,'Style','text',...
            'String','Volumen de los muebles (aproximado) en [m^3]: ', ...
            'Units','Normalized','position',[0.05 0.45 0.13 0.050]);
info_x1_t = uicontrol('parent', tab_1,'Style','text',...
            'String','x', ...
            'Units','Normalized','position',[0.205 0.517 0.03 0.03]);
info_x2_t = uicontrol('parent', tab_1,'Style','text',...
            'String','x', ...
            'Units','Normalized','position',[0.255 0.517 0.03 0.03]);
% Editboxs
info.dia = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.735 0.13 0.040]);
info.hora = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.695 0.13 0.040]);
info.temp = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.66 0.13 0.040]);
info.hum = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.62 0.13 0.040]);
info.rf = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.57 0.13 0.040]);
info.ancho = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.515 0.03 0.040]);
info.largo = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.23 0.515 0.03 0.040]);
info.alto = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.28 0.515 0.03 0.040]);
info.volm = uicontrol('parent', tab_1,'Style','edit','string','',...
            'units','normalized','position',[0.18 0.455 0.13 0.040]);
    % Edits por default
    % Hora
        reloj = clock; hora = sprintf('%d:%d',reloj(4),reloj(5));
        info.hora.String = hora ;
    % Fecha
        fecha = sprintf('%d-%d-%d',reloj(3),reloj(2),reloj(1));
        info.dia.String = fecha;
% Pushbutton
info_guardado_csv = uicontrol('parent', tab_1,'style','pushbutton','string','Guardar en formato .csv',...
            'units','normalized','position',[0.06 0.39 0.11 0.050],...
            'callback',{@guardarinfo_csv,info});
info_guardado_xls = uicontrol('parent', tab_1,'style','pushbutton','string','Guardar en formato .xls',...
            'units','normalized','position',[0.19 0.39 0.11 0.050],...
            'callback',{@guardarinfo_xls,info});
        
%% ###### GRÁFICOS ######
% Titulo
graficos = uicontrol('parent', tab_1,'style','text','string','Gráficos',...
        'units','normalized','position',[0.35 0.46 0.62 0.050],'fontsize',20,...
        'backgroundcolor',[1 98/255 98/255]);
% Textbox
graf_name_t = uicontrol('parent', tab_1,'style','text','fontweight','bold','fontangle','italic','fontsize',15,...
   'units','normalized','position',[0.35 0.41 0.62 0.040],'fontangle','italic');
    graf_name_t.String = '';

% Axes
axes_t = axes('parent', tab_1,'units','normalized','position',[0.38 0.08 0.26 0.32]);xlabel('Tiempo [s]');
    ylabel('Amplitud normalizada [mV]');grid on;ylim([-1 1]);
axes_f = axes('parent', tab_1,'units','normalized','position',[0.69 0.08 0.27 0.32]);xlabel('Frecuencia [Hz]');
    ylabel('Amplitud normalizada [dB]');grid on;axes_f.XScale = 'log' ;xlim([1 25000]);ylim([-120 0]);


%% ###### CALIBRACIÓN ######
% Titulo
calibracion = uicontrol('parent', tab_1,'style','text','string','Calibración de la fuente',...
        'units','normalized','position',[0.03 0.30 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
cal_seg_t = uicontrol('parent', tab_1,'style','text','string','Tiempo de ruido rosa en [s]: ',...
    'units','normalized','position',[0.05 0.202 0.13 0.040]);
% Editboxs
cal_seg_e = uicontrol('parent', tab_1,'style','edit','string','','units','normalized',...
    'position',[0.18 0.21 0.13 0.040]);
    % Editbox por defecto
    cal_seg_e.String = '30';
% Pushbuttons
cal_rep_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Reproducir','units','normalized',...
   'position',[0.06 0.12 0.11 0.05],'callback',{@playpn,cal_seg_e});
cal_val_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Generar gráfico','units','normalized',...
    'position',[0.19 0.12 0.11 0.05],'callback',{@graphpn,cal_seg_e,axes_t,axes_f,graf_name_t});

%% ###### GENERACIÓN DEL SINE-SWEEP ######
% Titulo
gensinesweep = uicontrol('parent', tab_1,'style','text','string','Generación del Sine-sweep',...
        'units','normalized','position',[0.35 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
gensinesweep_fmin_t = uicontrol('parent', tab_1,'style','text','string','Frecuencia mínima del Sine-sweep en [Hz]: ',...
    'units','normalized','position',[0.37 0.72 0.13 0.04]);
gensinesweep_fmax_t = uicontrol('parent', tab_1,'style','text','string','Frecuencia máxima del Sine-sweep en [Hz]: ',...
    'units','normalized','position',[0.37 0.66 0.13 0.04]);
gensinesweep_seg_t = uicontrol('parent', tab_1,'style','text','string','Tiempo del Sine-sweep en [s]: ',...
    'units','normalized','position',[0.37 0.60 0.13 0.04]);
% Editboxs
gensinesweep_fmin_e = uicontrol('parent', tab_1,'style','edit','string','','units','normalized',...
    'position',[0.51 0.72 0.11 0.04]);
gensinesweep_fmax_e = uicontrol('parent', tab_1,'style','edit','string','8000','units','normalized',...
    'position',[0.51 0.665 0.11 0.04]);
gensinesweep_fseg_e = uicontrol('parent', tab_1,'style','edit','string','30','units','normalized',...
    'position',[0.51 0.61 0.11 0.04]);
% Pushbuttons
gensinesweep_gen_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Generar y guardar', ...
    'units','normalized','position',[0.38 0.54 0.11 0.05], 'Callback',{@gensn,gensinesweep_fmin_e,...
    gensinesweep_fmax_e,gensinesweep_fseg_e});
gensinesweep_val_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Generar gráfico',...
    'units','normalized','position',[0.51 0.54 0.11 0.05],'callback',{@graphsn,...
    gensinesweep_fmin_e,gensinesweep_fmax_e,gensinesweep_fseg_e,axes_t,axes_f,graf_name_t });

%% ###### ADQUISICIÓN DE DATOS ######
% Titulo
adquisicion = uicontrol('parent', tab_1,'style','text','string','Adquisición de datos',...
        'units','normalized','position',[0.67 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
% Textboxs
adq_numtoma_t = uicontrol('parent', tab_1,'style','text','string','N° de reiteración de tomas: ',...
    'units','normalized','position',[0.70 0.69 0.10 0.05]);
adq_pos_t = uicontrol('parent', tab_1,'style','text','string','Posición del microfono: ',...
    'units','normalized','position',[0.70 0.64 0.10 0.05]);
% Editboxs
adq_numtoma_e = uicontrol('parent', tab_1,'style','edit','string','1','units','normalized',...
    'position',[0.805 0.71 0.03 0.04]);
adq_pos_e = uicontrol('parent', tab_1,'style','edit','string','a','units','normalized',...
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
adq_rec_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Iniciar tomas',...
    'units','normalized','position',[0.85 0.655 0.09 0.10],'callback',...
    {@rec,cartelrec,cart_tiempo_t,cart_tomanro_t,adq_numtoma_e,cart_timer_t,cart_grab_t,adq_pos_e},...
    'foregroundcolor',[1 0 0],'fontweight','bold','fontsize',12);
adq_plot_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Ver grafico',...
    'units','normalized','position',[0.70 0.54 0.11 0.05],'callback',{@graphrec,axes_t,axes_f,graf_name_t,adq_numtoma_e});
adq_save_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Exportar tomas en .wav',...
    'units','normalized','position',[0.83 0.54 0.11 0.05],...
    'callback',{@exportwav,adq_numtoma_e,axes_t,axes_f,graf_name_t});
adq_info_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Información sobre el posicionamiento del microfono y fuente' ,...
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
extra_info_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Información adicional','units','normalized',...
    'position',[0.86 0.925 0.11 0.05],'callback',{@infoadicional,infoextra});
% Finalizar
extra_close_pb = uicontrol('parent', tab_1,'style','pushbutton','string','Finalizar','units','normalized',...
    'position',[0.86 0.855 0.11 0.05],'callback',{@close_0,f});

%% ############################################ SEGUNDA PARTE #####################################################################

%% ###### TITULO y LOGO ######
%%Titulo
titulodsp = uicontrol('parent', tab_2,'style','text',...
        'string','Caracterización de aula a partir de la medición de respuesta impulsiva con Sine-sweep',...
        'units','normalized','position',[0.15 0.865 0.70 0.11],'fontsize',24,...
        'backgroundcolor',[3/255 0 104/255]  ,'foregroundcolor',[1 1 1],'fontweight','bold');

%Logo
logodsp = axes('parent', tab_2,'units','normalized','position',[0.04 0.865 0.10 0.11]);
axes(logodsp);
imshow('UNTREF-LOGO.png');

grafico_fondo = uicontrol('parent', tab_2,'style','text','units','normalized','position',[0.41 0.3 0.1 0.45],'string',''...
     ,'BackGroundColor',[200/255 200/255 200/255]);

% Popupmenu 
graficodsp_bandaspumoct = uicontrol('parent', tab_2,'style','popup','units','normalized','position',....
    [0.42 0.65 0.08 0.05],'string',{'125 [Hz]' '250 [Hz]' '500 [Hz]' '1000 [Hz]' '2000 [Hz]' '4000 [Hz]' '8000 [Hz]'}...
    ,'Visible','off','Value',4);
% Popupmenu 
graficodsp_bandaspumter = uicontrol('parent', tab_2,'style','popup','units','normalized','position',....
    [0.42 0.65 0.08 0.05],'string',{'125 [Hz]';'160 [Hz]';'200 [Hz]';'250 [Hz]';'315 [Hz]';'400 [Hz]';'500 [Hz]';...
    '630 [Hz]';'800 [Hz]';'1000 [Hz]';'1250 [Hz]';'1600 [Hz]';'2000 [Hz]';'2500 [Hz]';'3150 [Hz]'...
    ;'4000 [Hz]';'5000 [Hz]';'6300 [Hz]';'8000 [Hz]'},'Visible','off','Value',10);

%% ########## TABLA ########

tabla.titulo = uicontrol('parent', tab_2,'style','text','string','Tabla de resultados',...
        'units','normalized','position',[0.03 0.26 0.35 0.05],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
tabladsp = uitable('parent', tab_2,'units','normalized','Position',[0.03 0.08 0.55 0.16],...
    'RowName',{'EDT [s]','TR10 [s]','TR20 [s]','TR30 [s]'},'BackgroundColor',[0.7 0.75 0.8]);
    % Pushbutton de 'Exportar tabla' está al final del Back-end por
    % cuestiones de sintaxis de MatLab
%% ###### FILTROS Y SELECCION DE IR ######
% Textbox

filtros_titulo = uicontrol('parent', tab_2,'style','text','string','Tipos de filtros y selección de IR',...
        'units','normalized','position',[0.03 0.59 0.35 0.05],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
filtros_impulsotext = uicontrol('parent', tab_2,'style','text','string','Impulsos creados','units','normalized',...
        'position',[0.04 0.53 0.1 0.05],'fontsize',11);

% Buttongroup Extremos
filtros_exitacion_bg = uibuttongroup('parent', tab_2,'units','normalized','position',[0.15 0.40 0.22 0.08],'title',...
    'Bandas de exitación: ','fontsize',10) ; 
% Popup Menu's
filtros_exitacion_inf = uicontrol('parent',filtros_exitacion_bg,'style','popupmenu','units','normalized','position',[0.05 0 0.4 0.8],...
    'string',' ');
filtros_exitacion_a = uicontrol('parent',filtros_exitacion_bg,'style','text','units','normalized','position',[0.45 0 0.1 0.8],...
    'string','a','fontsize',11);
filtros_exitacion_sup = uicontrol('parent',filtros_exitacion_bg,'style','popupmenu','units','normalized','position',[0.55 0 0.4 0.8],...
    'string',' ');
% Buttongroup Filtro
filtros_buttongroup = uibuttongroup('parent', tab_2,'units','normalized','position',[0.15 0.49 0.22 0.07],'title',...
    'Tipo de filtro: ','fontsize',10,'SelectionChangedFcn',{@selectfiltro,filtros_exitacion_inf,filtros_exitacion_sup}) ; 

% Radiobuttons
    filt_octava = uicontrol('parent',filtros_buttongroup,'units','normalized','style','radiobutton','position',[0.1 0 0.4 1],...
        'string','Octava');
    filt_teroctava = uicontrol('parent',filtros_buttongroup,'units','normalized','style','radiobutton','position',[0.5 0 0.4 1],...
        'string','Tercio de Octava');
    filt_octava.Value = 0;
    filt_teroctava.Value = 0;
% Listbox
filtros_listbox = uicontrol('parent', tab_2,'style','list','string','','units','normalized','position',...
    [0.04 0.365 0.1 0.18]);

% Pushbutton's
filtros_addir = uicontrol('parent', tab_2,'style','pushbutton','string','Añadir IR externo','units','normalized',...
        'position',[0.04 0.33 0.1 0.03],'callback',{@irexterno,filtros_listbox});

    % Los dos botones que restan estan al final del back-end por cuestiones
    % de sintaxis de MatLab

%% ###### GRAFICOS DSP ######

% Textbox's
graficosdsp_titulo = uicontrol('parent', tab_2,'style','text','string','Gráficos',...
        'units','normalized','position',[0.4 0.79 0.57 0.050],'fontsize',20,...
        'backgroundcolor',[1 98/255 98/255]);

graficodsp_bandatext = uicontrol('parent', tab_2,'style','text','units','normalized','position',[0.41 0.705 0.1 0.035],'string',...
    'Banda','fontsize',12,'BackGroundColor',[200/255 200/255 200/255]);
% Checkboxs
graficodsp.schroedercheck = uicontrol('parent', tab_2,'style','checkbox','units','normalized','position',[0.43 0.615 0.06 0.035],...
    'string','Schroeder','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.EDTcheck = uicontrol('parent', tab_2,'style','checkbox','units','normalized','position',[0.43 0.565 0.06 0.035],...
    'string','EDT','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.T10check = uicontrol('parent', tab_2,'style','checkbox','units','normalized','position',[0.43 0.515 0.06 0.035],...
    'string','T10','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.T20check = uicontrol('parent', tab_2,'style','checkbox','units','normalized','position',[0.43 0.465 0.06 0.035],...
    'string','T20','BackGroundColor',[200/255 200/255 200/255]);
graficodsp.T30check = uicontrol('parent', tab_2,'style','checkbox','units','normalized','position',[0.43 0.415 0.06 0.035],...
    'string','T30','BackGroundColor',[200/255 200/255 200/255]);

% Buttongroup
graficodsp_bg = uibuttongroup('parent', tab_2,'units','normalized','position',[0.6 0.1 0.22 0.07],'title',...
    'Parametro','fontsize',10) ; 
% Radiobuttons
    radio_EDT = uicontrol('parent',graficodsp_bg,'units','normalized','style','radiobutton','position',[0.1 0 0.4 1],...
        'string','EDT');
    radio_T30 = uicontrol('parent',graficodsp_bg,'units','normalized','style','radiobutton','position',[0.5 0 0.4 1],...
        'string','T30');
    radio_EDT.Value = 0;
    radio_T30.Value = 0;

% Axes
graficodsp_axes = axes('parent', tab_2,'units','normalized','position',[0.57 0.3 0.4 0.45]);xlabel('');ylabel('');title('');

% Pushbutton
graficosdsp_plot = uicontrol('parent', tab_2,'style','pushbutton','string','Graficar','units','normalized',...
    'position',[0.42 0.365 0.08 0.035],'callback',...
    {@graficardsp,graficodsp_bandaspumoct,graficodsp_bandaspumter,graficodsp_axes,filt_octava,filt_teroctava,filtros_listbox,graficodsp});
graficodsp_export = uicontrol('parent', tab_2,'style','pushbutton','string','Exportar gráfico','units','normalized',...
    'position',[0.42 0.325 0.08 0.035]);
graficodsp_parametros = uicontrol('parent', tab_2,'style','pushbutton','string','Graficar Parametros','units','normalized',...
    'position',[0.9 0.1 0.08 0.035],'callback',{@graficarparametros,filt_octava,filt_teroctava,filtros_exitacion_inf,filtros_exitacion_sup,graficodsp_axes,radio_EDT,radio_T30});
%% ###### CREACIÓN DEL IMPULSO #####
%Textbox
imp.titulo = uicontrol('parent', tab_2,'style','text','string','Generación del IR',...
        'units','normalized','position',[0.03 0.79 0.35 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 255/255]);
imp.descripcion = uicontrol('parent', tab_2,'style','text','units','normalized','string',...
    ['El generador de IR funciona convolucionando la toma seleccionada con el ' ...
    'filtro inverso generado en el momento de la medición'],'position',[0.035 0.66 0.175 0.08]);
    imp.descripcion.HorizontalAlignment = 'center';

% Pushbuttons

imp.selecciondetomas_wav = uicontrol('parent', tab_2,'style','pushbutton','units','normalized',...
    'position',[0.22 0.68 0.14 0.05],'string','Selección de tomas en formato .wav','callback',...
    {@selecciondetomaswav,filtros_listbox});
%% Pushbuttons Filtrado

filtros_process = uicontrol('parent', tab_2,'style','pushbutton','string','Procesar impulso','units','normalized',...
        'position',[0.15 0.33 0.11 0.05],'fontsize',11,'callback',...
        {@processsignal,filtros_listbox,filt_octava,filt_teroctava,tabladsp,graficodsp_bandaspumter,graficodsp_bandaspumoct,graficodsp,filtros_exitacion_inf,filtros_exitacion_sup});
filtros_promedio = uicontrol('parent', tab_2,'style','pushbutton','string','Promediar impulsos','units','normalized',...
        'position',[0.26 0.33 0.11 0.05],'fontsize',11,'callback',...
        {@promediosignal,filt_octava,filt_teroctava,tabladsp,filtros_exitacion_inf,filtros_exitacion_sup});
    
%% Pushbutton Exportar tabla

tabla_exportar = uicontrol('parent', tab_2,'style','pushbutton','string','Exportar tabla',...
        'units','normalized','position',[0.48 0.02 0.1 0.05],'callback',{@exportar_csv,tabladsp});
f.Visible = 'off';

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
    'normalized','position',[0.75 0.05 0.20 0.1],'callback',{@siguiente,proyecto_e,directorio_e,startup,f,filtros_listbox});
cargarproyecto_pb = uicontrol('parent',startup,'style','pushbutton','string','Cargar proyecto',...
    'units','normalized','position',[0.05 0.05 0.20 0.1],'callback',{@cargarproyecto,startup,f,filtros_listbox});
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
function siguiente(object_handle,event,proyecto_e,directorio_e,startup,f,filtros_listbox)
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
        startup.Visible = 'off';
        f.Visible = 'on';
    catch
        errordlg('Revise los campos','Error')
    end
end

function cargarproyecto(object_handle,event,startup,f,filtros_listbox)
    try
        direct = uigetdir;
        oldfolder = cd(direct);
        addpath(genpath(direct));
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
        startup.Visible = 'off';
        f.Visible = 'on';
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
function close_0(object_handle,event,f)
    msgbox('Muchas gracias por utilizar el software')
    f.Visible = 'off';
end



 
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
 function processsignal(object_handle,event,filtros_listbox,filt_octava,filt_teroctava,tabladsp,graficodsp_bandaspumter,graficodsp_bandaspumoct,graficodsp,filtros_exitacion_inf,filtros_exitacion_sup)
    loadingbar = waitbar(0,'...Procesando señal...'); 
    pasos = 8;
    global Fs
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
    global suavizadoporbanda
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
    global matrizresultados
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
 end
 
 %% PROMEDIOS SIGNALS
 function promediosignal(object_handle,event,filt_octava,filt_teroctava,tabladsp,filtros_exitacion_inf,filtros_exitacion_sup)
    global Fs
    try
        cd Tomas\IRs
            [file,path] = uigetfile('*.wav','Seleccione las IRs que desea promediar','','MultiSelect','on');
            cd ..\..
        file = string(file);
    catch
    end
    loadingbar = waitbar(0,'...Procesando señales...');
    pasos = 11;
    global matrizresultados
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
 %% GRAFICAR IRS
 function graficardsp(object_handle,event,graficodsp_bandaspumoct,graficodsp_bandaspumter,graficodsp_axes,filt_octava,filt_teroctava,filtros_listbox,graficodsp)
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
        [plot_EDT,plot_T10,plot_T20,plot_T30,plot_schroeder] = GraficosParametros(banda);
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
 %% GRAFICAR PARAMETROS
 function graficarparametros(object_handle,event,filt_octava,filt_teroctava,filtros_exitacion_inf,filtros_exitacion_sup,graficodsp_axes,radio_EDT,radio_T30)
 global Fs matrizresultados
 cla(graficodsp_axes)
 set(graficodsp_axes,'XScale','log')
 if get(filt_octava,'Value') == 1                     
    if Fs == 44100
                x_plot = [31.5 63 125 250 500 1000 2000 4000 8000];        
    elseif Fs == 48000
                x_plot = [31.5 63 125 250 500 1000 2000 4000 8000 16000];
    end
 elseif get(filt_teroctava,'Value') == 1   
    x_plot = [25 31.5 40 50 63 80 100 125 160 ... 
 200 250 315 400 500 630 800 1000 1250 ...
 1600 2000 2500 3150 4000 5000 6300 8000 ... 
 10000 12500 16000];
 end
 a = get(filtros_exitacion_inf,'Value');
 b = get(filtros_exitacion_sup,'Value');
 
 if get(radio_EDT,'Value')==1                     
     cla(graficodsp_axes)
     bar_EDT = matrizresultados(1,a:b);
     bar_EDT = cell2mat(bar_EDT);
     x_plot = x_plot(1,a:b);
     axes(graficodsp_axes)
     EDT_bar = bar(x_plot,bar_EDT);xlabel('Frecuencia [Hz]');ylabel('Tiempo [s]');
     title('EDT');%set(gca,'XScale','log');
     EDT_bar.BarWidth = 4;
     grid on
 elseif get(radio_T30,'Value')==1  
     cla(graficodsp_axes)
     bar_T30 = matrizresultados(4,a:b);
     bar_T30 = cell2mat(bar_T30);
     x_plot = x_plot(1,a:b);
     axes(graficodsp_axes)
     T30_bar = bar(x_plot,bar_T30);xlabel('Frecuencia [Hz]');ylabel('Tiempo [s]');
     title('T30');%set(gca,'XScale','log');
     T30_bar.BarWidth = 4;
     grid on
 end
 end
 
 
 %% Exportar Tabla
function exportar_csv(object_handle,event,tabladsp)
 M =  tabladsp.Data ;
 J = numel(M);
 if J == 36 
    tabla_1 = table({' ';'EDT';'T10';'T20';'T30'},{'31.5[Hz]';M{1,1};M{2,1};M{3,1};M{4,1}},...
          {'63[Hz]';M{1,2};M{2,2};M{3,2};M{4,2}},...
          {'125[Hz]';M{1,3};M{2,3};M{3,3};M{4,3}},...
          {'250[Hz]';M{1,4};M{2,4};M{3,4};M{4,4}},...
          {'500[Hz]';M{1,5};M{2,5};M{3,5};M{4,5}},...
          {'1000[Hz]';M{1,6};M{2,6};M{3,6};M{4,6}},...
          {'2000[Hz]';M{1,7};M{2,7};M{3,7};M{4,7}},...
          {'4000[Hz]';M{1,8};M{2,8};M{3,8};M{4,8}},...
          {'8000[Hz]';M{1,9};M{2,9};M{3,9};M{4,9}});
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Resultados\ParametrosAcusticos_FiltroOctava.csv'] ;
    writetable(tabla_1,name_csv)
    warndlg('Resultados guardadados correctamente en formato .csv dentro de la carpeta "Resultados"',' ');
 
 elseif J == 40
    tabla_1 = table({' ';'EDT';'T10';'T20';'T30'},{'31.5[Hz]';M{1,1};M{2,1};M{3,1};M{4,1}},...
          {'63[Hz]';M{1,2};M{2,2};M{3,2};M{4,2}},...
          {'125[Hz]';M{1,3};M{2,3};M{3,3};M{4,3}},...
          {'250[Hz]';M{1,4};M{2,4};M{3,4};M{4,4}},...
          {'500[Hz]';M{1,5};M{2,5};M{3,5};M{4,5}},...
          {'1000[Hz]';M{1,6};M{2,6};M{3,6};M{4,6}},...
          {'2000[Hz]';M{1,7};M{2,7};M{3,7};M{4,7}},...
          {'4000[Hz]';M{1,8};M{2,8};M{3,8};M{4,8}},...
          {'8000[Hz]';M{1,9};M{2,9};M{3,9};M{4,9}},...
          {'16000[Hz]';M{1,10};M{2,10};M{3,10};M{4,10}});      
    path_actual = pwd; % Dirección de la carpeta actual en uso
    name_csv = [path_actual '\Resultados\ParametrosAcusticos_FiltroOctava.csv'] ;
    writetable(tabla_1,name_csv)
    warndlg('Resultados guardadados correctamente en formato .csv dentro de la carpeta "Resultados"',' ');
 
 else     
     tabla_2 = table({' ';'EDT';'T10';'T20';'T30'},{'25[Hz]';M{1,1};M{2,1};M{3,1};M{4,1}},{'31.5[Hz]';M{1,2};M{2,2};M{3,2};M{4,2}},...
         {'40[Hz]';M{1,3};M{2,3};M{3,3};M{4,3}},{'50[Hz]';M{1,4};M{2,4};M{3,4};M{4,4}},{'63 [Hz]';M{1,5};M{2,5};M{3,5};M{4,5}},...
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
 