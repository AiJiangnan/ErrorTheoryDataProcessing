function subsubpage4_2
clear all;
clc
global obj;

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','不等精度测量线性参数最小二乘法处理',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

% 静态文本框
t = 1:6;
t_string = {'A:','L:','P:','中间结果：','逆矩阵结果：','最小二乘估计结果：'};
t_position = [
    20,420,50,25
    20,290,50,25
    20,160,50,25
    360,420,120,25
    360,290,100,25
    360,160,120,25
];

for i = 1:length(t)
    t(i) = uicontrol(hf,...
        'Style','text',...
        'String',t_string(i),...
        'FontName','微软雅黑',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% 文本框
e = 1:6;
e_tag = {'A','L','P','m_result','inv_result','result'};
e_position = [
    70,320,260,125
    70,190,260,125
    70,60,260,125
    480,320,200,125
    480,190,200,125
    480,60,200,125
];

for i = 1:length(e)
    e(i) = uicontrol(hf,...
        'Style','edit',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'BackgroundColor','White',...
        'Tag',e_tag{i},...
        'Min',1,'Max',3,...
        'HorizontalAlignment','left');
end
for i = 4:length(e)
    set(e(i),'Enable','inactive');
end

% 按钮
b = [uicontrol(hf,'CallBack',@run1),uicontrol(hf,'CallBack','page_exit')];
b_string = {'计算','返回'};
b_position = [
    430,10,80,25
    520,10,80,25
];

for i = 1:length(b)
    set(b(i),...
        'Style','pushbutton',...
        'String',b_string(i),...
        'FontName','微软雅黑',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',b_position(i,:));
end

guidata(hf,guihandles);

% 计算函数
function run1(cbo,handles)
handles = guidata(cbo);
A = str2num(get(handles.A,'String'));
L = str2num(get(handles.L,'String'));
P = str2num(get(handles.P,'String'));
if isempty(A)||isempty(L)||isempty(P)
	warndlg('缺少输入参数！');
	return;
end
[C,D,EX] = data_process4(A,L,P);
set(handles.m_result,'String',num2str(C));
set(handles.inv_result,'String',num2str(D));
set(handles.result,'String',num2str(EX));