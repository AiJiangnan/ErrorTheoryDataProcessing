function subsubpage2
clear all;
clc
global obj;

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','误差的合成',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

% 静态文本框
t = 1:3;
t_string = {'a:','Δ:','Result:'};
t_position = [
    20,420,50,25
    20,290,50,25
    20,160,50,25
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
e = 1:3;
e_position = [
    70,320,610,125
    70,190,610,125
    70,60,610,125
];

for i = 1:length(e)
    e(i) = uicontrol(hf,...
        'Style','edit',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'BackgroundColor','White',...
        'Min',1,'Max',3,...
        'HorizontalAlignment','left');
end
set(e(3),'Enable','inactive');

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

obj = findobj(gcf);

function run1(a,b)
global obj;
a = str2num(get(obj(6),'String'));
delta = str2num(get(obj(5),'String'));
if isempty(a)||isempty(delta)
	warndlg('缺少输入参数！');
	return;
end
result = error_combination(a,delta);
set(obj(4),'String',num2str(result));