function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
clear img1;
clear img2;
i1 = 0;
i2 = 0;
handles.Feat_Err = [ 0.006 0.8 0.04 6 [[0.0750 0.0750] [0.0750 0.0750]] 0.0065 ];
handles.output = hObject;
guidata(hObject, handles);


function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function pushbutton2_Callback(hObject, eventdata, handles)
[a b] = uigetfile('*.*','All Files');
img1=imread([b a]);
handles.img1 = img1;
guidata(hObject, handles);
imshow(img1,'Parent',handles.axes3);


function pushbutton3_Callback(hObject, eventdata, handles)
[a b] = uigetfile('*.*','All Files');
img2=imread([b a]);
handles.img2 = img2;
guidata(hObject, handles);
imshow(img2,'Parent',handles.axes4);


function uipanel1_CreateFcn(hObject, eventdata, handles)


function pushbutton4_Callback(hObject, eventdata, handles)
isfield(handles, 'img1')

if isfield(handles, 'img1') && isfield(handles, 'img2')
    [Feat1,imgp1] = featureExtraction(handles.img1);
    imshow(imgp1,'Parent',handles.axes5);
    [Feat2,imgp2] = featureExtraction(handles.img2);
    imshow(imgp2,'Parent',handles.axes6);
    Feat_Err = handles.Feat_Err
    Feat1
    Feat2
    flag = 1;
    for i=1:6
        if abs(Feat2(i)-Feat1(i)) > Feat_Err(i)
            flag = 0;
            break;
        end
    end
    
    if flag
        set(handles.text8,'string','Valid');
    else
        set(handles.text8,'string','Invalid');
    end
    
else
    errordlg('Please Select both the images');
    set(handles.text8,'string','Not Processed');
end


