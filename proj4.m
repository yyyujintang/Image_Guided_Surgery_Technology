function varargout = proj4(varargin)
% PROJ4 MATLAB code for proj4.fig
%      PROJ4, by itself, creates a new PROJ4 or raises the existing
%      singleton*.
%
%      H = PROJ4 returns the handle to a new PROJ4 or the handle to
%      the existing singleton*.
%
%      PROJ4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJ4.M with the given input arguments.
%
%      PROJ4('Property','Value',...) creates a new PROJ4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proj4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proj4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proj4

% Last Modified by GUIDE v2.5 22-Nov-2019 15:49:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj4_OpeningFcn, ...
                   'gui_OutputFcn',  @proj4_OutputFcn, ...
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


% --- Executes just before proj4 is made visible.
function proj4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proj4 (see VARARGIN)

% Choose default command line output for proj4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proj4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proj4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
axis on;
img=imread('5.jpg');
img0=rgb2gray(img);
img0=imbinarize(img0);
axes(handles.axes1);
imshow(img0);
assignin('base','img',img);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
axis on;
img=imread('3.jpg');
img=rgb2gray(img);
img=imbinarize(img);
axes(handles.axes2);

[m ,n]=size(img);
m=double(m);
n=double(n);
Min=double(min(img(:)));    %不断腐蚀的结果是像素全为最小值
%Max=double(max(img(:)));    %不断膨胀的结果是像素全为最大值
w = strel('square',3);
imgn=zeros(m,n);
while sum(img(:))~=m*n*Min  %不断腐蚀再腐蚀图像不会有变化为止
    for i=1:m
        for j=1:n
            if img(i,j)~=Min
                imgn(i,j)=imgn(i,j)+1;      %记录这个点腐蚀多少次才到最小值
            end
        end
    end
    img=imerode(img,w);     %不断腐蚀        
end
imshow(mat2gray(imgn));
assignin('base','img',imgn);


function pushbutton3_Callback(hObject, eventdata, handles)
axis on;
img=imread('5.jpg');
img=rgb2gray(img);
img=imbinarize(img);
axes(handles.axes3);
[row,column]=size(img);
B=[0 1 0;1 1 1; 0 1 0];
n=size(B,1);
n_l=floor(n/2);
%对边界图进行扩充，目的是为了处理边界点,这里采用边界镜像扩展
img_pad=padarray(img,[n_l,n_l],'symmetric');
BW2=bwmorph(img_pad,'skel',Inf);
imshow(BW2);
assignin('base','img',BW2);

function pushbutton4_Callback(hObject, eventdata, handles)
axis on;
img=imread('5.jpg');
BW=rgb2gray(img);
BW=imbinarize(BW);
axes(handles.axes4);

skel = bwmorph(BW,'skel',Inf);
DD = double(bwdist(~BW));
D = zeros(size(DD));
D(skel) = DD(skel);

%# zero-centered unit circle
t = linspace(0,2*pi,50);
ct = cos(t);
st = sin(t);

%# InverseDistanceTransform[] : union of all disks centered around each
%# pixel of the distance transform, taking pixel values as radius
[r c] = size(D);
BW2 = false(r,c);
for j=1:c
    for i=1:r
        if D(i,j)==0, continue; end
        mask = poly2mask(D(i,j).*st + j, D(i,j).*ct + i, r, c);
        BW2(mask) = true;
    end
end
imshow(BW2);
assignin('base','img',BW2);
