function varargout = proj5(varargin)
% PROJ5 MATLAB code for proj5.fig
%      PROJ5, by itself, creates a new PROJ5 or raises the existing
%      singleton*.
%
%      H = PROJ5 returns the handle to a new PROJ5 or the handle to
%      the existing singleton*.
%
%      PROJ5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJ5.M with the given input arguments.
%
%      PROJ5('Property','Value',...) creates a new PROJ5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proj5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proj5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proj5

% Last Modified by GUIDE v2.5 22-Nov-2019 16:55:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj5_OpeningFcn, ...
                   'gui_OutputFcn',  @proj5_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before proj5 is made visible.
function proj5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proj5 (see VARARGIN)

% Choose default command line output for proj5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proj5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proj5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
axis on;
img=imread('7.jpg');
img0=rgb2gray(img);
axes(handles.axes1);
imshow(img0);
assignin('base','img',img);

function pushbutton2_Callback(hObject, eventdata, handles)
axis on;
img=imread('7.jpg');
axes(handles.axes2);
img=rgb2gray(img);
[row,column]=size(img);
img0=im2double(img);

B=[1 1 1 ;1 1 1;1 1 1];
n=size(B,1);
ind=find(B==0);
n_l=floor(n/2);
%对边界图进行扩充，目的是为了处理边界点,这里采用边界镜像扩展
img_pad=padarray(img0,[n_l,n_l],'symmetric');
[M,N]=size(img0);
J_Erosion=zeros(M,N);
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=img_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        %腐蚀操作
        J_Erosion(i,j)=min(C);
    end
end
imshow(J_Erosion);
assignin('base','J_Erosion',J_Erosion);

function pushbutton3_Callback(hObject, eventdata, handles)
axis on;
img=imread('7.jpg');
axes(handles.axes3);
img=rgb2gray(img);
[row,column]=size(img);
img0=im2double(img);

B=[1 1 1 ;1 1 1;1 1 1];
n=size(B,1);
ind=find(B==0);
n_l=floor(n/2);
%对边界图进行扩充，目的是为了处理边界点,这里采用边界镜像扩展
img_pad=padarray(img0,[n_l,n_l],'symmetric');
[M,N]=size(img0);
J_Dilation=zeros(M,N);
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=img_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        %膨胀操作
        J_Dilation(i,j)=max(C);
    end
end
imshow(J_Dilation);
assignin('base','img',J_Dilation);

function pushbutton4_Callback(hObject, eventdata, handles)
axis on;
img=imread('7.jpg');
axes(handles.axes4);
I=rgb2gray(img);
I=im2double(I);
r=3;
B=ones(2*r-1,2*r-1);
%将距离大于40的点置零
for i=1:2*r-1
    for j=1:2*r-1
        d=sqrt((i-r)^2+(j-r)^2);
        if d>r
            B(i,j)=0;
        end
    end
end
n=2*r-1;
ind=find(B==0);
n_l=floor(n/2);
I_pad=padarray(I,[n_l,n_l],'symmetric');
[M,N]=size(I);
 
%-------------------------------灰度开操作---------------------------------
J_Opening=zeros(M,N);
%腐蚀操作
J_Erosion=zeros(M,N);
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=I_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        J_Erosion(i,j)=min(C);
    end
end
%对腐蚀图像进行扩展
J_Erosion_pad=padarray(J_Erosion,[n_l,n_l],'symmetric');
%膨胀图像
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=J_Erosion_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        J_Opening(i,j)=max(C);
    end
end
imshow(J_Opening);
assignin('base','img',J_Opening);


function pushbutton5_Callback(hObject, eventdata, handles)
axis on;
img=imread('7.jpg');
axes(handles.axes5);
I=rgb2gray(img);
I=im2double(I);
r=3;
B=ones(2*r-1,2*r-1);
%将距离大于40的点置零
for i=1:2*r-1
    for j=1:2*r-1
        d=sqrt((i-r)^2+(j-r)^2);
        if d>r
            B(i,j)=0;
        end
    end
end
n=2*r-1;
ind=find(B==0);
n_l=floor(n/2);
I_pad=padarray(I,[n_l,n_l],'symmetric');
[M,N]=size(I);
%-------------------------------灰度闭操作---------------------------------
J_Closing=zeros(M,N);  
%膨胀图像
J_Dilation=zeros(M,N);
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=I_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        J_Dilation(i,j)=max(C);
    end
end
%对膨胀图像进行扩展
J_Dilation_pad=padarray(J_Dilation,[n_l,n_l],'symmetric');
%腐蚀操作
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=J_Dilation_pad(i:i+2*n_l,j:j+2*n_l);
        C=Block.*B;
        %删除0值，保留4连通数值
        C=C(:);
        C(ind)=[];
        J_Closing(i,j)=min(C);
    end
end
imshow(J_Closing);
assignin('base','img',J_Closing);
