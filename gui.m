function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 30-Apr-2017 21:04:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Generate.
function Generate_Callback(hObject, eventdata, handles)
% hObject    handle to Generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get data
data = get(handles.Inp_Vec, 'Data');
S = [data{1}, data{3}; data{3}, data{2}];
angle = str2num(get(handles.Angle, 'String'));
rm = Rotation(S, angle);
[values, vectors, angles, points] = main_func(S);

% Set data
set(handles.Eigenvalues, 'data', values);
set(handles.Eigenvectors, 'data', vectors);
set(handles.Eigenvector_Angles, 'data', angles);
set(handles.Rotated_Matrix, 'data', rm);

% Graph data
graph = handles.Graph;
axes(graph);
cla reset;

% Graph circle
x = points(1,:);
y = points(2,:);
area(x, y, 'FaceColor', [.8 .8 0], 'EdgeColor', 'none');
hold on
plot(x, y, 'Color', 'b', 'LineWidth', 1.5);

% Graph original matrix
hold on
plot([S(1,1), S(2,2)], [S(1,2),-S(1,2)], '-ok', 'MarkerFaceColor', 'k', 'LineWidth',1);

% Graph rotated matrix
hold on
plot([rm(1,1), rm(2,2)], [rm(1,2),-rm(1,2)], '--or', 'MarkerFaceColor', 'r', 'LineWidth',1);

% Graph eigenvalues
hold on
plot(values(1),0, 'og', 'MarkerFaceColor', 'g');
hold on
plot(values(2),0, 'og', 'MarkerFaceColor', 'g');

% Graph vectors from angles
hold on;
scale = (((S(1,1) - S(2,2))^2 + (S(1,2) + S(1,2))^2)^.5)/4; % fourth of the diameter
centerX = (S(1,1) + S(2,2)) / 2;
centerY = (S(1,2) - S(1,2)) / 2;
u = cosd(2*angles(1));
v = sind(2*angles(1));
quiver(centerX,centerY,u,v, scale,'LineWidth', 1.5, 'Color', 'magenta', 'MaxHeadSize', 1);
hold on;
u = cosd(2*angles(2));
v = sind(2*angles(2));
quiver(centerX,centerY,u,v, scale,'LineWidth', 1.5, 'Color', 'cyan', 'MaxHeadSize',1);

% Set graph options
graph.XAxisLocation = 'origin';
graph.YAxisLocation = 'origin';
axis square equal;
grid on;

% --- Executes during object creation, after setting all properties.
function Inp_Vec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Inp_Vec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(1, 3));



function Angle_Callback(hObject, eventdata, handles)
% hObject    handle to Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Angle as text
%        str2double(get(hObject,'String')) returns contents of Angle as a double


% --- Executes during object creation, after setting all properties.
function Angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Rotated_Matrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rotated_Matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(2));


% --- Executes during object creation, after setting all properties.
function Eigenvalues_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Eigenvalues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(1, 2));


% --- Executes during object creation, after setting all properties.
function Eigenvectors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Eigenvectors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(2));


% --- Executes during object creation, after setting all properties.
function Eigenvector_Angles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Eigenvector_Angles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'Data', cell(1, 2));
