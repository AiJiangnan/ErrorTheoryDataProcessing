function index
clear
clc

% 添加子文件夹路径
addpath(genpath(pwd));

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','基于GUI的误差理论与数据处理系统',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[x,y,600,450],...
    'MenuBar','none',...
    'Color','White',...
    'CloseRequestFcn',@hexit,...
    'Resize','off');

% 更改界面左上角图标
icon;

% 学校名称
axes('Units','pixels',...
    'Position',[0,350,430,100],...
    'Tag','logo',...
    'CreateFcn',@school_logo);

% 校训
uicontrol(hf,...
    'Units','pixels',...
    'Position',[300,320,230,25],...
    'Style','text',...
    'String','崇德博智，扶危定倾',...
    'FontName','楷体',...
    'FontSize',18,...
    'FontWeight','bold',...
    'ForegroundColor',[7,51,123]/255,...
    'BackgroundColor','White');

% 学校标志性建筑
axes('Units','pixels',...
    'Position',[0,80,600,233],...
    'CreateFcn','imshow(''image/school.jpg'')');

%% 一级菜单按钮
uicontrol(hf,...
    'Units','pixels',...
    'Position',[160,35,280,25],...
    'Style','text',...
    'String','《误差理论与数据处理》',...
    'FontName','楷体',...
    'FontSize',18,...
    'FontWeight','bold',...
    'ForegroundColor',[7,51,123]/255,...
    'BackgroundColor','White',...
    'enable','inactive',...
    'ButtonDownFcn','subpage');
uicontrol(hf,...
    'Units','pixels',...
    'Position',[160,5,280,25],...
    'Style','text',...
    'String','Error Theory and Data Processing',...
    'FontSize',12,...
    'FontWeight','bold',...
    'ForegroundColor',[7,51,123]/255,...
    'BackgroundColor','White',...
    'enable','inactive',...
    'ButtonDownFcn','subpage');

% 显示学校名称PNG图片函数
function school_logo(cbo,handles)
[I,c,alpha] = imread('image/school_logo.png');
h = imshow(I);
set(h,'AlphaData',alpha);

%% 主界面退出对话框
function hexit(cbo,handles)
he = questdlg('你确定退出吗？','退出程序','是','否','否');
if strcmp(he,'是')
    close;
    clear;
    clc;
end;