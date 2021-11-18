function varargout = FT2(varargin)
% FT2 MATLAB code for FT2.fig
%      FT2, by itself, creates a new FT2 or raises the existing
%      singleton*.
%
%      H = FT2 returns the handle to a new FT2 or the handle to
%      the existing singleton*.
%
%      FT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FT2.M with the given input arguments.
%
%      FT2('Property','Value',...) creates a new FT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FT2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FT2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FT2

% Last Modified by GUIDE v2.5 13-Jul-2020 16:52:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FT2_OpeningFcn, ...
    'gui_OutputFcn',  @FT2_OutputFcn, ...
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

% --- Executes just before FT2 is made visible.
function FT2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FT2 (see VARARGIN)

% Choose default command line output for FT2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
initialize_gui(hObject, handles, false) %defaunt perametr
% UIWAIT makes FT2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = FT2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear global %Очистить после закрытия

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) %button Sample
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S ; %сигналы
global FftLS; % кол-во отсчетов 2^n
global ONameF; %Имя файла
global DirecF; %Путь файла
global DirecN;

[NameF,DirecF]=uigetfile('*.txt');% загрузка файла
ONameF=cellstr(NameF);
NameF=[DirecF NameF];
fileID = fopen(NameF);
formatSpec = '%f';
sizeA = [2 Inf];
S=load(NameF);
%S = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
%S=S';
dS=sum(S(1:10,2))/10;
S=S-dS;
t=length(S);
FftLS=2.^nextpow2(t); % кол-во отсчетов 2^n
set(handles.text4, 'String', t); % Выписать колво точек для сигнала
if DirecN
    set(handles.text19,'String', DirecN);
else
    set(handles.text19,'String', DirecF);
end
set(handles.uibuttongroup2,'Visible', 'on')
set(handles.uibuttongroup5,'Visible', 'on')
set(handles.slider3,'Max',t)
set(handles.slider4,'Max',t)
set(handles.slider3,'SliderStep', [1/t,1/t])
set(handles.slider4,'SliderStep', [1/t,1/t])
popupmenu3_Callback(hObject, eventdata, handles);

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)% Выбор графика
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S R SS ; %Сигнал
global FftLS FftLR FftLSS; % кол-во отсчетов 2^n
global F1 F2 F3; %Фильтр
global MAXAS MAXAR MAXASS;
global S1 S2; % Сигнал на сохранение (sample)
global R1 R2; % сигнал reference
g1=handles.radiobutton6.Value;
if g1
    axes(handles.axes1);
else
    axes(handles.axes2);
end
cla
Size=[FftLS FftLR FftLSS];
MaxSize=2^16; % 2^16 max(Size)
FftLS=MaxSize;
FftLR=MaxSize;
FftLSS=MaxSize;
if isempty(F1) == 0
    SF=S;
    SF(:,2)=S(:,2).*F1(:,2);
else
    SF=S;
end
if isempty(F2) == 0
    RF=R;
    RF(:,2)=R(:,2).*F2(:,2);
else
    RF=R;
end
if isempty(F3) == 0
    SSF=SS;
    SSF(:,2)=SS(:,2).*F3(:,2);
else
    SSF=SS;
end
popup_sel_index = get(handles.popupmenu3, 'Value');
switch popup_sel_index
    case 1 % Cигнал по времени
        if isempty(SS)==0
            if R
                if S
                    V=7;% SS, S, R
                else
                    V=6;% SS,R
                end
            else
                if S
                    V=5;%SS,S
                else
                    V=4;%SS
                end
            end
        else
            if R
                if S
                    V=3; %R,S
                else
                    V=2; %R
                end
            else
                V=1; %S
            end
        end
        switch V
            case 1 %S
                S1=S(:,1);
                S2=S(:,2);
                if isempty(F1)==0
                    plot(S1,S2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--');% Построение сигнала
                    legend('Sample','Filt for sample');
                else
                    plot(S1,S2);% Построение сигнала
                    legend('Sample');
                end
            case 2 % R
                R1=R(:,1);
                R2=R(:,2);
                if isempty(F2)==0
                    plot(R1,R2,F2(:,1),F2(:,2)*MAXAR(:,2),'r--');% Построение сигнала
                    legend('Reference','Filt for reference');
                else
                    plot(R1,R2,'Color',[0.8500 0.3250 0.0980]);% Построение сигнала
                    legend('Reference');
                end
            case 3 % R S
                S1=S(:,1);
                S2=S(:,2);
                R1=R(:,1);
                R2=R(:,2);
                if isempty(F1)==0 && isempty(F2)==0
                    plot(S1,S2,R1,R2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--',F2(:,1),F2(:,2)*MAXAR(:,2),'r--');% Построение сигнала
                    legend('Sample','Reference','filt for sample','filt for reference');
                else
                    if isempty(F1)==0
                        plot(S1,S2,R1,R2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--');% Построение сигнала
                        legend('Sample','Reference','Filt for sample');
                    elseif  isempty(F2)==0
                        plot(S1,S2,R1,R2,F2(:,1),F2(:,2)*MAXAR(:,2),'r--');% Построение сигнала
                        legend('Sample','Reference','Filt for reference');
                    else
                        plot(S1,S2,R1,R2);% Построение сигнала
                        legend('Sample','Reference');
                    end
                end
            case 4 %SS
                SS1=SS(:,1);
                SS2=SS(:,2);
                if isempty(F3)==0
                    plot(SS1,SS2,F3(:,1),F3(:,2)*MAXASS(:,2),'b--');% Построение сигнала
                    legend(' Substrate','Filt for substrate');
                else
                    plot(SS1,SS2);% Построение сигнала
                    legend('substrate');
                end
            case 5 %SS S
                S1=S(:,1);
                S2=S(:,2);
                SS1=SS(:,1);
                SS2=SS(:,2);
                if isempty(F1)==0 && isempty(F3)==0
                    plot(S1,S2,SS1,SS2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--',F3(:,1),F3(:,2)*MAXASS(:,2),'b--');% Построение сигнала
                    legend('Sample','substrate','filt for sample','filt for substrate');
                else
                    if isempty(F1)==0
                        plot(S1,S2,SS1,SS2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--');% Построение сигнала
                        legend('Sample','substrate','filt for sample');
                    elseif  isempty(F3)==0
                        plot(S1,S2,SS1,SS2,F3(:,1),F3(:,2)*MAXASS(:,2),'b--');% Построение сигнала
                        legend('Sample','substrate','filt for substrate');
                    else
                        plot(S1,S2,SS1,SS2);% Построение сигнала
                        legend('Sample','substrate');
                    end
                end
            case 6 % SS R
                SS1=SS(:,1);
                SS2=SS(:,2);
                R1=R(:,1);
                R2=R(:,2);
                if isempty(F3)==0 && isempty(F2)==0
                    plot(R1,R2,SS1,SS2,F2(:,1),F2(:,2)*MAXAR(:,2),'r--',F3(:,1),F3(:,2)*MAXASS(:,2),'b--');% Построение сигнала
                    legend('Reference','substrate','filt for Reference','filt for substrate');
                else
                    if isempty(F3)==0
                        plot(R1,R2,SS1,SS2,F3(:,1),F3(:,2)*MAXASS(:,2),'b--');% Построение сигнала
                        legend('Reference','substrate','filt for substrate');
                    elseif  isempty(F2)==0
                        plot(R1,R2,SS1,SS2,F2(:,1),F2(:,2)*MAXAR(:,2),'r--');% Построение сигнала
                        legend('Reference','substrate','filt for Reference');
                    else
                        plot(SS1,SS2,R1,R2);% Построение сигнала
                        legend('substrate','Reference');
                    end
                end
            case 7  %SSS S R
                SS1=SS(:,1);
                SS2=SS(:,2);
                R1=R(:,1);
                R2=R(:,2);
                S1=S(:,1);
                S2=S(:,2);
                if isempty(F1)==0
                    VV1=1;
                else
                    VV1=0;
                end
                if isempty(F2)==0
                    VV2=3;
                else
                    VV2=0;
                end
                if  isempty(F3)==0
                    VV3=5;
                else
                    VV3=0;
                end
                VV=VV1+VV2+VV3;
                switch VV
                    case 0
                        plot(S1,S2,R1,R2,SS1,SS2);% Построение сигнала
                        legend('Sample','Reference','substrate');
                    case 1
                        plot(S1,S2,R1,R2,SS1,SS2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--');
                        legend('Sample','Reference','substrate','filt for sample')
                    case 3
                        plot(S1,S2,R1,R2,SS1,SS2,F2(:,1),F2(:,2)*MAXAR(:,2),'r--');
                        legend('Sample','Reference','substrate','filt for Reference')
                    case 4
                        plot(S1,S2,R1,R2,SS1,SS2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--',F2(:,1),F2(:,2)*MAXAR(:,2),'r--');
                        legend('Sample','Reference','substrate','filt for sample','filt for Reference')
                    case 5
                        plot(S1,S2,R1,R2,SS1,SS2,F3(:,1),F3(:,2)*MAXASS(:,2),'b--');
                        legend('Sample','Reference','substrate','filt for substrate')
                    case 6
                        plot(S1,S2,R1,R2,SS1,SS2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--',F3(:,1),F3(:,2)*MAXASS(:,2),'b--');
                        legend('Sample','Reference','substrate','filt for sample','filt for substrate')
                    case 8
                        plot(S1,S2,R1,R2,SS1,SS2,F2(:,1),F2(:,2)*MAXAR(:,2),'R--',F3(:,1),F3(:,2)*MAXASS(:,2),'b--');
                        legend('Sample','Reference','substrate','filt for sample','filt for substrate')
                    case 9
                        plot(S1,S2,R1,R2,SS1,SS2,F1(:,1),F1(:,2)*MAXAS(:,2),'g--',F2(:,1),F2(:,2)*MAXAR(:,2),'r--',F3(:,1),F3(:,2)*MAXASS(:,2),'b--');
                        legend('Sample','Reference','substrate','filt for sample','filt for Reference','filt for substrate')
                        
                end
                
        end
        
        title('Сигнал');% Подпись графика
        xlabel('Время (пс)');% Подпись оси х графика
        ylabel('Амплитуда');% Подпись оси у графика
        g2=handles.radiobutton7.Value;
        if g2
            axes(handles.axes1);
            title(handles.radiobutton7.String);
        else
            axes(handles.axes2);
            legend('off')
            xlabel('')
            ylabel('')
            title('')
        end
        cla
        hold on
        if SF~=true
            plot(SF(:,1),SF(:,2))
        end
        if RF~=true
            plot(RF(:,1),RF(:,2))
        end
        if SSF~=true
            plot(SSF(:,1),SSF(:,2))
        end
        hold off
    case 2 %частотный спектр
        t=length(SF);
        T=SF(2,1)- SF(1,1);
        Fd=1/(T*10^(-12)); % частота
        B=abs(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(t);
        F=0:Fd/FftLS:Fd/2-Fd/FftLS;
        S1=F;
        S2=FftS(1:length(F));
        if isempty(RF)==0
            tr=length(RF);
            TR=RF(2,1)- RF(1,1);
            Fd=1/(TR*10^(-12)); % частота
            B=abs(fft(RF(:,2),FftLR)); % частотное фурье
            FftSR=B./(tr);
            FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
            R1=FR;
            R2=FftSR(1:length(FR));
        end
        plot(S1./(10^12),S2,R1./(10^12),R2);% Построение спектра Фурье сигнала;
        axis([0 1  0 inf]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
        ylabel('Амплитуда');% Подпись оси у графика
        legend('Sample','Reference');
    case 3 %фазовый спектр сигнала от образца
        S2=unwrap(angle(fft(SF(:,2),FftLS)));% фазовое
        T=SF(2,1)- SF(1,1);
        Fd=1/(T*10^(-12));
        F=0:Fd/FftLS:Fd/2-Fd/FftLS;
        
        
        S2=DLCunwrap(S2);
        S1=F;
        S2=S2(1:length(F));
        
        
        R2=unwrap(angle(fft(RF(:,2),FftLR)));% фазовое
        T=RF(2,1)- RF(1,1);
        Fd=1/(T*10^(-12));
        F=0:Fd/FftLR:Fd/2-Fd/FftLR;
        R2=DLCunwrap(R2);
        R1=F;
        R2=R2(1:length(F));
        plot(S1./(10^12),S2,R1./(10^12),R2);% Построение фаззового
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 4 % коэф. пропусскания/отражения подложки
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        S1=FR;
        S2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        R1=FS;
        R2=FftSS(1:length(FS));
        if length(S1)>length(R1)
            S1=R1;
        end
        S2=abs(R2./S2(1:length(S1)));
        plot(S1./(10^12),S2)
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 5 % Фазовая задержка подложки
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        S1=FR;
        S2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        R1=FS;
        R2=FftSS(1:length(FS));
        if length(S1)>length(R1)
            S1=R1;
        end
        S2=(R2./S2(1:length(S1)));
        S2=unwrap(angle(S2));
        plot(S1./(10^12),S2)
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 6 % ПП подложки
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        S1=FR;
        S2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        R1=FS;
        R2=FftSS(1:length(FS));
        if length(S1)>length(R1)
            S1=R1;
        end
        TF=(R2./S2(1:length(S1)));
        dF=unwrap(angle(TF));
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*S1'*dSample)).*dF);
        NN=4*ReS2./(ReS2+ones(I)).^2;
        ImS2=((3*10^8)./(2*pi*S1'*dSample)).*(log(NN)-log(abs(TF)));
        S2=ReS2+ImS2.*1i;
        plot(S1./(10^12),S2,S1./(10^12),imag(S2),'--');
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 7 % Проводимость
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        t=length(SF);
        T=SF(2,1)- SF(1,1);
        Fd=1/(T*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(t);
        F=0:Fd/FftLS:Fd/2-Fd/FftLS;
        S1=F;
        S2=FftS(1:length(F));
        %   %
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        R1=FR;
        R2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        RS1=FS;
        RS2=FftSS(1:length(FS));
        if length(RS1)>length(R1)
            RS1=R1;
        end
        TF=(RS2./R2(1:length(RS1)));
        dF=unwrap(angle(TF));
        
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*RS1'*dSample)).*dF);
        NN=4*ReS2./(ReS2+ones(I)).^2;
        ImS2=((3*10^8)./(2*pi*RS1'*dSample)).*(log(NN)-log(abs(TF)));
        PP=ReS2+ImS2.*1i;
        S2=((PP+ones(I)).*(RS2./S2-ones(I)))./377;
        plot(S1./(10^12),S2,S1./(10^12),imag(S2),'--');
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 8 %Диэлектрическая тонкой пленки
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        dPlen=handles.metricdata.edit8;
        dPlen=dPlen*10^(-9);
        t=length(SF);
        T=SF(2,1)- SF(1,1);
        Fd=1/(T*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(t);
        F=0:Fd/FftLS:Fd/2-Fd/FftLS;
        S1=F;
        S2=FftS(1:length(F));
        %   %
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        R1=FR;
        R2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        RS1=FS;
        RS2=FftSS(1:length(FS));
        if length(RS1)>length(R1)
            RS1=R1;
        end
        TF=(RS2./R2(1:length(RS1)));
        dF=unwrap(angle(TF));
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*RS1'*dSample)).*dF);
        NN=4*ReS2./(ReS2+ones(I)).^2;
        ImS2=((3*10^8)./(2*pi*RS1'*dSample)).*(log(NN)-log(abs(TF)));
        PP=ReS2+ImS2.*1i;
        Con=((PP+ones(I)).*(RS2./S2-ones(I)))./377;
        S2=ones(I)+(1i*Con./(2*pi*RS1'*dPlen*8.85*10^(-12)));
        plot(S1./(10^12),S2,S1./(10^12),imag(S2),'--');
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 9 %Поглощение тонкой пленки
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        dPlen=handles.metricdata.edit8;
        dPlen=dPlen*10^(-9);
        t=length(SF);
        T=SF(2,1)- SF(1,1);
        Fd=1/(T*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(t);
        F=0:Fd/FftLS:Fd/2-Fd/FftLS;
        S1=F;
        S2=FftS(1:length(F));
        %   %
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        R1=FR;
        R2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        RS1=FS;
        RS2=FftSS(1:length(FS));
        if length(RS1)>length(R1)
            RS1=R1;
        end
        TF=(RS2./R2(1:length(RS1)));
        dF=unwrap(angle(TF));
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*RS1'*dSample)).*dF);
        NN=4*ReS2./(ReS2+ones(I)).^2;
        ImS2=((3*10^8)./(2*pi*RS1'*dSample)).*(log(NN)-log(abs(TF)));
        PP=ReS2+ImS2.*1i;
        Con=((PP+ones(I)).*(RS2./S2-ones(I)))./377;
        Pir=ones(I)+(1i*Con./(2*pi*RS1'*dPlen*8.85*10^(-12)));
        PPP=sqrt(Pir);
        S2=4*pi*RS1'.*imag(PPP)./(3*10^8);
        plot(S1./(10^12),S2);
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 10 %Коэф. пропускания/отражения
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        S1=FR;
        S2=FftSR(1:length(FR));
        %   %
        tr=length(SF);
        TR=SF(2,1)- SF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(tr);
        FS=0:Fd/FftLS:Fd/2-Fd/FftLS;
        R1=FS;
        R2=FftS(1:length(FS));
        if length(S1)>length(R1)
            S1=R1;
        end
        S2=abs(R2./S2(1:length(S1)));
        plot(S1./(10^12),S2)
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 11 % ПП пленки
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        dPlen=handles.metricdata.edit8;
        dPlen=dPlen*10^(-9);
        t=length(SF);
        T=SF(2,1)- SF(1,1);
        Fd=1/(T*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(t);
        F=0:Fd/FftLS:Fd/2-Fd/FftLS;
        S1=F;
        S2=FftS(1:length(F));
        %   %
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        R1=FR;
        R2=FftSR(1:length(FR));
        %   %
        tr=length(SSF);
        TR=SSF(2,1)- SSF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SSF(:,2),FftLSS)); % частотное фурье
        FftSS=B./(tr);
        FS=0:Fd/FftLSS:Fd/2-Fd/FftLSS;
        RS1=FS;
        RS2=FftSS(1:length(FS));
        if length(RS1)>length(R1)
            RS1=R1;
        end
        TF=(RS2./R2(1:length(RS1)));
        dF=unwrap(angle(TF));
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*RS1'*dSample)).*dF);
        NN=4*ReS2./(ReS2+ones(I)).^2;
        ImS2=((3*10^8)./(2*pi*RS1'*dSample)).*(log(NN)-log(abs(TF)));
        PP=ReS2+ImS2.*1i;
        Con=((PP+ones(I)).*(RS2./S2-ones(I)))./377;
        Dir=ones(I)+(1i*Con./(2*pi*RS1'*dPlen*8.85*10^(-12)));
        S2=sqrt(Dir);
        plot(S1./(10^12),S2,S1./(10^12),imag(S2),'--');
        xlim([0 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 12 % eff ПП
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        dPlen=handles.metricdata.edit8;
        dPlen=dPlen*10^(-9);
        dSample=dSample+dPlen;
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        S1=FR;
        S2=FftSR(1:length(FR));
        %   %
        tr=length(SF);
        TR=SF(2,1)- SF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(tr);
        FS=0:Fd/FftLS:Fd/2-Fd/FftLS;
        R1=FS;
        R2=FftS(1:length(FS));
        if length(S1)>length(R1)
            S1=R1;
        end
        TF=(R2./S2(1:length(S1)));
        dF=unwrap(angle(TF));
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*S1'*dSample)).*dF);
        NN=4*ReS2./(ReS2+ones(I)).^2;
        %NN=1;
        ImS2=((3*10^8)./(2*pi*S1'*dSample)).*(log(NN)-log(abs(TF)));
        S2=ReS2+ImS2.*1i;
        plot(S1./(10^12),S2,S1./(10^12),imag(S2),'--');
        xlim([0.2 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
    case 13 % диэльктрическая образца
        dSample=handles.metricdata.edit3;
        dSample=dSample*10^(-6);
        dPlen=handles.metricdata.edit8;
        dPlen=dPlen*10^(-9);
        dSample=dSample+dPlen;
        tr=length(RF);
        TR=RF(2,1)- RF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(RF(:,2),FftLR)); % частотное фурье
        FftSR=B./(tr);
        FR=0:Fd/FftLR:Fd/2-Fd/FftLR;
        S1=FR;
        S2=FftSR(1:length(FR));
        %   %
        tr=length(SF);
        TR=SF(2,1)- SF(1,1);
        Fd=1/(TR*10^(-12)); % частота
        B=(fft(SF(:,2),FftLS)); % частотное фурье
        FftS=B./(tr);
        FS=0:Fd/FftLS:Fd/2-Fd/FftLS;
        R1=FS;
        R2=FftS(1:length(FS));
        if length(S1)>length(R1)
            S1=R1;
        end
        TF=(R2./S2(1:length(S1)));
        dF=unwrap(angle(TF));
        I=size(dF);
        ReS2=ones(I)-((3*10^8)./((2*pi*S1'*dSample)).*dF);
        %NN=4*ReS2./(ReS2+ones(I)).^2;
        NN=1;
        ImS2=((3*10^8)./(2*pi*S1'*dSample)).*(log(NN)-log(abs(TF)));
        PP=ReS2+ImS2.*1i;
        S2=PP.^2;
        plot(S1./(10^12),S2,S1./(10^12),imag(S2),'--');
        xlim([0.2 1]); % диапазон графика (Xmin Xmax Ymin Ymax)
        xlabel('Частота (TГц)');% Подпись оси х графика
end
switch popup_sel_index
    case 1
        set(handles.uibuttongroup2,'Visible', 'on')
    otherwise
        set(handles.uibuttongroup2,'Visible', 'off')
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

function [S2]=DLCunwrap(S2)
[CM PM]=max(S2);
k=1;
while k<PM
    S2(k)=S2(k)+(CM-S2(k)).*2;
    k=k+1;
end
CM=max(S2);
S2=S2(:)-CM;
return
function [S2]=aproc(S2,F)
S2=S2(1:length(F));
S2=S2';
N=1;
coeff1 = polyfit(F, S2, N);
y2=0;
for k=0:N
    S2 = y2 + coeff1(N-k+1) * F.^k;
end
return
% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles) %содержание выбора графика
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

ChooseF=cell(1,1);
ChooseF{1}='Signal';
ChooseF{2}='Frequncy';
ChooseF{3}='Phase sample and reference';
ChooseF{4}='Коэф. пропускания/отражения подложки';
ChooseF{5}='фазовая задержка подложки';
ChooseF{6}='Показатель преломления подложки';
ChooseF{7}='Проводимость тонкой пленки';
ChooseF{8}='Диэлектрическая тонкой пленки';
ChooseF{9}='Поглощение тонкой пленки';
ChooseF{10}='Коэф. пропускания/отражения образца';
ChooseF{11}='ПП пленки (Образца(без подложки))';
ChooseF{12}='Eff ПП (Образец с подложкой)';
ChooseF{13}='Диэлектрическая образца(eff) (Образец с подложкой)';

set (hObject, 'String', ChooseF);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)% путь сохранения
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DirecF;
global DirecN;
if DirecN
    uigetdir(DirecN, 'Куда сохранить'); % куда сохранять
    DirecN=ans; % запоминание переменной куда сохранять
else
    uigetdir(DirecF, 'Куда сохранить'); % куда сохранять
    DirecN=ans; % запоминание переменной куда сохранять
end
set(handles.text19,'String', DirecN);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles) %Button Save
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S1 S2;
global DirecF;
global DirecN;
global ONameF;

if size(S2)~=size(S1);
    S1=S1';
end
if isreal(S2)
    AM=[S1 S2];
else
    S3=imag(S2);
    S2=real(S2);
    AM=[S1 S2 S3];
end
if DirecN
    NNameFr=inputdlg('Название','Сохранение частоты',1,ONameF); % имя сохранения
    SFr=[DirecN '\' NNameFr '.txt'];
    SFr=cell2mat(SFr);
    save(SFr,'AM','-ascii');
else
    NNameFr=inputdlg('Название','Сохранение частоты',1,ONameF); % имя сохранения
    SFr=[DirecF '\' NNameFr '.txt'];
    SFr=cell2mat(SFr);
    save(SFr,'AM','-ascii');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)%button Refernce
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global R ; %Сигналы
global FftLR ; %Кол-во отсчетов

[NameR,DirecR]=uigetfile('*.txt');% загрузка файла
ONameR=cellstr(NameR);
NameR=[DirecR NameR];
fileID = fopen(NameR);
formatSpec = '%f';
sizeA = [2 Inf];
R=load(NameR);
%R = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
%R=R';
dR=sum(R(1:10,2))/10;
R=R-dR;
tr=length(R);
FftLR=2.^nextpow2(tr); % кол-во отсчетов
set(handles.uibuttongroup2,'Visible', 'on')
set(handles.uibuttongroup8,'Visible', 'on')
set(handles.text10, 'String', tr);
set(handles.slider5,'Max',tr)
set(handles.slider6,'Max',tr)
set(handles.slider5,'SliderStep', [1/tr,1/tr])
set(handles.slider6,'SliderStep', [1/tr,1/tr])
popupmenu3_Callback(hObject, eventdata, handles);

function [F1,MAXAS]=rectan(l,r,S) %прямоугольный фильтр
lef=l+1;
t=length(S);
F1=S;
rig=t-r;
M=zeros(t,1);
M(lef:rig)=1;
M=M';
F1(:,2)=M;
MAXAS=max(S);
return
function [F1,MAXAS]=Tuki(l,r,S)
lef=l+1;
t=length(S);
F1=S;
rig=t-r;
M=zeros(t,1);
dt=rig-lef+1;
Tf=tukeywin(dt);
%Tf=Tf';
M(lef:rig)=Tf;
M=M';
F1(:,2)=M;
MAXAS=max(S);
return
function [F1,MAXAS]=gaus(l,r,S)
lef=l+1;
t=length(S);
F1=S;
rig=t-r;
M=zeros(t,1);
dt=rig-lef+1;
Tf=gausswin(dt);
%Tf=Tf';
M(lef:rig)=Tf;
M=M';
F1(:,2)=M;
MAXAS=max(S);
return

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles) %Фильтр для Sample
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global S; %сигналы
global F1; %Сигнал фиьтра
global MAXAS; %Максимум от сигнала
axes(handles.axes1);
cla;
popup_sel_index = get(handles.popupmenu4, 'Value');
lef=handles.metricdata.edit1;
rig=handles.metricdata.edit2;
switch popup_sel_index
    case 1
        clear global F1;
    case 2
        [F1,MAXAS]=rectan(lef,rig,S);
    case 3
        [F1,MAXAS]=Tuki(lef,rig,S);
    case 4
        [F1,MAXAS]=gaus(lef,rig,S);
end
popupmenu3_Callback(hObject, eventdata, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles) %Содержание списка фильтра для Sample
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set (hObject, 'String', {'Без фильтра','Прямоугольный','Тьюки','Гаусс' });

function edit1_Callback(hObject, eventdata, handles) %Левый диапазон для фильтра Sample
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

edit1 = str2double(handles.edit1.String);
if isnan(edit1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new density value
handles.edit1.String=edit1;
handles.metricdata.edit1 = str2double(handles.edit1.String);
guidata(hObject,handles);
handles.slider3.Value=edit1;
popupmenu4_Callback(hObject, eventdata, handles);

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

function edit2_Callback(hObject, eventdata, handles) %Правый диапазон для фильтра Sample
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

edit2 = str2double(handles.edit2.String);
if isnan(edit2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new density value
handles.edit2.String=edit2;
handles.metricdata.edit2 = str2double(handles.edit2.String);
guidata(hObject,handles);
handles.slider4.Value=edit2;
popupmenu4_Callback(hObject, eventdata, handles);

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

function initialize_gui(fig_handle, handles, isreset) %Стандартные значения
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

handles.metricdata.edit1 = 0;
handles.metricdata.edit2 = 0;
handles.metricdata.edit3 = 0;
handles.metricdata.edit4 = 0;
handles.metricdata.edit5 = 0;
handles.metricdata.edit6 = 0;
handles.metricdata.edit7 = 0;
handles.metricdata.edit8 = 0;

guidata(handles.figure1, handles);

function edit3_Callback(hObject, eventdata, handles) %Толщина образца
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
edit3 = str2double(get(hObject, 'String'));
if isnan(edit3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.metricdata.edit3 = edit3;
guidata(hObject,handles);
popupmenu3_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles) %Загрузка сигнала Sub
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SS FftLSS;
[NameR,DirecR]=uigetfile('*.txt');% загрузка файла
ONameR=cellstr(NameR);
NameR=[DirecR NameR];
fileID = fopen(NameR);
formatSpec = '%f';
sizeA = [2 Inf];
SS=load(NameR);
%SS = fscanf(fileID,formatSpec,sizeA); % Сигнал в матрицу
fclose(fileID);
%SS=SS';
dSS=sum(SS(1:10,2))/10;
SS=SS-dSS;
sr=length(SS);
FftLSS=2.^nextpow2(sr); % кол-во отсчетов
popupmenu3_Callback(hObject, eventdata, handles);
set(handles.uibuttongroup2,'Visible', 'on')
set(handles.uibuttongroup9,'Visible', 'on')
set(handles.slider7,'Max',sr)
set(handles.slider8,'Max',sr)
set(handles.slider7,'SliderStep', [1/sr,1/sr])
set(handles.slider8,'SliderStep', [1/sr,1/sr])
set(handles.text16, 'String', sr);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles) % Очистить
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global
axes(handles.axes2);
cla;
axes(handles.axes1);
cla
set(handles.uibuttongroup2,'Visible', 'off')
set(handles.uibuttongroup5,'Visible', 'off')
set(handles.uibuttongroup8,'Visible', 'off')
set(handles.uibuttongroup9,'Visible', 'off')
set(handles.text19,'String', 'Нет пути сохранения');
initialize_gui(hObject, handles, false);

% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles) % Фиьлтры для опорного сигнала
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
global R; %сигналы
global F2; %Сигнал фиьтра
global MAXAR; %Максимум от сигнала
axes(handles.axes1);
cla;
popup_sel_index2 = get(handles.popupmenu6, 'Value');
lef=handles.metricdata.edit4;
rig=handles.metricdata.edit5;
switch popup_sel_index2
    case 1
        clear global F2;
    case 2
        [F2,MAXAR]=rectan(lef,rig,R);
    case 3
        [F2,MAXAR]=Tuki(lef,rig,R);
    case 4
        [F2,MAXAR]=gaus(lef,rig,R);
end
popupmenu3_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.popupmenu4_CreateFcn
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set (hObject, 'String', {'Без фильтра','Прямоугольный', 'Тьюки','Гаусс' });

function edit4_Callback(hObject, eventdata, handles) %Левый диапазон для фильтра опорника
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
edit4 = str2double(handles.edit4.String);
if isnan(edit4)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

handles.edit4.String=edit4;
handles.metricdata.edit4 = str2double(handles.edit4.String);
guidata(hObject,handles);

handles.slider5.Value=edit4;
popupmenu6_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles) % Правый диапазон для фильтра опорника
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
edit5 = str2double(handles.edit5.String);
if isnan(edit5)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.edit5.String=edit5;
handles.metricdata.edit5 = str2double(handles.edit5.String);
guidata(hObject,handles);
handles.slider6.Value=edit5;
popupmenu6_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles) % фильтр для подложки
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
global SS; %сигналы
global F3; %Сигнал фиьтра
global MAXASS; %Максимум от сигнала
axes(handles.axes1);
cla;
popup_sel_index = get(handles.popupmenu7, 'Value');
lef=handles.metricdata.edit6;
rig=handles.metricdata.edit7;
switch popup_sel_index
    case 1
        clear global F3;
    case 2
        [F3,MAXASS]=rectan(lef,rig,SS);
    case 3
        [F3,MAXASS]=Tuki(lef,rig,SS);
    case 4
        [F3,MAXASS]=gaus(lef,rig,SS);
        
end
popupmenu3_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end
set (hObject, 'String', {'Без фильтра','Прямоугольный','Тьюки' ,'Гаусс'});

function edit6_Callback(hObject, eventdata, handles) %левый диапазон для филььтра подложки
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
edit6 = str2double(handles.edit6.String);
if isnan(edit6)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.edit6.String=edit6;
handles.metricdata.edit6 = str2double(handles.edit6.String);
guidata(hObject,handles);
handles.slider7.Value=edit6;
popupmenu7_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles) %правый диапазон для филььтра подложки
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
edit7 = str2double(handles.edit7.String);
if isnan(edit7)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.edit7.String=edit7;
handles.metricdata.edit7 = str2double(handles.edit7.String);
guidata(hObject,handles);
handles.slider8.Value=edit7;
popupmenu7_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles) % Скрыть сигнал подложки
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global SS;
global MSS;
Check1=get(hObject,'Value');
if Check1
    MSS=SS;
    clear global SS F3;
else
    SS=MSS;
    popupmenu7_Callback(hObject, eventdata, handles)
end
popupmenu3_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles) %Скрыть сигнал образца
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global S;
global MS;
Check2=get(hObject,'Value');
if Check2
    MS=S;
    clear global S F1;
else
    S=MS;
    popupmenu4_Callback(hObject, eventdata, handles)
end
popupmenu3_Callback(hObject, eventdata, handles)

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles) %Скрыть сигнал опорника
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global R;
global MR;
Check3=get(hObject,'Value');
if Check3
    MR=R;
    clear global R F2;
else
    R=MR;
    popupmenu6_Callback(hObject, eventdata, handles)
end
popupmenu3_Callback(hObject, eventdata, handles)

function edit8_Callback(hObject, eventdata, handles)%Толщина пленки
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
edit8 = str2double(get(hObject, 'String'));
if isnan(edit8)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.metricdata.edit8 = edit8;
guidata(hObject,handles);
popupmenu3_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1
% eventdata  structure with the following fields
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
popupmenu3_Callback(hObject, eventdata, handles);

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
edit1=handles.slider3.Value;
handles.edit1.String=edit1;
edit1_Callback(hObject, eventdata, handles);

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
edit2=handles.slider4.Value;
handles.edit2.String=edit2;
edit2_Callback(hObject, eventdata, handles);


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

edit4=handles.slider5.Value;
handles.edit4.String=edit4;
edit4_Callback(hObject, eventdata, handles);


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
edit5=handles.slider6.Value;
handles.edit5.String=edit5;
edit5_Callback(hObject, eventdata, handles);


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
edit6=handles.slider7.Value;
handles.edit6.String=edit6;
edit6_Callback(hObject, eventdata, handles);

% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
edit7=handles.slider8.Value;
handles.edit7.String=edit7;
edit7_Callback(hObject, eventdata, handles);
