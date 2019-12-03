function varargout = proj2(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj2_OpeningFcn, ...
                   'gui_OutputFcn',  @proj2_OutputFcn, ...
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

function proj2_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);





function varargout = proj2_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
img0=rgb2gray(img);
axes(handles.axes1);
imshow(img0);
assignin('base','img',img);



function pushbutton2_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
axes(handles.axes2);

img=rgb2gray(img);
[row,column]=size(img);
img0=im2double(img);

%延拓图像
filter_size=3;
pad_img2=zeros(row+filter_size-1,column+filter_size-1);
pad_img2(((filter_size-1)/2+1):(row+(filter_size-1)/2),((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0;
for i=1:(filter_size-1)/2
    pad_img2(i,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(1,:);
    pad_img2(row+i-1,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(row,:);
    pad_img2(((filter_size-1)/2+1):(row+(filter_size-1)/2),i)=img0(:,1);
    pad_img2(((filter_size-1)/2+1):(row+(filter_size-1)/2),column+i-1)=img0(:,column);    
end
pad_img2(1:(filter_size-1)/2,1:(filter_size-1)/2)=img0(1,1);
pad_img2(1:(filter_size-1)/2,column+(filter_size-1)/2+1:column+filter_size-1)=img0(1,column);
pad_img2(row+(filter_size-1)/2+1:row+filter_size-1,1:(filter_size-1)/2)=img0(row,1);
pad_img2(row+(filter_size-1)/2+1:row+filter_size-1,column+(filter_size-1)/2+1:column+filter_size-1)=img0(row,column);

w1=[-1 0;0 1];
w2=[0 -1;1 0];
robert1=zeros(row,column);
robert2=zeros(row,column);
for i=1:row
    for j=1:column
        temp1=w1.*pad_img2(i:i+1,j:j+1);
        temp2=w2.*pad_img2(i:i+1,j:j+1);
        robert1(i,j)=abs(sum(sum(temp1)));
        robert2(i,j)=abs(sum(sum(temp2)));
    end
end
img1=robert1+robert2;
imshow(img1);
assignin('base','img',img);




function pushbutton3_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
axes(handles.axes3);

img=rgb2gray(img);
[row,column]=size(img);
img0=im2double(img);

%延拓图像
filter_size=3;
pad_img2=zeros(row+filter_size-1,column+filter_size-1);
pad_img2(((filter_size-1)/2+1):(row+(filter_size-1)/2),((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0;
for i=1:(filter_size-1)/2
    pad_img2(i,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(1,:);
    pad_img2(row+i-1,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(row,:);
    pad_img2(((filter_size-1)/2+1):(row+(filter_size-1)/2),i)=img0(:,1);
    pad_img2(((filter_size-1)/2+1):(row+(filter_size-1)/2),column+i-1)=img0(:,column);    
end
pad_img2(1:(filter_size-1)/2,1:(filter_size-1)/2)=img0(1,1);
pad_img2(1:(filter_size-1)/2,column+(filter_size-1)/2+1:column+filter_size-1)=img0(1,column);
pad_img2(row+(filter_size-1)/2+1:row+filter_size-1,1:(filter_size-1)/2)=img0(row,1);
pad_img2(row+(filter_size-1)/2+1:row+filter_size-1,column+(filter_size-1)/2+1:column+filter_size-1)=img0(row,column);

w3=[-1 -1 -1;0 0 0;1 1 1];
w4=[-1 0 1;-1 0 1;-1 0 1];
prewitt1=zeros(row,column);
prewitt2=zeros(row,column);
for i=1:row
    for j=1:column
        temp1=w3.*pad_img2(i:i+2,j:j+2);
        temp2=w4.*pad_img2(i:i+2,j:j+2);
        prewitt1(i,j)=abs(sum(sum(temp1)));
        prewitt2(i,j)=abs(sum(sum(temp2)));
    end
end
img2=prewitt1+prewitt2;
imshow(img2);
assignin('base','img',img);




function pushbutton4_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
axes(handles.axes4);

img=rgb2gray(img);
[row,column]=size(img);
img0=im2double(img);

%延拓图像
filter_size=3;
pad_img1=zeros(row+filter_size-1,column+filter_size-1);
pad_img1(((filter_size-1)/2+1):(row+(filter_size-1)/2),((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0;
for i=1:(filter_size-1)/2
    pad_img1(i,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(1,:);
    pad_img1(row+i-1,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(row,:);
    pad_img1(((filter_size-1)/2+1):(row+(filter_size-1)/2),i)=img0(:,1);
    pad_img1(((filter_size-1)/2+1):(row+(filter_size-1)/2),column+i-1)=img0(:,column);    
end
pad_img1(1:(filter_size-1)/2,1:(filter_size-1)/2)=img0(1,1);
pad_img1(1:(filter_size-1)/2,column+(filter_size-1)/2+1:column+filter_size-1)=img0(1,column);
pad_img1(row+(filter_size-1)/2+1:row+filter_size-1,1:(filter_size-1)/2)=img0(row,1);
pad_img1(row+(filter_size-1)/2+1:row+filter_size-1,column+(filter_size-1)/2+1:column+filter_size-1)=img0(row,column);

w5=[-1 -2 -1;0 0 0;1 2 1];
w6=[-1 0 1;-2 0 2;-1 0 1];
sobel1=zeros(row,column);
sobel2=zeros(row,column);
for i=1:row
    for j=1:column
        temp1=w5.*pad_img1(i:i+2,j:j+2);
        temp2=w6.*pad_img1(i:i+2,j:j+2);
        sobel1(i,j)=abs(sum(sum(temp1)));
        sobel2(i,j)=abs(sum(sum(temp2)));
    end
end
img3=sobel1+sobel2;
imshow(img3);
assignin('base','img',img);


function pushbutton5_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
axes(handles.axes5);
img=rgb2gray(img);
sigma=10;
img4 = fspecial('gaussian',[3 3],sigma);   %高斯滤波
blur=imfilter(img,img4,'replicate');        %对任意类型数组或多维图像进行滤波 
imshow(blur);
assignin('base','img',img);
%还未解决的问题：输入sigma值，如何使用全局变量实现在不同函数之间的变量传递


function pushbutton6_Callback(hObject, eventdata, handles)
axis on;
img=imread('original.JPG');
axes(handles.axes6);

img=rgb2gray(img);
[row,column]=size(img);
img0=im2double(img);

%延拓图像
filter_size=3;
pad_img1=zeros(row+filter_size-1,column+filter_size-1);
pad_img1(((filter_size-1)/2+1):(row+(filter_size-1)/2),((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0;
for i=1:(filter_size-1)/2
    pad_img1(i,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(1,:);
    pad_img1(row+i-1,((filter_size-1)/2+1):(column+(filter_size-1)/2))=img0(row,:);
    pad_img1(((filter_size-1)/2+1):(row+(filter_size-1)/2),i)=img0(:,1);
    pad_img1(((filter_size-1)/2+1):(row+(filter_size-1)/2),column+i-1)=img0(:,column);    
end
pad_img1(1:(filter_size-1)/2,1:(filter_size-1)/2)=img0(1,1);
pad_img1(1:(filter_size-1)/2,column+(filter_size-1)/2+1:column+filter_size-1)=img0(1,column);
pad_img1(row+(filter_size-1)/2+1:row+filter_size-1,1:(filter_size-1)/2)=img0(row,1);
pad_img1(row+(filter_size-1)/2+1:row+filter_size-1,column+(filter_size-1)/2+1:column+filter_size-1)=img0(row,column);

w1=ones(filter_size,filter_size);
img5=zeros(row,column);
for i=1:row
    for j=1:column
        temp=w1.*pad_img1(i:i+filter_size-1,j:j+filter_size-1);
        img5(i,j)=median((temp(:)));
    end
end
img5=im2uint8(img5);
imshow(img5);
assignin('base','img',img);

%输入任意卷积核还未解决，仍然是变量引用的问题
