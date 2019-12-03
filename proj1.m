function varargout = proj1(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj1_OpeningFcn, ...
                   'gui_OutputFcn',  @proj1_OutputFcn, ...
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




function proj1_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);





function varargout = proj1_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function pushbutton1_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
axes(handles.axes2);
imshow(img);
assignin('base','img',img);


function pushbutton2_Callback(hObject, eventdata, handles)
axis on;  
img=imread('original.JPG');
axes(handles.axes5);
imhist(img);
assignin('base','img',img);



function pushbutton3_Callback(hObject, eventdata, handles)
axis on;  
img=imread('original.JPG');
axes(handles.axes8);
level=graythresh(img);     %确定灰度阈值
BW=im2bw(img,level);
imshow(BW);
assignin('base','img',img);



function pushbutton4_Callback(hObject, eventdata, handles)

axis on;  
img=imread('original.JPG');
axes(handles.axes9);
% 将RGB图像转换为灰度图像
img= rgb2gray(img);
vHist=imhist(img);
[m,n]=size(img);
p=vHist(find(vHist>0))/(m*n);%求每一不为零的灰度值的概率
Pt=cumsum(p);%计算出选择不同t值时，A区域的概率
Ht=-cumsum(p.*log(p));%计算出选择不同t值时，A区域的熵
HL=-sum(p.*log(p));%计算出全图的熵
Yt=log(Pt.*(1-Pt)+eps)+Ht./(Pt+eps)+(HL-Ht)./(1-Pt+eps);%计算出选择不同t值时，判别函数的值
[a,th]=max(Yt);%th即为最佳阈值
segimg=(img>th);
imshow(segimg);
assignin('base','img',img);



function slider1_Callback(hObject, eventdata, handles)

axis on;  
img=imread('original.JPG');
axes(handles.axes10);
% 将RGB图像转换为灰度图像

level=get(hObject,'value');
BW=im2bw(img,level);
imshow(BW);
assignin('base','img',img);


function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
