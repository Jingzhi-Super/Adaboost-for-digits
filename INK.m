function varargout = INK(varargin)
% INK MATLAB code for INK.fig
%      INK, by itself, creates a new INK or raises the existing
%      singleton*.
%
%      H = INK returns the handle to a new INK or the handle to
%      the existing singleton*.
%
%      INK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INK.M with the given input arguments.
%
%      INK('Property','Value',...) creates a new INK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before INK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to INK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help INK

% Last Modified by GUIDE v2.5 24-Apr-2016 17:52:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @INK_OpeningFcn, ...
                   'gui_OutputFcn',  @INK_OutputFcn, ...
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


% --- Executes just before INK is made visible.
function INK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to INK (see VARARGIN)

% Choose default command line output for INK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes INK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


global drawing;
drawing =0;
set(gcf,'WindowButtonDownFcn',@mouseDown)
set(gcf,'WindowButtonMotionFcn',@mouseMove)
set(gcf,'WindowButtonUpFcn',@mouseUp)

global pnt
global Npnt stroke
stroke=1;
pnt = {};
Npnt = 0;
tic

% --- Outputs from this function are returned to the command line.
function varargout = INK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ClearButton.
function ClearButton_Callback(hObject, eventdata, handles)
% hObject    handle to ClearButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
global pnt stroke
global Npnt
pnt = {};
Npnt = 0;
stroke=1;


function mouseDown(hObject, eventdata, handles) 
global drawing 
drawing = 1;



function mouseUp(hObject, eventdata, handles) 
global drawing Npnt stroke
% global Spnt
drawing = 0;
Npnt=0;
stroke=stroke+1;


function mouseMove(hObject, eventdata, handles) 
global drawing
global Npnt
global pnt
global stroke
if drawing
    C = get(gca,'CurrentPoint');
    if C(1,1)<1 && C(1,1)>0 && C(1,2)<1 && C(1,2)>0
        Npnt = Npnt+1;
        pnt{stroke}(Npnt,1) = C(1,1);
        pnt{stroke}(Npnt,2) = C(1,2);
%         pnt{stroke}(Npnt,3) = toc;
        plot(C(1,1),C(1,2),'k','marker','o','MarkerFaceColor','r');
        hold on
        xlim([0 1]); ylim([0 1]);
        set(gca,'XTick',[],'YTick',[])
        box on
    end


end



function Score_Callback(hObject, eventdata, handles)
% hObject    handle to Score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Score as text
%        str2double(get(hObject,'String')) returns contents of Score as a double


% --- Executes during object creation, after setting all properties.
function Score_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end


% --- Executes on button press in Recognize.
function Recognize_Callback(hObject, eventdata, handles)
% hObject    handle to Recognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pnt
Inkdata=pnt';
save Inkdata Inkdata
load feature
load Inkdata
load weak_parameter
tosee = waitbar(0,'Processing 0%');
[Inkdata] = discard(Inkdata);
data=cell2mat(Inkdata);
% calculate features
[strokes]=numel(Inkdata);%3.1.1 symbol strokes(1)
[cusp_feature] = cusp(Inkdata);%3.1.2 cusp features(1+4)
[aspect_ratio]=(max(data(:,1))-min(data(:,1)))/(max(data(:,2))-min(data(:,2)));%3.1.3 aspect ratio(1)
[intersect_feature] = isintersect(Inkdata);%3.1.4 intersection features(1+4)
[tdhistogram] = twoDhistogram(data);%3.1.5 2-dimensional point histogram(9)
[anghistogram] = anglehistogram(Inkdata,data);%3.1.6 angle histogram(4)
[fld] = FLdistance(Inkdata);%3.1.7 first and last distance(1)
[length] = arclength(Inkdata);%3.1.8 arc length(1)
[fitline_feature] = fitline(Inkdata);%3.1.9 fit line feature(1)
[dominant_feature] = dominantpoint(Inkdata);%3.1.10 dominant point features(4)
[S] = strokearea(Inkdata);%3.1.11 stroke area(1)
[SR] = sideratio(Inkdata,data);%3.1.12 side ratios(2)
[TP] = tbratio(Inkdata,data);%3.1.13 top and bottom ratios(2)
[minmax_feature] = minandmax(Inkdata);%3.1.14 min and max features(10)
f=[strokes;cusp_feature;aspect_ratio;intersect_feature;tdhistogram;...
    anghistogram;fld;length;fitline_feature;dominant_feature;S;SR;TP;minmax_feature];
T=3;
J=47;
H=zeros(9,10);
for i=1:9
    for k=i+1:10
        weak_hy=weak_parameter{i,k}{2};
        alpha=weak_parameter{i,k}{1};
        temp=0;
        for t=1:J*T
            j=mod(t-1,J)+1;
            h=weak(f(j),weak_hy(t,1),weak_hy(t,2));
            temp=temp+alpha(t)*h;
        end
        temp=sgn(temp);
        H(i,k)=temp;
    end
    waitbar(i/10,tosee,['Processing ',num2str(10*i),'%...']);

end
score=zeros(10,1);
for i=1:9
    for j=i+1:10
        if H(i,j)==1
            score(i)=score(i)+1;
        else
            score(j)=score(j)+1;
        end
    end
end
waitbar(10,tosee,'Processing 100%...');
result=find(score==max(score));
winner=result-1;
tie=numel(result);
if tie>1
    for i=1:tie-1
        if H(result(i),result(i+1))==1;
            winner=result(i);
        else 
            winner=result(i+1);
        end
    end
    winner=winner-1;
else
    winner=result-1;
end
close(tosee);
set(handles. Gesture,'String',winner);



function Gesture_Callback(hObject, eventdata, handles)
% hObject    handle to Gesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gesture as text
%        str2double(get(hObject,'String')) returns contents of Gesture as a double


% --- Executes during object creation, after setting all properties.
function Gesture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
