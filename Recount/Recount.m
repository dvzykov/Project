function varargout = Recount(varargin)
% RECOUNT MATLAB code for Recount.fig
%      RECOUNT, by itself, creates a new RECOUNT or raises the existing
%      singleton*.
%
%      H = RECOUNT returns the handle to a new RECOUNT or the handle to
%      the existing singleton*.
%
%      RECOUNT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOUNT.M with the given input arguments.
%
%      RECOUNT('Property','Value',...) creates a new RECOUNT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Recount_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Recount_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Recount

% Last Modified by GUIDE v2.5 05-Mar-2020 18:32:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Recount_OpeningFcn, ...
                   'gui_OutputFcn',  @Recount_OutputFcn, ...
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

% --- Executes just before Recount is made visible.
function Recount_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Recount (see VARARGIN)

% Choose default command line output for Recount
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Recount.
if strcmp(get(hObject,'Visible'),'off')
    plot(0);
end

% UIWAIT makes Recount wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Recount_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear global;
cla;
 
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
global S1 ONameS1 DirecS1;
[NameS1,DirecS1]=uigetfile('*.txt');% загрузка файла
ONameS1=cellstr(NameS1);
NameS1=[DirecS1 NameS1];
fileID = fopen(NameS1);
formatSpec = '%f';
sizeA = [2 Inf];
S1 = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
S1=S1';
plots



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S2 ONameS2;
[NameS2,DirecS2]=uigetfile('*.txt');% загрузка файла
ONameS2=cellstr(NameS2);
NameS2=[DirecS2 NameS2];
fileID = fopen(NameS2);
formatSpec = '%f';
sizeA = [2 Inf];
S2 = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
S2=S2';
plots




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global R2; 
[NameR2,DirecR2]=uigetfile('*.txt');% загрузка файла
%ONameS1=cellstr(NameS1);
NameR2=[DirecR2 NameR2];
fileID = fopen(NameR2);
formatSpec = '%f';
sizeA = [2 Inf];
R2 = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
R2=R2';
plots

 


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global R1; 
[NameR1,DirecR1]=uigetfile('*.txt');% загрузка файла
%ONameS1=cellstr(NameS1);
NameR1=[DirecR1 NameR1];
fileID = fopen(NameR1);
formatSpec = '%f';
sizeA = [2 Inf];
R1 = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
R1=R1';
plots


function plots
global S1  S2  R1  R2 NS1;
cla
hold on
if S1
    plot (S1(:,1),S1(:,2),'r--','DisplayName','Cигнал 1');
end
if S2
    plot (S2(:,1),S2(:,2),'g--','DisplayName','Cигнал 2');
end
if R1
    plot (R1(:,1),R1(:,2),'r','DisplayName','Опорный сигнал 1');
end
if R2
    plot (R2(:,1),R2(:,2),'g','DisplayName','Опорный сигнал 2');
end
if NS1
    plot(NS1(:,1),NS1(:,2),'b','DisplayName','Пересчитайный сигнал')
end
hold off


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S1 R1 R2 NS1 OName ONameS1;

[MR1,TR1]=max((R1(:,2)));
[MR2,TR2]=max((R2(:,2)));
[MR3,TR3]=min((R1(:,2)));
[MR4,TR4]=min((R2(:,2)));
TR1=R1(TR1,1);
TR2=R2(TR2,1);
ShiftS=TR2-TR1;
NS1=S1;
NS1(:,1)=NS1(:,1)+ShiftS;
L=length(S1);
x=1;
while x<L
    if S1(x,2)<0
        KAm=MR4/MR3;
        NS1(x,2)=NS1(x,2).*KAm;
        x=x+1;
    else
        
        KAm=MR2/MR1;
        NS1(x,2)=NS1(x,2).*KAm;
        x=x+1;
    end
end
OName=ONameS1;
plots


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S2 R1 R2 NS1 OName ONameS2;
[MR1,TR1]=max((R1(:,2)));
[MR2,TR2]=max((R2(:,2)));
[MR3,TR3]=min((R1(:,2)));
[MR4,TR4]=min((R2(:,2)));
TR1=R1(TR1,1);
TR2=R2(TR2,1);
ShiftS=TR1-TR2;
NS1=S2;
NS1(:,1)=NS1(:,1)+ShiftS;
L=length(S2);
x=1;
while x<L
    if S2(x,2)<0
        KAm=MR3/MR4;
        NS1(x,2)=NS1(x,2).*KAm;
        x=x+1;
    else
        
        KAm=MR1/MR2;
        NS1(x,2)=NS1(x,2).*KAm;
        x=x+1;
    end
end
OName=ONameS2;
plots


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global NS1 OName ;
Direc=uigetdir;
NName=['new' OName];
NName=cell2mat(NName);
NName=cellstr(NName);
NameF=inputdlg('Название','Сохранение',1,NName); % имя сохранения
SF=[Direc '\' NName '.txt'];
SF=cell2mat(SF);
save(SF,'NS1','-ascii');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global
cla;