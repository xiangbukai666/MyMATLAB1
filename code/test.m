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

% Last Modified by GUIDE v2.5 21-Dec-2024 20:48:54

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
      global path;
      global filename;
      axes(handles.axes1);
      cla reset;
      axes(handles.axes2);
      cla reset;
      axes(handles.axes3);
      cla reset;
      [filename,pathname]=uigetfile('*.jpg;*.png;*.bmp', '选择图片');
      path=fullfile(pathname,filename);
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
           prompt={'目标图像均值（0~255）:', '目标图像标准差（>0）:'};
           dlg_title='直方图匹配功能参数';
           num_lines=1;
           defaultans={'128', '25'};
           answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
           if ~isempty(answer)
                mean=str2double(answer{1});
                sd=str2double(answer{2});
                if isnan(mean)||isnan(sd)
                    errordlg('输入参数有误！', 'Invalid Input');
                    return;
                end
                img_matchHist=hist_match(Img, mean, sd);
                axes(handles.axes2);
                imshow(img_matchHist);
                title('直方图匹配后图像:');
                img_matchHistDisplay=hist_display(img_matchHist);
                axes(handles.axes3); 
                bar(img_matchHistDisplay);
                title('对应灰度直方图:');
                xlabel('灰度级');
                ylabel('频率');
            end
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
    prompt = {'参数R（0~1）:','参数G（0~1）:','参数B（0~1）:'};
    dlg_title = '图像灰度化功能参数';
    num_lines = 1;
    defaultans={'0.299','0.587','0.114'};
    answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
    if ~isempty(answer)
        r=str2double(answer{1});
        g=str2double(answer{2});
        b=str2double(answer{3});
        if isnan(r)||isnan(g)||isnan(b)
            errordlg('输入有误！','Invalid Input');
            return;
        end
    axes(handles.axes3);
    cla reset;
    Img_gray=img_gray(Img,r,g,b);
    axes(handles.axes2);
    imshow(Img_gray),title('灰度图像');
    end


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
            prompt={'对比度增强因子（>0）:', '调整亮度偏移量:'};
            dlg_title='线性对比度增强函数功能参数';
            num_lines=1;
            defaultans={'0.5','0.5'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                contrast_factor=str2double(answer{1});
                offset=str2double(answer{2});
                if isnan(contrast_factor)||isnan(offset)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            imgLE=LinearEnhancement(Img,contrast_factor,offset);
            axes(handles.axes2);
            imshow(imgLE),title('对比度线性增强图像:');
            end
        case '对数对比度增强'
            imgLogE=LogEnhancement(Img);
            axes(handles.axes2);
            imshow(imgLogE),title('对比度对数增强图像:');
        case '指数对比度增强'
            prompt={'伽马矫正（0~5）:'};
            dlg_title='指数对比度增强函数功能参数';
            num_lines=1;
            defaultans={'2'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                gamma=str2double(answer{1});
                if isnan(gamma)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            imgEE=ExEnhancement(Img,gamma);
            axes(handles.axes2);
            imshow(imgEE),title('对比度指数增强图像:');
            end
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
            prompt={'水平缩放因子（>0）:','垂直缩放因子（>0）:'};
            dlg_title='缩放函数功能参数';
            num_lines=1;
            defaultans={'3','2'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                kx=str2double(answer{1});
                ky=str2double(answer{2});
                if isnan(kx)||isnan(ky)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            img_scal=img_scaling(Img,kx,ky);
            axes(handles.axes2);
            imshow(img_scal),title(['缩放图像（大小： ',num2str(size(img_scal,1)),'×',num2str(size(img_scal,2)),'）']);
            end
        case '图像旋转'
            prompt={'旋转角度（0~360）:'};
            dlg_title='图片旋转函数功能参数';
            num_lines=1;
            defaultans={'90'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                angle=str2double(answer{1});
                if isnan(angle)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            img_rotate=img_rotation(Img,angle);
            axes(handles.axes2);
            imshow(img_rotate),title('逆时针旋转图像：');
            end
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
            prompt={'噪声分布均值:','噪声分布标准差:'};
            dlg_title='高斯加噪函数功能参数';
            num_lines=1;
            defaultans={'0','0.1'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                mean=str2double(answer{1});
                sd=str2double(answer{2});
                if isnan(mean)||isnan(sd)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            Img_noise=gauss_noise(Img,mean,sd);
            axes(handles.axes2);
            imshow(Img_noise),title('高斯加噪图像：');
            end
        case '椒盐噪声'
            prompt={'噪声分布密度（0~1）:','盐噪声（0~255）:','椒噪声（0~255）:'};
            dlg_title='椒盐加噪函数功能参数';
            num_lines=1;
            defaultans={'0.1','255','0'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                n=str2double(answer{1});
                salt=str2double(answer{2});
                pepper=str2double(answer{3});
                if isnan(n)||isnan(salt)||isnan(pepper)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            Img_noise=salt_pepper_noise(Img,n,salt,pepper);
            axes(handles.axes2);
            imshow(Img_noise),title('椒盐加噪图像：');
            end
        case '均匀噪声'
            prompt={'噪声分布密度（0~255）:'};
            dlg_title='均匀加噪函数功能参数';
            num_lines=1;
            defaultans={'20'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                n=str2double(answer{1});
                if isnan(n)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            Img_noise=average_noise(Img,n);
            axes(handles.axes2);
            imshow(Img_noise),title('均匀加噪图像：');
            end
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
            prompt={'滤波核大小（>1奇数）:'};
            dlg_title='中值滤波函数功能参数';
            num_lines=1;
            defaultans={'3'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                n=str2double(answer{1});
                if isnan(n)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            img_MedianF=median_filter(Img_noise,n);
            axes(handles.axes3);
            imshow(img_MedianF),title('中值滤波图像：');
            end
        case '均值滤波'
            prompt={'滤波核大小（>1奇数）:'};
            dlg_title='均值滤波函数功能参数';
            num_lines=1;
            defaultans={'3'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                n=str2double(answer{1});
                if isnan(n)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            img_MeanF=mean_filter(Img_noise,n);
            axes(handles.axes3);
            imshow(img_MeanF),title('均值滤波图像：');
            end
        case '频域滤波'
            prompt={'截止频率（>0）:'};
            dlg_title='频域滤波函数功能参数';
            num_lines=1;
            defaultans={'60'};
            answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
            if ~isempty(answer)
                d=str2double(answer{1});
                if isnan(d)
                    errordlg('输入参数有误！','Invalid Input');
                    return;
                end
            img_FrequencyF=frequency_filter(Img_noise,d);
            axes(handles.axes3);
            imshow(img_FrequencyF),title('频域滤波图像：');
            end
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        axes(handles.axes1);
        cla reset;
        axes(handles.axes2);
        cla reset;
        axes(handles.axes3);
        cla reset;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    disp('功能参数说明（输入框中是默认的测试数据）：');
    disp('除了直方图相关功能操作，其余功能尽量选择彩色图像！');
    disp('图片直方图匹配功能参数：均值、标准差；');
    disp('均值，标准差为使用高斯分布作为匹配目标的参数。');
    disp('       ');
    disp('图片灰度化函数功能参数：R、G、B（0~1）；');
    disp('默认取值rgb:0.299,0.587,0.114。');
    disp('       ');
    disp('线性对比度增强函数功能参数：对比度增强因子（>0）、调整亮度偏移量；');
    disp('对比度增强因子>1，增强对比度，反之；亮度偏移量>0增加亮度，反之。');
    disp('          ');
    disp('指数对比度增强函数功能参数：伽马矫正gamma；');
    disp('gamma>1，图像看起来偏暗；gamma=1，属于线性变化；gamma<1图像看起来偏亮。');
    disp('       ');
    disp('图片缩放函数功能参数：水平缩放因子、垂直缩放因子，分别对应参数1、2；');
    disp('采用双线性插值进行缩放。');
    disp('        ');
    disp('图片旋转函数功能参数：旋转角度；');
    disp('图片将进行逆时针旋转。');
    disp('       ');
    disp('高斯加噪函数功能参数：均值、标准差；');
    disp('均值通常为0，表示噪声分布的中心点；标准差越大，噪声幅度越大，图像随机性越高，反之。');
    disp('      ');
    disp('椒盐加噪函数功能参数：噪声密度、盐噪声、椒噪声；');
    disp('噪声密度越大，噪声点越多；盐噪声，椒噪声大小表示对应噪声最大值。');
    disp('         ');
    disp('均匀加噪函数功能参数：噪声值范围；');
    disp('噪声值范围对应均匀分布的上下界。');
    disp('          ');
    disp('中值滤波、均值滤波函数功能参数：滤波核大小；');
    disp('核大小为>1的奇数，大的核能处理更多的噪声，也可能模糊图像边缘。');
    disp('         ');
    disp('频域滤波函数功能参数：截止频率；');
    disp('截止频率决定那些成分被保留，哪些滤除的临界点。');
    disp('         ');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)  
    global path;
    py.sys.path().append('D:/matlab/code/testphoto.py');
    %导入Python模块'photo'
    py.importlib.import_module('testphoto');  
    model='D:/matlab/code/best.pt';
    %从 Python 获取预测结果
    try
        result = py.testphoto.img_pre(path, model);  %获取预测结果
        %将Python字符串转换为MATLAB字符串
        resultStr = char(result);
        %如果结果为空或不可识别,显示"无法识别的"
        if isempty(resultStr)||strcmp(resultStr, '')
            resultStr='无法识别的';
        end
    catch
        % 如果发生错误,显示"无法识别的"
        resultStr='无法识别的';
    end 
    % 将预测结果显示在GUI中
    set(handles.text9,'String',resultStr);
