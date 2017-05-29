function subsubpage3
clear all
clc

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','测量不确定度',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Tag','figure',...
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
e_tag = {'data','probability','divisor','u1','u2','u3','v1','v2','v3','V','u_c','v','result_1','result_2','P','v_'};
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
        'Tag',e_tag{i},...
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
    'Tag','list',...
	'CallBack',@data_cho,...
	'UserData',1,...
    'FontSize',10);

guidata(hf,guihandles);

% 导入数据函数
function imp(cbo,handles)
handles = guidata(cbo);
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
set(handles.list,'String',tip);
set(handles.data,'String',data_cell{1});
msgbox('导入成功','提示','warn');

mydata = guihandles(handles.figure);
mydata.data_cell = data_cell;
guidata(handles.figure,mydata);

% 数据选择函函数
function data_cho(cbo,handles)
handles = guidata(cbo);
if isfield(handles,'data_cell')==0
    warndlg('没有数据！');
else
    val = get(handles.list,'Value');
    set(handles.data,'String',handles.data_cell{val});
end

% 计算函数
function run1(cbo,handles)
handles = guidata(cbo);
data    = str2num(get(handles.data,'String'));
probability = str2num(get(handles.probability,'String'));
divisor = str2num(get(handles.divisor,'String'));
u1      = str2num(get(handles.u1,'String'));
u2      = str2num(get(handles.u2,'String'));
u3      = str2num(get(handles.u3,'String'));
v1      = str2num(get(handles.v1,'String'));
v2      = str2num(get(handles.v2,'String'));
v3      = str2num(get(handles.v3,'String'));
if isempty(data)||isempty(probability)||isempty(divisor)||isempty(u1)||isempty(u2)||isempty(u3)||isempty(v1)||isempty(v2)||isempty(v3)
	warndlg('缺少输入参数！');
	return;
end
[V,u_c,v_,U] = uncertainty(data,[u1 u2 u3],[v1 v2 v3],divisor);
set(handles.V,'String',V);
set(handles.u_c,'String',u_c/1000000);
set(handles.v,'String',v_);
set(handles.result_1,'String',V);
set(handles.result_2,'String',U/1000000);
set(handles.P,'String',probability);
set(handles.v_,'String',v_);

% 保存数据函数
function outp(cbo,handles)
handles = guidata(cbo);
data    = strcat('第',num2str(get(handles.list,'Value')),'组数据');
u1 = str2num(get(handles.u1,'String'));
u2 = str2num(get(handles.u2,'String'));
u3 = str2num(get(handles.u3,'String'));
v1 = str2num(get(handles.v1,'String'));
v2 = str2num(get(handles.v2,'String'));
v3 = str2num(get(handles.v3,'String'));
V  = str2num(get(handles.V,'String'));
u_c= str2num(get(handles.u_c,'String'));
v  = str2num(get(handles.v,'String'));
U  = str2num(get(handles.result_2,'String'));
probability = str2num(get(handles.probability,'String'));
divisor = str2num(get(handles.divisor,'String'));
fid = fopen(strcat(datestr(now,'yyyy-mm-dd_HH-MM-ss'),'.txt'),'w');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n','数据','u1(^-6)','u2(^-6)','u3(^-6)','v1','v2','v3','V','u_c','v','V','P','v','置信概率','包含因子');
fprintf(fid,'%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.6f\t%.6f\t%d\t%.6f±%.6f\t%.2f\t%d\t%.2f\t%.2f',data,u1,u2,u3,v1,v2,v3,V,u_c,v,V,U,probability,v,probability,divisor);
fclose(fid);
msgbox('保存成功','提示','warn');