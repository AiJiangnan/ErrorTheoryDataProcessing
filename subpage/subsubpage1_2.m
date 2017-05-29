function subsubpage1_2
clear all;
clc

%% 创建主界面
s = get(0,'ScreenSize');% 获取计算机屏幕分辨率
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','不等精度测量数据误差分析',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Tag','figure',...
    'Resize','off');

% 更改界面左上角图标
icon;

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
e_tag = {'data','coefficient','average','standard','data_','average_','standard_','average_standard','weight','waverage','waverage_standard','result_1','result_2'};
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
        'Tag',e_tag{i},...
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

% 下拉列表
uicontrol(hf,...
    'Style','popup',...
    'Position',[340,10,80,25],...
    'String','数据',...
	'Value',1,...
    'Tag','list',...
	'CallBack',@run1,...
	'UserData',1,...
    'FontSize',10);

% 坐标轴
axes('Units','pixels',...
    'Position',[30,60,650,160],...
    'Tag','axes',...
    'Box','on');

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

% 计算函数
function run1(cbo,handles)
handles = guidata(cbo);
set(handles.coefficient,'String',2.58);
s1 = str2num(get(handles.data,'String'));
s2 = str2num(get(handles.coefficient,'String'));
if isempty(s1)||isempty(s2)
	warndlg('缺少输入参数！');
	return;
end
val = get(handles.list,'Value');
set(handles.data,'String',handles.data_cell{val});
[data1,v2,a1,a2,s1,s2,s2_x,p,x_,s_x_,x] = data_process2(handles.data_cell,s2);
axes(handles.axes);
plot(v2{val},'-o');
set(handles.average,'String',a1(val));
set(handles.standard,'String',s1(val));
set(handles.data_,'String',data1(val));
set(handles.average_,'String',a2(val));
set(handles.standard_,'String',s2(val));
set(handles.average_standard,'String',s2_x(val));
set(handles.weight,'String',p(val));
set(handles.waverage,'String',x_);
set(handles.waverage_standard,'String',s_x_);
set(handles.result_1,'String',x(1));
set(handles.result_2,'String',x(2));

% 保存数据函数
function outp(cbo,handles)
handles = guidata(cbo);
data        = strcat('第',num2str(get(handles.list,'Value')),'组数据');
coefficient = str2num(get(handles.coefficient,'String'));
average     = str2num(get(handles.average,'String'));
standard    = str2num(get(handles.standard,'String'));
average_    = str2num(get(handles.average_,'String'));
standard_   = str2num(get(handles.standard_,'String'));
average_standard   = str2num(get(handles.average_standard,'String'));
weight      = str2num(get(handles.weight,'String'));
waverage    = str2num(get(handles.waverage,'String'));
waverage_standard  = str2num(get(handles.waverage_standard,'String'));
result1     = str2num(get(handles.result_1,'String'));
result2     = str2num(get(handles.result_2,'String'));
fid = fopen(strcat(datestr(now,'yyyy-mm-dd_HH-MM-ss'),'.txt'),'w');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n','数据','置信系数','平均值','标准差','剔除粗大误差后平均值','剔除粗大误差后标准差','算术平均值标准差','数据的权','加权算术平均值','加权算术平均值标准差','结果');
fprintf(fid,'%s\t%.2f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.3f±%.3f',data,coefficient,average,standard,average_,standard_,average_standard,weight,waverage,waverage_standard,result1,result2);
fclose(fid);
msgbox('保存成功','提示','warn');