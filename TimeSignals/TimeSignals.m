function varargout = TimeSignals(varargin)
% TIMESIGNALS MATLAB code for TimeSignals.fig
%      TIMESIGNALS, by itself, creates a new TIMESIGNALS or raises the existing
%      singleton*.
%
%      H = TIMESIGNALS returns the handle to a new TIMESIGNALS or the handle to
%      the existing singleton*.
%
%      TIMESIGNALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIMESIGNALS.M with the given input arguments.
%
%      TIMESIGNALS('Property','Value',...) creates a new TIMESIGNALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TimeSignals_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TimeSignals_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TimeSignals

% Last Modified by GUIDE v2.5 14-Jan-2020 13:12:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TimeSignals_OpeningFcn, ...
    'gui_OutputFcn',  @TimeSignals_OutputFcn, ...
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

% --- Executes just before TimeSignals is made visible.
function TimeSignals_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TimeSignals (see VARARGIN)

% Choose default command line output for TimeSignals
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using TimeSignals.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes TimeSignals wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TimeSignals_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear all;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DirectS 
DirectS=uigetdir; % Путь
TimeSign(hObject, eventdata, handles)

function TimeSign(hObject, eventdata, handles)
global DirectS
axes(handles.axes1);
cla;
FileTXT=fullfile(DirectS,'*.txt'); % Фильтр по типу
BDDir=dir(FileTXT); % БД
SizF=size(BDDir);
BDDir2=struct2cell(BDDir);
s=1;
f1=handles.edit1.String;
f2=handles.edit2.String;
t1='[_]err[_]';
t2='[_]Photo_diode[_]*';
t3='[_]steps[_]';
t4='[_]temp[._]';
t5='[_]Corrected';
t6=char(f1);
t7=char(f2);
S=1;
while s<=SizF(1,1)
    NameF=char(BDDir2(1,s));
    x=0;
    if regexpi(NameF,t2)
        x=1;
    end
    if regexpi(NameF,t1)
        x=1;
    end
    if regexpi(NameF,t3)
        x=1;
    end
    if regexpi(NameF,t4)
        x=1;
    end
    if regexpi(NameF,t5)
        x=1;
    end
    if regexpi(NameF,t6)
        x=1;
    end
    if regexpi(NameF,t7)
        x=1;
    end
    if x~=1;
        NBDDir(1,S)=BDDir2(1,s);
        x=0;
        S=S+1;
    end
    s=s+1;
end

B=size(NBDDir);
b=1;
SS=zeros(0);
hold on
while b<=B(1,2)
    FileN=char(NBDDir(1,b));
    FileN=[DirectS '\' FileN];
    fileID=fopen(FileN);
    formatSpec = '%f';
    sizeA = [2 Inf];
    %SS = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
    SS=load(FileN);
    eval(['SS',num2str(b), ' = SS;']);
    fclose(fileID);
    b=b+1;
    plot(SS(:,1),SS(:,2))
    legend(NBDDir)
end
hold off




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

TimeSign(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

 TimeSign(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
