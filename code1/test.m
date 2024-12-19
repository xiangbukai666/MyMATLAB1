function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 16-Dec-2024 17:05:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
      global Img;
      axes(handles.axes1);
      cla reset;
      axes(handles.axes2);
      cla reset;
      axes(handles.axes3);
      cla reset;
      [filename,pathname]=uigetfile('*.jpg','选择图片');
      path=[pathname filename];
      Img=imread(path);
      axes(handles.axes1);
      imshow(Img);

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img;
    switch contents{selectedOption}
        case '显示灰度直方图'
            axes(handles.axes3);
            cla reset;
            img_histDisplay = hist_display(Img);
            axes(handles.axes2); 
            bar(img_histDisplay);
            title('灰度直方图:');
            xlabel('灰度级');
            ylabel('频率');
        case '直方图均衡化'
            img_eqHist=hist_eq(Img);
            axes(handles.axes2);
            imshow(img_eqHist),title('直方图均衡化后图像:');
            img_eqHistDisplay = hist_display(img_eqHist);
            axes(handles.axes3); 
            bar(img_eqHistDisplay);
            title('对应灰度直方图:');
            xlabel('灰度级');
            ylabel('频率');
        case '直方图匹配'
                img_matchHist=hist_match(Img);
                axes(handles.axes2);
                imshow(img_matchHist);
                title('直方图匹配后图像:');
                img_matchHistDisplay=hist_display(img_matchHist);
                axes(handles.axes3); 
                bar(img_matchHistDisplay);
                title('对应灰度直方图:');
                xlabel('灰度级');
                ylabel('频率');
        otherwise
            disp('Incorrect operation!');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global Img;
    axes(handles.axes3);
    cla reset;
    Img_gray=img_gray(Img);
    axes(handles.axes2);
    imshow(Img_gray),title('灰度图像');


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img;
    axes(handles.axes3);
    cla reset;
    switch contents{selectedOption}
        case '线性对比度增强'        
            imgLE=LinearEnhancement(Img);
            axes(handles.axes2);
            imshow(imgLE),title('对比度线性增强图像:');
        case '对数对比度增强'
            imgLogE=LogEnhancement(Img);
            axes(handles.axes2);
            imshow(imgLogE),title('对比度对数增强图像:');
        case '指数对比度增强'
            imgEE=ExEnhancement(Img);
            axes(handles.axes2);
            imshow(imgEE),title('对比度指数增强图像:');
        otherwise
            disp('Incorrect operation!');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img;
    axes(handles.axes3);
    cla reset;
    switch contents{selectedOption}
        case '图像缩放'
            img_scal=img_scaling(Img);
            axes(handles.axes2);
            imshow(img_scal),title(['缩放图像（大小： ',num2str(size(img_scal,1)),'×',num2str(size(img_scal,2)),'）']);
        case '图像旋转'
            img_rotate=img_rotation(Img);
            axes(handles.axes2);
            imshow(img_rotate),title('逆时针旋转图像：');
        case 'HSV颜色空间转换'
            img_hsv=hsv_img(Img);
            axes(handles.axes2);
            imshow(img_hsv),title('HSV颜色空间图像：');
         case 'YCbCr颜色空间转换'
            img_ycbcr=ycbcr_img(Img);
            axes(handles.axes2);
            imshow(img_ycbcr),title('YcBcR颜色空间图像：');
        otherwise
            disp('Incorrect operation!');
    end


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img;
    global Img_noise;
    axes(handles.axes3);
    cla reset;
    switch contents{selectedOption}
        case '高斯噪声'
            Img_noise=gauss_noise(Img);
            axes(handles.axes2);
            imshow(Img_noise),title('高斯加噪图像：');
        case '椒盐噪声'
            Img_noise=salt_pepper_noise(Img);
            axes(handles.axes2);
            imshow(Img_noise),title('椒盐加噪图像：');
        case '均匀噪声'
            Img_noise=average_noise(Img);
            axes(handles.axes2);
            imshow(Img_noise),title('均匀加噪图像：');
        otherwise
            disp('Incorrect operation!');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img_noise;
    switch contents{selectedOption}
        case '中值滤波'
            img_MedianF=median_filter(Img_noise);
            axes(handles.axes3);
            imshow(img_MedianF),title('中值滤波图像：');
        case '均值滤波'
            img_MeanF=mean_filter(Img_noise);
            axes(handles.axes3);
            imshow(img_MeanF),title('均值滤波图像：');
        case '频域滤波'
            img_FrequencyF=frequency_filter(Img_noise);
            axes(handles.axes3);
            imshow(img_FrequencyF),title('频域滤波图像：');
        otherwise
            disp('Incorrect operation!');
    end


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img;
    axes(handles.axes3);
    cla reset;
    switch contents{selectedOption}
        case 'Robert算子边缘提取'
            img_edge=robert_edge(Img);
            axes(handles.axes2);
            imshow(img_edge),title('Robert算子边缘提取图像：');
        case 'Prewitt算子边缘提取'
            img_edge=prewitt_edge(Img);
            axes(handles.axes2);
            imshow(img_edge),title('Prewitt算子边缘提取图像：');
        case 'Sobel算子边缘提取'
            img_edge=sobel_edge(Img);
            axes(handles.axes2);
            imshow(img_edge),title('Sobel算子边缘提取图像：');
        case '拉普拉斯算子边缘提取'
            img_edge=laplace_edge(Img);
            axes(handles.axes2);
            imshow(img_edge),title('拉普拉斯算子边缘提取图像：');
        otherwise
            disp('Incorrect operation!');
    end

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
    contents=cellstr(get(hObject,'String'));
    selectedOption=get(hObject,'Value');
    global Img;
    switch contents{selectedOption}
        case '目标提取'
            [img_morph,img_extraction]=feature_extraction(Img);
            axes(handles.axes2);
            imshow(img_morph),title('提取目标的形态学滤波：');
            axes(handles.axes3);
            imshow(img_extraction),title('提取目标显示：');
        case 'LBP特征提取'
            img_LBP1=displayLBPFeatures(Img);
            axes(handles.axes2);
            imshow(img_LBP1,[]),title('原始图像LBP特征提取：')
            [img_morph,img_extraction]=feature_extraction(Img);
            img_LBP2=displayLBPFeatures(img_morph);
            axes(handles.axes3);
            imshow(img_LBP2,[]),title('提取目标LBP特征提取：');
        case 'HOG特征提取'
            [featureVector,hogVisualization] = extractHOGFeatures(Img);
            axes(handles.axes2)
            imshow(Img),title('原始图像HOG特征提取：');
            hold on;
            plot(hogVisualization);
            [img_morph,img_extraction]=feature_extraction(Img);
            [featureVector,hogVisualization] = extractHOGFeatures(img_morph);
            axes(handles.axes3)
            imshow(img_morph),title('提取目标HOG特征提取：');
            hold on;
            plot(hogVisualization);
        otherwise
            disp('Incorrect operation!');
    end


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

