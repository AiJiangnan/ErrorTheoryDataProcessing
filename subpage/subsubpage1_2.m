function subsubpage1_2
clear all;
clc
global obj;

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','不等精度测量数据误差分析',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

%% 界面控件
% 设置文字项属性
t = 1:14;
t_string = {'数据：','置信系数：','平均值：','标准差：','数据：','平均值：','标准差：','算术平均值标准差：',...
            '加权算术平均值：','加权算术平均值标准差：','权：','结果：','±','残余误差分布图'};
t_position = [20,405,80,25
              20,350,80,25
              20,320,80,25
              20,290,80,25
              380,395,80,25
              380,340,80,25
              380,310,80,25
              20,260,130,25
              380,260,130,25
              20,230,180,25
              380,230,180,25
              20,10,130,25
              205,10,10,25
              560,190,100,20];

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

% 输入数据文本框
e = 1:13;
e_position = [100,380,240,50
              100,350,240,25
			  100,320,240,25
              100,290,240,25
              450,370,240,50
              450,340,240,25
              450,310,240,25
              160,260,180,25
              450,230,240,25
              500,260,190,25
              180,230,160,25
              100,10,100,25
              220,10,100,25];

for i = 1:length(e)
    e(i) = uicontrol(hf,...
        'Style','edit',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'HorizontalAlignment','left',...
        'BackgroundColor','White');
end
for i = 3:length(e)
    set(e(i),'Enable','inactive');
end
set(e(1),'Min',1,'Max',3);
set(e(5),'Min',1,'Max',3);

% 面板
uipanel(...
    'Title','剔除粗大误差后的新数据处理',...
    'FontSize',10,...
	'FontName','微软雅黑',...
    'Units','pixels',...
    'Position',[350,290,350,160],...
    'BackgroundColor','White');

% 按钮(4)
b = [uicontrol(hf,'CallBack',@imp),...
     uicontrol(hf,'CallBack',@run1),...
     uicontrol(hf,'CallBack',@outp),...
     uicontrol(hf,'CallBack','page_exit')];
b_string = {'导入','计算','保存','返回'};
b_position = [20,380,50,25
              430,10,80,25
              520,10,80,25
              610,10,80,25];
                 
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
    'Position',[340,10,80,25],...
    'String','数据',...
	'Value',1,...
	'CallBack',@run1,...
	'UserData',1,...
    'FontSize',10);

axes('Units','pixels',...
        'Position',[30,60,650,160],...
        'Box','on');

obj = findobj(gcf);

function run1(a,b)
global data_cell;
global obj;
s1 = str2num(get(obj(21),'String'));
s2 = str2num(get(obj(20),'String'));
if isempty(s1)||isempty(s2)
	warndlg('缺少输入参数！');
	return;
end
val = get(obj(3),'Value');
set(obj(21),'String',data_cell{val});
[data1,v2,a1,a2,s1,s2,s2_x,p,x_,s_x_,x] = data_process2(data_cell,s2);
axes(obj(2));
plot(v2{val},'-o');
result = {x(2),x(1),s_x_,x_,p(val),s2_x(val),s2(val),a2(val),data1{val},s1(val),a1(val)};
for i = 9:19
    set(obj(i),'String',result{i-8});
end

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
set(obj(3),'String',tip);
set(obj(21),'String',data_cell{1});
msgbox('导入成功','提示','warn');

function outp(a,b)
global obj;
header = {'数据','置信系数','平均值','标准差','剔除粗大误差后平均值','剔除粗大误差后标准差',...
          '算术平均值标准差','数据的权','加权算术平均值','加权算术平均值标准差','结果'};
a = num2str(get(obj(3),'Value'));
n = [20:-1:18 16:-1:9];
for i = 1:length(n)
    str{i} = get(obj(n(i)),'String');
end
values = {strcat('第',a,'组数据'),str{1:9},strcat(str{10},'±',str{11})};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('保存成功','提示','warn');