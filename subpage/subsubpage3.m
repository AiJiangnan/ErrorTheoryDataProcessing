function subsubpage3
clear all
clc
global obj;

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','测量不确定度',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

% 面板
uipanel(...
    'Title','不确定度报告',...
    'FontSize',10,...
	'FontName','微软雅黑',...
    'Units','pixels',...
    'Position',[20,70,660,230],...
    'BackgroundColor','White');

% 不确定度
t = 1:18;
t_string = {'数据：','u1(^-6):','u2(^-6):','u3(^-6):','v1:','v2:','v3:',...
    'V:','u_c:','v:','合成标准不确定度：','展伸不确定度：',...
    'V:','±','P:','v:','置信概率：','包含因子：'};
t_position = [
    20,420,50,25
    20,370,60,25
    20,340,60,25
    20,310,60,25
    360,370,50,25
    360,340,50,25
    360,310,50,25
    40,220,50,25
    40,190,50,25
    40,160,50,25
    40,250,150,25
    40,120,150,25
    40,90,50,25
    190,90,50,25
    350,90,50,25
    520,90,50,25
    420,420,100,25
    420,395,100,25
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

% 不确定度文本框
e = 1:16;
e_position = [
    80,400,320,45
    500,423,160,22
    500,398,160,22
    80,370,240,25
    80,340,240,25
    80,310,240,25
    420,370,240,25
    420,340,240,25
    420,310,240,25
    100,220,550,25
    100,190,550,25
    100,160,550,25
    80,90,110,25
    200,90,110,25
    370,90,110,25
    540,90,110,25
];
for i = 1:length(e)
    e(i) = uicontrol(hf,...
        'Style','edit',...
        'FontName','微软雅黑',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'BackgroundColor','White');
end
for i = 10:length(e)
    set(e(i),'Enable','inactive');
end
set(e(1),'Min',1,'Max',3);

% 按钮
b = [uicontrol(hf,'CallBack',@imp),...
     uicontrol(hf,'CallBack',@run1),...
     uicontrol(hf,'CallBack',@outp),...
     uicontrol(hf,'CallBack','page_exit')];
b_string = {'导入','计算','保存','返回'};
b_position = [20,400,50,25
              410,20,80,25
              500,20,80,25
              590,20,80,25];
                 
for i = 1:length(b)
    set(b(i),...
        'Style','pushbutton',...
        'String',b_string(i),...
        'FontName','微软雅黑',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',b_position(i,:));
end

uicontrol(hf,...
    'Style','popup',...
    'Position',[310,20,80,25],...
    'String','数据',...
	'Value',1,...
	'CallBack',@data_cho,...
	'UserData',1,...
    'FontSize',10);

obj = findobj(gcf);

function data_cho(a,b)
global data_cell;
global obj;
val = get(obj(2),'Value');
set(obj(22),'String',data_cell{val});

function imp(a,b)
global data_cell;
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
s = size(data);
data_cell = cell(s(1),1);
for i = 1:s(1)
	a = data(i,:);
	a(isnan(a)) = [];
	data_cell{i} = a;
end
tip = '第1组数据';
for i=2:(s(1))
	tip = strcat(tip,'|第',num2str(i),'组数据');
end
set(obj(2),'String',tip);
set(obj(22),'String',data_cell{1});
msgbox('导入成功','提示','warn');

function run1(a,b)
global obj;
for i = 14:22
    s = str2num(get(obj(i),'String'));
    if isempty(s)
	    warndlg('缺少输入参数！');
	    return;
    end
end
V = str2num(get(obj(22),'String'));
n1 = 21:-1:14;
for i=1:length(n1);
    x(i) = str2num(get(obj(n1(i)),'String'));
end
[V_,u_c,v_,U,P_] = uncertainty(V,x(3:5),x(6:8),x(1),x(2));
result = [v_,P_,U/1000000,V_,v_,u_c/1000000,V_];
for i=7:13
    set(obj(i),'String',result(i-6));
end

function outp(a,b)
global obj;
header = {'数据：','u1(^-6)','u2(^-6)','u3(^-6)','v1','v2','v3',...
        'V','u_c','v','V','P','v','置信概率','包含因子'};
n = [19:-1:7 21:-1:20];
for i = 1:length(n)
    str{i} = num2str(get(obj(n(i)),'String'));
end
a = num2str(get(obj(2),'Value'));
values = {strcat('数据',a),str{1:9},strcat(str{10},'±',str{11}),str{12:15}};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('保存成功','提示','warn');