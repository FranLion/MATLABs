% ###########################################################################
%  ######                  TRABAJO PRACTICO FINAL                       ######
%  ######                    "Efecto de Gibbs"                          ######
%  ###########################################################################
%  ######                       ESTUDIANTES                             ######
%  ######         *Castelli, Corina.     *Espíndola, Agustín.           ######
%  ######         *Passano, Nahuel.      *Ricciardi, Micaela.           ######
%  ###########################################################################

%% #### INTERFAZ GRÁFICA ####

%%figura

fig = figure('Visible','on','units','normalized','Position',[0 0 1 0.96],'Name','Aproximación por Serie de Fourier y Efecto de Gibbs',...
    'NumberTitle','off','toolbar','none'); fig.MenuBar = 'none';

%% Título y logo
titulo = uicontrol('parent', fig ,'style','text','string' , 'Aproximación por Serie de Fourier y Efecto de Gibbs','units','normalized',...
        'position',[0.15 0.872 0.70 0.09],'fontsize',24,'backgroundcolor',[3/200 0 104/255],'foregroundcolor',...
        [1 1 1],'fontweight','bold'); 
logo = axes('units','normalized','position',[0.05 0.865 0.10 0.11]);
axes(logo);
imshow('UNTREF-LOGO.png');
    
%%
   Signal = uicontrol('parent',fig,'style','text','string','Señal',...
        'units','normalized','position',[0.05 0.79 0.29 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 155/255]);
    
    Iteracion = uicontrol('parent',fig,'style','text','string','Iteración en la aproximación',...
        'units','normalized','position',[0.35 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[90/255 165/255 155/255]);
    
    Resultados = uicontrol('parent',fig,'style','text','string','Resultados',...
        'units','normalized','position',[0.66 0.79 0.30 0.050],'fontsize',20,...
        'backgroundcolor',[70/255 165/255 155/255]);
    
    result_panel = uipanel ('parent', fig, 'Title','','FontSize',11,...
             'Position',[0.67 0.56 0.28 0.20]);
        armonicos = uicontrol('parent',result_panel,'units','normalized',...
            'Position',[0.29 0.75 0.28 0.18],...
            'Style','Text',...
            'Fontsize',14,'String','Armónicos: ');
        armonicos_r = uicontrol('parent',result_panel,'units','normalized',...
            'Position',[0.55 0.75 0.18 0.18],...
            'Style','Text',...
            'Fontsize',14,'String','');
        gibbs = uicontrol('parent',result_panel,'units','normalized',...
            'Position',[0.29 0.15 0.28 0.19],...
            'Style','Text',...
            'Fontsize',14,'String','Gibbs [%]: ');
        gibbs_r = uicontrol('parent',result_panel,'units','normalized',...
            'Position',[0.54 0.15 0.19 0.18],...
            'Style','Text',...
            'Fontsize',14,'String','');
        ecm = uicontrol('parent',result_panel,'units','normalized',...
            'Position',[0.29 0.45 0.28 0.18],...
            'Style','Text',...
            'Fontsize',14,'String','ECM: ');
        ecm_r = uicontrol('parent',result_panel,'units','normalized',...
            'Position',[0.5 0.45 0.28 0.18],...
            'Style','Text',...
            'Fontsize',14,'String','');
         
popupmenu = uicontrol('style','popup','units','normalized','position',....
    [0.2 0.72 0.1 0.05],'string',{'Diente de sierra', 'Tren de pulsos','Triangular'},'fontsize', 11);

SeleccionSignal = uicontrol('parent',fig,'Style','text','String','Seleccione la señal ', ...
            'Units','Normalized','position',[0.08 0.715 0.11 0.050],'fontsize' , 11);

%textos
    amplitu_text = uicontrol('style','text','string','Amplitud:','units','normalized',...
        'position',[0.045 0.661 0.08 0.05],'fontsize',11);
    
    frecuencia_text = uicontrol('style','text','string','Frecuencia [Hz]:','units','normalized',...
        'position',[0.18 0.66 0.1 0.05],'fontsize',11);
    
    
    criterio_text = uicontrol('style','text','string','','units','normalized',...
        'position',[0.06 0.488 0.1 0.05],'fontsize',11);
    
%editbox
    amplitud_e = uicontrol('style','edit','string','','units','normalized',...
                    'position',[0.11 0.68 0.06 0.03],'fontsize',11);
    
    frecuencia_e = uicontrol('style','edit','string','','units','normalized',...
                    'position',[0.27 0.68 0.06 0.03],'fontsize',11);
    
    criterio_e = uicontrol('style','edit','string','','units','normalized',...
                        'position',[0.145 0.51 0.06 0.03],'fontsize',11,'Visible','off');

%BUTTONGROUP
        criterio_bg = uibuttongroup('parent',fig,'Title','Criterio de corte por: ', ...
            'Units','Normalized','position',[0.07 0.57 0.25 0.1],'fontsize' , 11,...
            'SelectionChangedFcn',{@criterio_del_bg,criterio_e,criterio_text});
            armonicos_rb = uicontrol('parent',criterio_bg,'Style','radiobutton','String','Armonicos',...
                'units','normalized','position',[0.17 0.1 0.4 0.8],'fontsize',10);
            ECM_rb = uicontrol('parent',criterio_bg,'Style','radiobutton','String','ECM mínimo',...
                'units','normalized','position',[0.55 0.1 0.4 0.8],'fontsize',10);
            armonicos_rb.Value = 0 ;
            ECM_rb.Value = 0 ;

%Informacion extra figurita
info_extra = figure('visible','off','units','normalized','position',[0.35 0.4 0.35 0.2],...
        'NumberTitle','off','toolbar','none');
    info_title = uicontrol('parent',info_extra,'style','text','string','Estudiantes','units','normalized',...
        'position',[0 0.6 1 0.2],'fontsize',14);
    info_text = uicontrol('parent',info_extra,'style','text','string',...
        ['Castelli, Corina (castellicr2111@gmail.com) // Espíndola,Agustín (agustinespindola96@gmail.com) // Passano, Nahuel (n.passano@hotmail.com) // Ricciardi Micaela (skeree)'],...
        'units','normalized','position',[0.1 0.3 0.8 0.3]);
%% axes
axes_fourier = axes('parent',fig,'units','normalized','position',[0.09 0.09 0.35 0.35]);xlabel('Tiempo [s]');
                ylabel('Amplitud');grid on;
axes_zoom = axes('parent',fig,'units','normalized','position',[0.56 0.09 0.35 0.35]);xlabel('Tiempo [s]');
             ylabel('Amplitud');grid on;            
%% Iteracion en el grafico

iteracion_text_1 = uicontrol('parent',fig ,'style','text','string','Desde','units','normalized',...
        'position',[0.36 0.7 0.08 0.05],'fontsize',12);
iteracion_text_2 = uicontrol('parent',fig ,'style','text','string','hasta','units','normalized',...
        'position',[0.443 0.7 0.08 0.05],'fontsize',12);
iteracion_text_3 = uicontrol('parent',fig ,'style','text','string','armonicos','units','normalized',...
        'position',[0.54 0.7 0.08 0.05],'fontsize',12);
iteracion_text_4 = uicontrol('parent',fig ,'style','text','string','con paso de ','units','normalized',...
        'position',[0.425 0.65 0.08 0.05],'fontsize',12);
iteracion_text_5 = uicontrol('parent',fig ,'style','text','string','[s]','units','normalized',...
        'position',[0.515 0.65 0.08 0.05],'fontsize',12);
iteracion_text_6 = uicontrol('parent',fig ,'style','text','string','N° de armonicos :','units','normalized',...
        'position',[0.43 0.52 0.1 0.05],'fontsize',12,'Visible','off');
iteracion_armonicos = uicontrol('parent',fig ,'style','text','string','','units','normalized',...
        'position',[0.525 0.52 0.03 0.05],'fontsize',12);
    
iteracion_inf = uicontrol('parent',fig ,'style','edit','string','','units','normalized',...
        'position',[0.425 0.72 0.03 0.03],'fontsize',11);
iteracion_sup = uicontrol('parent',fig ,'style','edit','string','','units','normalized',...
        'position',[0.51 0.72 0.03 0.03],'fontsize',11);
iteracion_paso = uicontrol('parent',fig ,'style','edit','string','','units','normalized',...
        'position',[0.505 0.67 0.03 0.03],'fontsize',11);

iteracion_pb = uicontrol('parent',fig ,'style','pushbutton','string','Iterar aproximación','units','normalized',...
        'position',[0.43 0.595 0.13 0.04],'fontsize',12,'callback',{@iteracion,iteracion_inf,iteracion_sup,iteracion_paso, amplitud_e, frecuencia_e, popupmenu,gibbs_r,axes_fourier,axes_zoom,ecm_r,armonicos_r,iteracion_armonicos,iteracion_text_6});

%% BOTONGGG
    calcular_pb = uicontrol('parent',fig ,'style','pushbutton','string','Calcular', ...
                    'units','normalized','position',[0.22 0.50 0.1 0.05],'fontsize', 11,...
                    'callback', {@calculo,  amplitud_e, frecuencia_e, criterio_e, popupmenu,gibbs_r,axes_fourier,axes_zoom,ecm_r,armonicos_rb,ECM_rb,armonicos_r,iteracion_armonicos,iteracion_text_6,result_panel});
    guardar_pb = uicontrol('parent', fig ,'style','pushbutton','string','Guardar resultados', ...
                    'units','normalized','position',[0.745 0.51 0.13 0.04],'fontsize', 11,'Callback',{@guardar_resultados,gibbs_r,ecm_r,armonicos_r,result_panel});
    info_pb = uicontrol('parent', fig ,'style','pushbutton','string','Información extra', ...
                    'units','normalized','position',[0.86 0.918 0.1 0.044],'fontsize', 11,...
                    'callback',{@info,info_extra});
    final_pb = uicontrol('parent', fig ,'style','pushbutton','string','Finalizar', ...
                    'units','normalized','position',[0.86 0.872 0.1 0.044],'fontsize', 11,...
                    'callback', {@fin, fig});


%% #################################################################################
%% ################################### FUNCIONES ###################################
%% #################################################################################
function criterio_del_bg(source,event,criterio_e,criterio_text)
     criterio_str = event.NewValue.String;
     set(criterio_text,'String',criterio_str);
     criterio_e.String = '';
     criterio_e.Visible = 'on';
 end
                
function info(object_handle, event, info_extra)
    try
        info_extra.Visible = 'on';
    catch
    end
end
function fin(object_handle,event,fig)
    msgbox('Muchas gracias por utilizar el software')
    fig.Visible = 'off';
end
%% ITERACION
function iteracion(object_handle,event, iteracion_inf,iteracion_sup,iteracion_paso, amplitud_e, frecuencia_e, popupmenu,gibbs_r,axes_fourier,axes_zoom,ecm_r,armonicos_r,iteracion_armonicos,iteracion_text_6)
iteracion_inf = get(iteracion_inf,'String');
iteracion_inf = str2num(iteracion_inf);
iteracion_sup = get(iteracion_sup,'String');
iteracion_sup = str2num(iteracion_sup);
try
    iteracion_armonicos.Visible = 'on';
    iteracion_text_6.Visible = 'on';
for ite=iteracion_inf:iteracion_sup

    n_terms = ite;
    f  = get(frecuencia_e, 'string');
    f = str2num(f);
    A  = get(amplitud_e, 'string');
    A = str2num(A);
    signal_pop = popupmenu.Value;
        switch signal_pop
            case 1
                choise = 1;
            case 2
                choise = 0 ;
            case 3
                choise = 2 ;
        end
    [y_fourier,y_t,t,tn,porcentaje_gibbs,ECM] = aprox_por_fourier(choise,n_terms,f,A) ;
    T = 1/f;  
    resultado_gibbs = porcentaje_gibbs ;
    resultado_gibbs = num2str(resultado_gibbs) ;
    %Ploteo
    axes(axes_fourier)
        hold on
        cla
        plot(t,y_fourier)
        plot(tn,y_t)
        legend('Fourier','Original')
        xlabel('Tiempo [s]');ylabel('Amplitud')
        grid on
        hold off
        xlim([(-T) (T)]);
        if choise == 0 || choise == 2
            ylim([(-1/2)*A (3/2)*A]);
            titulo = ['Tren de pulsos'];
            titulo_zoom = [titulo ' - ZOOM'];
            if choise == 2
                titulo = ['Triangular'];
                titulo_zoom = [titulo ' - ZOOM'];
                
            end
        elseif choise == 1 
            ylim([(-3/2)*A (3/2)*A]);
            titulo = ['Diente de sierra'];
            titulo_zoom = [titulo ' - ZOOM'];
        end
        title(titulo)
                grid minor
    axes(axes_zoom)   
    
        plot(t,y_fourier)
        hold on
        plot(tn,y_t)
                legend('Fourier','Original')
        title(titulo_zoom)
        xlabel('Tiempo [s]');ylabel('Amplitud')
        if choise ==2
            xlim([-T/10 T/10]);

        else
            xlim([(T/2)-T/15 (T/2)+T/15]);
        end
        ylim([(8/10)*A (12/10)*A])
        grid on
        grid minor
        hold off
    
    if choise == 2
        gibbs_r.String = '-';
    else
        gibbs_r.String = resultado_gibbs;
    end
        ecm_r.String = ECM; 
        armonicos_r.String = n_terms;
        iteracion_armonicos.String = ite;
    pause(str2num(get(iteracion_paso,'String')));
end

catch
errordlg('Revise los campos entrantes','Error')    
end

end

%% ###### CALCULO ######
function calculo(object_handle, event,  amplitud_e, frecuencia_e, criterio_e, popupmenu,gibbs_r,axes_fourier,axes_zoom,ecm_r,armonicos_rb,ECM_rb,armonicos_r,iteracion_armonicos,iteracion_text_6,result_panel);
iteracion_armonicos.Visible = 'off';
iteracion_text_6.Visible = 'off';
try
if armonicos_rb.Value == 1
    loadingbar = waitbar(0,'...Procesando señal...');
    pasos = 5;
    cla
    n_terms  = get(criterio_e, 'string');
    n_terms = str2num(n_terms);
    f  = get(frecuencia_e, 'string');
    f = str2num(f);
    A  = get(amplitud_e, 'string');
    A = str2num(A);
    waitbar(1/pasos)
    signal_pop = popupmenu.Value;
        switch signal_pop
            case 1
                choise = 1;
            case 2
                choise = 0 ;
            case 3
                choise = 2 ;
        end
    waitbar(2/pasos)
    [y_fourier,y_t,t,tn,porcentaje_gibbs,ECM] = aprox_por_fourier(choise,n_terms,f,A) ;
    waitbar(3/pasos)
    T = 1/f;  
    resultado_gibbs = porcentaje_gibbs ;
    resultado_gibbs = num2str(resultado_gibbs) ;
    %Ploteo
    axes(axes_fourier)
        hold on
        cla
        plot(t,y_fourier)
        plot(tn,y_t)
        legend('Fourier','Original')
        xlabel('Tiempo [s]');ylabel('Amplitud')
        grid on
        hold off
        xlim([(-T) (T)]);
        if choise == 0 || choise == 2
            ylim([(-1/2)*A (3/2)*A]);
            titulo = ['Tren de pulsos'];
            titulo_zoom = [titulo ' - ZOOM'];
            if choise == 2
                titulo = ['Triangular'];
                titulo_zoom = [titulo ' - ZOOM'];
                
            end
        elseif choise == 1 
            ylim([(-3/2)*A (3/2)*A]);
            titulo = ['Diente de sierra'];
            titulo_zoom = [titulo ' - ZOOM'];
        end
        title(titulo)
                grid minor
    waitbar(4/pasos)
    axes(axes_zoom)   
 
        plot(t,y_fourier)
        hold on
        plot(tn,y_t)
                legend('Fourier','Original')
        title(titulo_zoom)
        xlabel('Tiempo [s]');ylabel('Amplitud')
        if choise ==2
            xlim([-T/10 T/10]);

        else
            xlim([(T/2)-T/15 (T/2)+T/15]);
        end
        ylim([(8/10)*A (12/10)*A])
        grid on
        grid minor
        hold off
    
    if choise == 2
        gibbs_r.String = '-';
        warndlg('En señales continuas no esta presente el efecto de Gibbs','');
    else
        gibbs_r.String = resultado_gibbs;
    end
        ecm_r.String = ECM; 
        armonicos_r.String = n_terms;
waitbar(1)
close(loadingbar)

elseif ECM_rb.Value == 1
    loadingbar = waitbar(0,'...Procesando señales...');
    pasos = 7;
    cla
    ECM_usuario  = get(criterio_e, 'string');
    ECM_usuario = str2num(ECM_usuario);
    f  = get(frecuencia_e, 'string');
    f = str2num(f);
    A  = get(amplitud_e, 'string');
    A = str2num(A);
    signal_pop = popupmenu.Value;
    waitbar(1/pasos)
        switch signal_pop
            case 1
                choise = 1;
            case 2
                choise = 0 ;
            case 3
                choise = 2 ;
        end
    ECM = 10000000;
    waitbar(2/pasos)
    for q=1:100
        if ECM > ECM_usuario
            waitbar(3/pasos)
            [y_fourier,y_t,t,tn,porcentaje_gibbs,ECM] = aprox_por_fourier(choise,q,f,A) ;
            nro_armonicos = q;
            waitbar(4/pasos)
        else 
            break
        end
        if q == 100
            errordlg('No es posible conseguir el ECM solicitado','Error')
        end
    end
    T = 1/f;  
    resultado_gibbs = porcentaje_gibbs ;
    resultado_gibbs = num2str(resultado_gibbs) ;
    waitbar(5/pasos)
    %Ploteo
    axes(axes_fourier)
        hold on
        cla
        plot(t,y_fourier)
        plot(tn,y_t)
        legend('Fourier','Original')
        xlabel('Tiempo [s]');ylabel('Amplitud')
        grid on
        grid minor
        hold off
        xlim([(-T) (T)]);
        if choise == 0 || choise == 2
            ylim([(-1/2)*A (3/2)*A]);
            titulo = ['Tren de pulsos'];
            titulo_zoom = [titulo ' - ZOOM'];
            if choise == 2
                titulo = ['Triangular'];
                titulo_zoom = [titulo ' - ZOOM'];
               
            end
        elseif choise == 1 
            ylim([(-3/2)*A (3/2)*A]);
            titulo = ['Diente de sierra'];
            titulo_zoom = [titulo ' - ZOOM'];
        end
        title(titulo)
    
    waitbar(6/pasos)
        axes(axes_zoom)  
        cla
        plot(t,y_fourier)
        hold on
        plot(tn,y_t)
                legend('Fourier','Original')
        title(titulo_zoom)
        xlabel('Tiempo [s]');ylabel('Amplitud')
        if choise ==2
            xlim([-T/10 T/10]);

        else
            xlim([(T/2)-T/15 (T/2)+T/15]);
        end
        ylim([(8/10)*A (12/10)*A])
        grid on
        grid minor
        hold off
    
    if choise == 2
        gibbs_r.String = '-';
        warndlg('En señales continuas no esta presente el efecto de Gibbs','');
    else
        gibbs_r.String = resultado_gibbs;
    end
        ecm_r.String = ECM; 
        armonicos_r.String = nro_armonicos;
waitbar(1)
close(loadingbar)
end
senial = popupmenu.String;
senial = senial(signal_pop);
result_panel.Title = [char(senial) ' - Amplitud: ' char(num2str(A)) ' - Frecuencia [Hz]: ' char(num2str(f))];

catch
    errordlg('Revise los campos entrantes','Error');
end
end

%% ###### GUARDAR RESULTADOS ######
function guardar_resultados(object_handle, event,gibbs_r,ecm_r,armonicos_r,result_panel,popupmenu)    %funcion para guardar los resultados
         
        
        resultadogibbs = get(gibbs_r,'String');  
        resultadogibbs = str2num(resultadogibbs);
        resultadoarmonicos = get(armonicos_r,'String');
        resultadosecm = get(ecm_r,'String');
         titulito = result_panel.Title ;

        
        result = ["Señal", titulito ; "Gibbs[%]",resultadogibbs; "Armónicos",resultadoarmonicos; "ECM",resultadosecm];        
         
         
     path_actual = pwd; % Dirección de la carpeta actual en uso
     name_xls = [path_actual 'Resultados .xls'];
     xlswrite(name_xls, result ,'A1:B4');
     warndlg('Información guardada correctamente en formato .xls (Excel)',' ')
end 