function subsubpage5
clear all;
clc
global obj;

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','回归分析',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

% 静态文本框
t = 1:5;
t_string = {'x:','y:','n次多项式拟合：','残差分析结果：','拟合结果：'};
t_position = [
    20,420,50,25
    20,390,50,25
    20,360,100,25
    20,330,100,25
    360,330,100,25
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
e = 1:2;
e_position = [
    70,420,600,25
    70,390,600,25
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

uicontrol(hf,...
    'Style','popup',...
    'Position',[130,360,100,25],...
    'String','1|2|3|4|5|6|7|8',...
	'Value',2,...
    'FontSize',10,...
    'BackgroundColor','White');

% 按钮
b = [uicontrol(hf,'CallBack',@imp),...
     uicontrol(hf,'CallBack',@run1),...
     uicontrol(hf,'CallBack',@outp),...
     uicontrol(hf,'CallBack','page_exit')];
b_string = {'导入','计算','保存','返回'};
b_position = [
    250,360,80,25
    430,10,80,25
    520,10,80,25
    610,10,80,25
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

axes('Units','pixels',...
    'Position',[30,60,300,260],...
    'Box','on');

axes('Units','pixels',...
    'Position',[370,60,300,260],...
    'Box','on');

obj = findobj(gcf);

function imp(~,~)
global obj;
[FileName,PathName,FilterIndex] = uigetfile(...
    {'*.txt','Text Data Files(*.txt)';...
     '*.xls','Excel 工作薄(*.xls)'});
if FileName==0
    return;
end
if FilterIndex==1
	data = load(strcat(PathName,FileName));
else
	data = xlsread(strcat(PathName,FileName));
end
set(obj(10),'String',data(1,:));
set(obj(9),'String',data(2,:));
msgbox('导入成功','提示','warn');

function run1(~,~)
global obj;
x = str2num(get(obj(10),'String'));
y = str2num(get(obj(9),'String'));
l = size(x);
if l(1)>1
    x = x';
    y = y';
end
n = get(obj(8),'Value');
if isempty(x)||isempty(y)
	warndlg('缺少输入参数！');
	return;
end
I = ones(length(x),1);
for i=1:n
    b = x.^i;
    I = [I b'];
end
[b,bint,r,rint,stats]=regress(y',I);
axes(obj(3));
rcoplot(r,rint);
title('');
xlabel('');
ylabel('');
Y = polyval(b(end:-1:1),x);
axes(obj(2));
plot(x,y,'k+',x,Y,'r');

function outp(~,~)
global obj;
f1 = getframe(obj(3));
f2 = getframe(obj(2));
imwrite(f1.cdata,'残差分析结果.jpg','jpg')
imwrite(f2.cdata,'拟合结果.jpg','jpg')
msgbox('保存图像成功','提示','warn');