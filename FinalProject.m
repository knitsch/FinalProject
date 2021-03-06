function [] = FinalProject()
    close all;
%main function will have 3 textboxes, with 3 ui edit elements saying "i
%component, j component, k component. Also will have a plot button
    global gui;
    
    gui.fig = figure('numbertitle','off','name','Vector Field Plot','Position',[100 50 960 480]);%establishing figure and plot
    [x,y,z] = meshgrid(-11:2:11);
    %meshgrid must not include 0s or it will not work for equations of the
    %form 1/x, 1/y, 1/z, etc... using gaps of 2 from odd numbers avoids the
    %number 0.
    
    %creates u v and w components to be dimensionally consistend with the
    %meshgrid to make a blank plot
    u = 0.*x;
    v = 0.*y;
    w = 0.*z; 
    
    %sets up the empty quiver3 function;
    gui.q3 = quiver3(x,y,z,u,v,w);
    gui.q3.Parent.Position = [.4, .05, .55, .9];    %moves the quiver3 plot
    zoom reset;% sets the base zoom level
    xlabel('x');
    ylabel('y');
    zlabel('z');
    %I component
    gui.iTextbox = uicontrol('style','text','units','normalized','position',[.01 .7 .2 .2],'String','i vector component: f(x,y,z) = ','horizontalalignment','left');
    gui.iEditBox = uicontrol('style','edit','units','normalized','position',[.16 .875 .15 .04],'String','0');
  
    %J component
    gui.jTextbox = uicontrol('style','text','units','normalized','position',[.01 .6 .2 .2],'String','j vector component: f(x,y,z) = ','horizontalalignment','left');
    gui.jEditBox = uicontrol('style','edit','units','normalized','position',[.16 .775 .15 .04],'String','0');
    
    %K component
    gui.kTextbox = uicontrol('style','text','units','normalized','position',[.01 .5 .2 .2],'String','k vector component: f(x,y,z) = ','horizontalalignment','left');
    gui.kEditBox = uicontrol('style','edit','units','normalized','position',[.16 .675 .15 .04],'String','0');
    
    %plot uicontrol button
    gui.plotButtom = uicontrol('style','pushbutton','units','normalized','position',[.01 .4 .3 .2],'String','Plot','callback',{@plot,x,y,z});
    %yes the plot button is obnoxiously large it works though.
    
    %zoom in/out scrollbar
    gui.sliderText = uicontrol('style','text','units','normalized','position',[.01 .15 .1 .1],'String','Zoom');
    gui.slider = uicontrol('style','slider','units','normalized','position',[.1 .2 .15 .07],'value',1,'min',1,'max',100,'sliderstep',[1/5 1/5],'callback',{@resize});

    %Clear Plot
    gui.clearButton = uicontrol('style','pushbutton','units','normalized','position',[.01 .3 .1 .05],'String','Clear','callback',{@clear,x,y,z});
    
end

function [] = plot(~,~,x,y,z)
    global gui;
    %first callback function to plot the entered values  
    hold on;
    %lot of voodoo getting u v and w to dimensonally align with x y z as an
    %nxnxn double, selecting out undefined functions and replacing them
    %with 0
    
    %if the user inputs capital x,y,z
    iUpper = regexp(gui.iEditBox.String, '[A-Z]');
    gui.iEditBox.String(iUpper) = lower(gui.iEditBox.String(iUpper));
    
    jUpper = regexp(gui.jEditBox.String, '[A-Z]');
    gui.jEditBox.String(jUpper) = lower(gui.jEditBox.String(jUpper));
    
    kUpper = regexp(gui.kEditBox.String, '[A-Z]');
    gui.kEditBox.String(kUpper) = lower(gui.kEditBox.String(kUpper));
    
    %string to symbolic eqpression 1x1
    u = str2sym(gui.iEditBox.String);
    v = str2sym(gui.jEditBox.String);
    w = str2sym(gui.kEditBox.String);
    
    
   
    %for if the user deletes the starting 0s in the edit box, turns them into 0s
    if isempty(u)
        u = 0;
    end
    
    if isempty(v)
        v = 0;
    end
    
    if isempty(w)
        w = 0;
    end
    
    %symbolic expression to something? it had a red squiggly and this works
    u = subs(u);
    v = subs(v);
    w = subs(w);          
    
    %makes it work bc it has to change from sym to double and idk another
    %way
    u = u + x.*0 + y.*0 + z.*0;
    v = v + x.*0 + y.*0 + z.*0;
    w = w + x.*0 + y.*0 + z.*0;
    
    %allows for square root functions and other things with imaginary parts
    %by setting imaginary things to 0. also fixes log functions
    u(~(u == real(u))) = 0;
    v(~(v == real(v))) = 0;
    w(~(w == real(w))) = 0;
    
    %turns it into 6x6x6 double because it matches meshgrid now
    u = double(u);
    v = double(v);  
    w = double(w);
    
    %updates the vector components of the vector field
    gui.q3.UData = u;
    gui.q3.VData = v;
    gui.q3.WData = w;

end


function [] = resize(~,~)
    global gui;
    %function to resize the graph dimensions, xlim, ylim, zlim
    zoom out; %resets the zoom
    
    %adjusts the zoom factor from 1-100 to 1-5;
    zoomFactor = gui.slider.Value;
    zoomFactor = zoomFactor/20 + .95;
    
    %zooms in up to 5x
    zoom(gui.fig,zoomFactor);
end

function [] = clear(~,~,x,y,z)
    global gui;
    
    %repeat code from earlier to get a parallel structure to meshgrid,
    %might be inefficient but it gets u v and w to be 11x11x11 array of 0s
    u = 0 + x.*0 + y.*0 + z.*0;
    v = 0 + x.*0 + y.*0 + z.*0;
    w = 0 + x.*0 + y.*0 + z.*0;
    
    %another repeat to set the vector field data;
    gui.q3.UData = u;
    gui.q3.VData = v;
    gui.q3.WData = w;
   
    %could have also just set gui.q3.Visibile = 0 and had plot set it to 1;
end