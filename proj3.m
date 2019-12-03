function varargout = proj3(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj3_OpeningFcn, ...
                   'gui_OutputFcn',  @proj3_OutputFcn, ...
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


% --- Executes just before proj3 is made visible.
function proj3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proj3 (see VARARGIN)

% Choose default command line output for proj3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proj3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proj3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
axis on;
img=imread('3.jpg');
img0=rgb2gray(img);
img0=imbinarize(img0);
axes(handles.axes1);
imshow(img0);
assignin('base','img',img);
function pushbutton3_Callback(hObject, eventdata, handles)
axis on;
img=imread('3.jpg');
axes(handles.axes2);
img=rgb2gray(img);
img=imbinarize(img);
[row,column]=size(img);
img0=im2double(img);

B=[0 1 0;1 1 1; 0 1 0];
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


function pushbutton4_Callback(hObject, eventdata, handles)
axis on;
img=imread('3.jpg');
axes(handles.axes3);
img=rgb2gray(img);
img=imbinarize(img);
[row,column]=size(img);
img0=im2double(img);

B=[0 1 0;1 1 1; 0 1 0];
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

function pushbutton5_Callback(hObject, eventdata, handles)
axis on;
img=imread('3.jpg');
axes(handles.axes4);
img=rgb2gray(img);
img0=imbinarize(img);
img0=im2double(img);
img0=imbinarize(img0);
se=strel('square',3);
img1=imopen(img0,se);
imshow(img1);



function pushbutton6_Callback(hObject, eventdata, handles)
axis on;
img=imread('3.jpg');
axes(handles.axes5);
img=rgb2gray(img);
img0=imbinarize(img);
img0=im2double(img);
se=strel('square',3);
img1=imclose(img0,se);
imshow(img1);
