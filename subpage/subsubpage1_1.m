function subsubpage1_1
clear all;
clc
global obj;

%% ����������
s = get(0,'ScreenSize');% ��ȡ�������Ļ�ֱ���
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','�Ⱦ��Ȳ�������������',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

%% ����ؼ�
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
        'String',t_string(i),...
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% ���������ı���
e = 1:10;
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

% ��ť(4)
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

uicontrol(hf,...
    'Style','popup',...
    'Position',[340,10,80,25],...
    'String','����',...
	'Value',1,...
	'CallBack',@data_cho,...
    'FontSize',10);

axes('Units','pixels',...
     'Position',[30,60,650,190],...
     'Box','on');
     
obj = findobj(gcf);

function data_cho(a,b)
global data_cell;
global obj;
val = get(obj(3),'Value');
set(obj(18),'String',data_cell{val});

function run1(a,b)
global obj;
s1 = str2num(get(obj(18),'String'));
s2 = str2num(get(obj(17),'String'));
if isempty(s1)||isempty(s2)
	warndlg('ȱ�����������');
	return;
end
[data1,v1,a,a1,s,s1,s1_x,x] = data_process1(s1,s2);
result = {x(2),x(1),s1_x,s1,a1,data1,s,a};
axes(obj(2));
plot(v1,'-o');
for i = 9:16
    set(obj(i),'String',result{i-8});
end

function imp(a,b)
global data_cell;
global obj;
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
set(obj(3),'String',tip);
set(obj(18),'String',data_cell{1});
msgbox('����ɹ�','��ʾ','warn');

function outp(a,b)
global obj;
header = {'����','����ϵ��','ƽ��ֵ','��׼��','�޳��ִ�����ƽ��ֵ','�޳��ִ������׼��','����ƽ��ֵ��׼��','���'};
n = [17:-1:15 13:-1:9];
for i = 1:length(n)
    str{i} = num2str(get(obj(n(i)),'String'));
end
a = num2str(get(obj(3),'Value'));
values = {strcat('����',a),str{1:6},strcat(str{7},'��',str{8})};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('����ɹ�','��ʾ','warn');