function subsubpage1_1
clear all;
clc

%% ����������
s = get(0,'ScreenSize');% ��ȡ�������Ļ�ֱ���
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','�Ⱦ��Ȳ�������������',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Tag','figure',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

%��������������
t = 1:11;
t_string = {'���ݣ�','����ϵ����','ƽ��ֵ��','��׼�','���ݣ�','ƽ��ֵ��','��׼�','����ƽ��ֵ��׼�','�����','��','�������ֲ�ͼ'};
t_position = [20,405,80,25
               20,350,80,25
			   20,320,80,25
               20,290,80,25
			   380,395,80,25
               380,340,80,25
			   380,310,80,25
               20,260,130,25
               20,10,130,25
               205,10,10,25
               550,250,150,20];

for i = 1:length(t)
    t(i) = uicontrol(hf,...
        'Style','text',...
        'String',t_string{i},...
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% ���������ı���
e = 1:10;
e_tag = {'data','coefficient','average','standard','data_','average_','standard_','average_standard','result_1','result_2'};
e_position = [100,380,240,50
              100,350,240,25
			  100,320,240,25
              100,290,240,25
              450,370,240,50
              450,340,240,25
              450,310,240,25
              160,260,180,25
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

% ���
uipanel(...
    'Title','�޳��ִ�����������ݴ���',...
    'FontSize',10,...
	'FontName','΢���ź�',...
    'Units','pixels',...
    'Position',[350,290,350,160],...
    'BackgroundColor','White');

% ��ť
b = [uicontrol(hf,'CallBack',@imp),...
     uicontrol(hf,'CallBack',@run1),...
     uicontrol(hf,'CallBack',@outp),...
     uicontrol(hf,'CallBack','page_exit')];
b_string = {'����','����','����','����'};
b_position = [20,380,50,25
              430,10,80,25
              520,10,80,25
              610,10,80,25];

for i = 1:length(b)
    set(b(i),...
        'Style','pushbutton',...
        'String',b_string(i),...
        'FontName','΢���ź�',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',b_position(i,:));
end

% �����б�
uicontrol(hf,...
    'Style','popup',...
    'Position',[340,10,80,25],...
    'String','����',...
	'Value',1,...
    'Tag','list',...
	'CallBack',@data_cho,...
    'FontSize',10);

% ������
axes('Units','pixels',...
     'Position',[30,60,650,190],...
     'Tag','axes',...
     'Box','on');

guidata(hf,guihandles);

% �������ݺ���
function imp(cbo,handles)
handles = guidata(cbo);
[FileName,PathName,FilterIndex] = uigetfile(...
    {'*.txt','Text Data Files(*.txt)';...
     '*.xls','Excel ������(*.xls)'});
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
tip = '����1';
for i=2:(s(1))
	tip = strcat(tip,'|����',num2str(i));
end
set(handles.list,'String',tip);
set(handles.data,'String',data_cell{1});
msgbox('����ɹ�','��ʾ','warn');

mydata = guihandles(handles.figure);
mydata.data_cell = data_cell;
guidata(handles.figure,mydata);

% ����ѡ����
function data_cho(cbo,handles)
handles = guidata(cbo);
if isfield(handles,'data_cell')==0
    warndlg('û�����ݣ�');
else
    val = get(handles.list,'Value');
    set(handles.data,'String',handles.data_cell{val});
end

% ���㺯��
function run1(cbo,handles)
handles = guidata(cbo);
s1 = str2num(get(handles.data,'String'));
s2 = str2num(get(handles.coefficient,'String'));
if isempty(s1)||isempty(s2)
	warndlg('ȱ�����������');
	return;
end
[data1,v1,a,a1,s,s1,s1_x,x] = data_process1(s1,s2);
axes(handles.axes);
plot(v1,'-o');
set(handles.data_,'String',data1);
set(handles.average,'String',a);
set(handles.average_,'String',a1);
set(handles.standard,'String',s);
set(handles.standard_,'String',s1);
set(handles.average_standard,'String',s1_x);
set(handles.result_1,'String',x(1));
set(handles.result_2,'String',x(2));

% �������ݺ���
function outp(cbo,handles)
handles = guidata(cbo);
data        = strcat('����',num2str(get(handles.list,'Value')));
coefficient = str2num(get(handles.coefficient,'String'));
average     = str2num(get(handles.average,'String'));
standard    = str2num(get(handles.standard,'String'));
average_    = str2num(get(handles.average_,'String'));
standard_   = str2num(get(handles.standard_,'String'));
average_standard   = str2num(get(handles.average_standard,'String'));
result1     = str2num(get(handles.result_1,'String'));
result2     = str2num(get(handles.result_2,'String'));
fid = fopen(strcat(datestr(now,'yyyy-mm-dd_HH-MM-ss'),'.txt'),'w');
fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n','����','����ϵ��','ƽ��ֵ','��׼��','�޳��ִ�����ƽ��ֵ','�޳��ִ������׼��','����ƽ��ֵ��׼��','���');
fprintf(fid,'%s\t%.2f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.3f��%.3f',data,coefficient,average,standard,average_,standard_,average_standard,result1,result2);
fclose(fid);
msgbox('����ɹ�','��ʾ','warn');