function subsubpage1_2
clear
clc

%% 创建主界面
hf = figure('Name','不等精度测量数据误差分析',...
    'NumberTitle','off',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

%% 界面控件
% 设置文字项属性(11)
t = [uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf)];
ui_string = {'数据：','置信系数：','平均值：','标准差：','数据：','平均值：','标准差：','算术平均值标准差：','加权算术平均值：','加权算术平均值标准差：','权：','结果：','±','残余误差分布图'};
ui_position = [20,405,80,25%L1
                      20,350,80,25%L2
					  20,320,80,25%L2
                      20,290,80,25%L3
					  380,395,80,25%R1
                      380,340,80,25%R2
					  380,310,80,25%R3
                      20,260,130,25%L4
                      380,260,130,25%L5
                      20,230,180,25%R4
                      380,230,180,25
                      20,10,130,25%B1
                      205,10,10,25%B2
                      560,190,100,20];%R4

for i = 1:length(t)
    set(t(i),...
        'Style','text',...
        'String',ui_string(i),...
        'FontName','微软雅黑',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',ui_position(i,:),...
        'BackgroundColor','White');
end

% 输入数据文本框(10)
e = [uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf)];
e_position = [450,230,240,25
                     100,380,240,50%L1
                     100,350,240,25%L2
					 100,320,240,25%L2
                     100,290,240,25%L3
                     450,370,240,50%R1
                     450,340,240,25%R2
                     180,230,160,25%R3/
                     500,260,190,25%R3/
                     160,260,180,25%L4
                     450,310,240,25%L5
                     100,10,100,25%B1
                     220,10,100,25
                     ];%B2

for i = 1:length(e)
    set(e(i),...
        'Style','edit',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'HorizontalAlignment','left',...
        'BackgroundColor','White');
end
for i = 4:length(e)
    set(e(i),'Enable','inactive');
    % set(e(i),'String',i);
end
set(e(1),'Enable','inactive');
set(e(2),'Enable','inactive');
set(e(2),'Min',1,'Max',3);
set(e(6),'Min',1,'Max',3);


% 面板
uipanel(...
    'Title','剔除粗大误差后的新数据处理',...
    'FontSize',10,...
	'FontName','微软雅黑',...
    'Units','pixels',...
    'Position',[350,290,350,160],...
    'BackgroundColor','White');

% 按钮(4)
b = [uicontrol(hf,'CallBack',@imp),uicontrol(hf,'CallBack',@run1),uicontrol(hf,'CallBack',@outp),uicontrol(hf,'CallBack','page_exit')];
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
	'CallBack',@data_cho,...
	'UserData',1,...
    'FontSize',10);

axes('Units','pixels',...
        'Position',[30,60,650,160],...
        'Box','on',...
        'Tag','axes');

% obj = findobj(gcf);
% for i = 9:21
%     set(obj(i),'String',i);
% end

function data_cho(~,~)
global data_cell;
obj = findobj(gcf);
s1 = str2num(get(obj(20),'String'));
s2 = str2num(get(obj(19),'String'));
if isempty(s1)||isempty(s2)
	warndlg('缺少输入参数！');
	return;
end

[data1,v2,a1,a2,s1,s2,s2_x,p,x_,s_x_,x] = data_process2(data_cell,s2);
obj = findobj(gcf);
val = get(obj(3),'Value');
set(obj(20),'String',data_cell{val});

axes(obj(2));
plot(v2{val},'-o');

set(obj(21),'String',p(val));
set(obj(18),'String',a1(val));
set(obj(17),'String',s1(val));
set(obj(16),'String',data1{val});
set(obj(15),'String',a2(val));
set(obj(14),'String',s_x_);
set(obj(13),'String',x_);
set(obj(12),'String',s2_x(val));
set(obj(11),'String',s2(val));
set(obj(10),'String',x(1));
set(obj(9),'String',x(2));

function run1(~,~)
global data_cell;
obj = findobj(gcf);
s1 = str2num(get(obj(20),'String'));
s2 = str2num(get(obj(19),'String'));
if isempty(s1)||isempty(s2)
	warndlg('缺少输入参数！');
	return;
end

[data1,v2,a1,a2,s1,s2,s2_x,p,x_,s_x_,x] = data_process2(data_cell,s2);

axes(obj(2));
plot(v2{1},'-o');

set(obj(21),'String',p(1));
set(obj(18),'String',a1(1));
set(obj(17),'String',s1(1));
set(obj(16),'String',data1{1});
set(obj(15),'String',a2(1));
set(obj(14),'String',s_x_);
set(obj(13),'String',x_);
set(obj(12),'String',s2_x(1));
set(obj(11),'String',s2(1));
set(obj(10),'String',x(1));
set(obj(9),'String',x(2));

function imp(~,~)
global data_cell;
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
tip_num = 1;
for i=2:(s(1))
	tip = strcat(tip,'|第',num2str(i),'组数据');
	tip_num = [tip_num,i];
end
obj = findobj(gcf);
set(obj(3),'String',tip);
set(obj(3),'UserData',tip_num);
set(obj(20),'String',data(1,:));

function outp(~,~)
obj = findobj(gcf);
header = {'数据','置信系数','平均值','标准差','剔除粗大误差后平均值','剔除粗大误差后标准差','算术平均值标准差','数据的权','加权算术平均值','加权算术平均值标准差','结果'};
a = num2str(get(obj(3),'Value'));
b = num2str(get(obj(19),'String'));
c = num2str(get(obj(18),'String'));
d = num2str(get(obj(17),'String'));
e = num2str(get(obj(15),'String'));
f = num2str(get(obj(11),'String'));
g = num2str(get(obj(12),'String'));
h = num2str(get(obj(21),'String'));
i = num2str(get(obj(13),'String'));
j = num2str(get(obj(14),'String'));
k = num2str(get(obj(10),'String'));
l = num2str(get(obj(9),'String'));
values = {strcat('第',a,'组数据'),b,c,d,e,f,g,h,i,j,strcat(k,'±',l)};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('保存成功','提示','warn');