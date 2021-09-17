function guiqueonda()

my_slider()

end

function my_slider()
Figdata = figure('Visible','on','Name','Procesado de señales','MenuBar','none','Position',[550,150,1000,800]);

slider = uicontrol('Parent', Figdata,'Style','slider',...
         'Units','normalized',...
         'Position',[0.3 0.5 0.4 0.1],...
         'Tag','slider1',...
         'UserData',struct('val',0,'diffMax',1),...
         'Callback',@slider_callback);
     
button = uicontrol('Parent', Figdata,'Style','pushbutton',...
         'Units','normalized',...
         'Position',[0.4 0.3 0.2 0.1],...
         'String','Display Difference',...
         'Callback',@button_callback);
     
UIT = uitable(Figdata,'Tag','Tabla','RowName',{'EDT' 'T10' 'T20' 'T30'},'Position',[5,5,990,150]);

textocontala = uicontrol('Parent', Figdata,'Style','text',...
         'Units','normalized',...
         'Position',[100,100,100,100],...
         'String','Display Difference',...
         'Callback',@button_callback);

end

function slider_callback(hObject,eventdata)
	sval = hObject.Value;
	diffMax = hObject.Max - sval;
	data = struct('val',sval,'diffMax',diffMax);
	hObject.UserData = data;
	% For R2014a and earlier: 
	% sval = get(hObject,'Value');  
	% maxval = get(hObject,'Max');  
	% diffMax = maxval - sval;      
	% data = struct('val',sval,'diffMax',diffMax);   
	% set(hObject,'UserData',data);   

end

function button_callback(hObject,eventdata)
	h = findobj('Tag','slider1');
	data = h.UserData;
	% For R2014a and earlier: 
	% data = get(h,'UserData'); 
	display([data.val data.diffMax]);
    textocontala.String=[data.val data.diffMax];
end


function UIT_callback(hObject,eventdata)
	h = findobj('Tag','slider1');
	data = h.UserData;
	display([data.val data.diffMax]);
end