function subsubpage1_2
clear all;
clc
global obj;

%% ����������
s = get(0,'ScreenSize');% ��ȡ�������Ļ�ֱ���
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','���Ⱦ��Ȳ�������������',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

%% ����ؼ�
% ��������������
t = 1:14;
t_string = {'���ݣ�','����ϵ����','ƽ��ֵ��','��׼�','���ݣ�','ƽ��ֵ��','��׼�','����ƽ��ֵ��׼�',...
            '��Ȩ����ƽ��ֵ��','��Ȩ����ƽ��ֵ��׼�','Ȩ��','�����','��','�������ֲ�ͼ'};
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
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% ���������ı���
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
	warndlg('ȱ�����������');
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
tip = '��1������';
for i=2:(s(1))
	tip = strcat(tip,'|��',num2str(i),'������');
end
set(obj(3),'String',tip);
set(obj(21),'String',data_cell{1});
msgbox('����ɹ�','��ʾ','warn');

function outp(a,b)
global obj;
header = {'����','����ϵ��','ƽ��ֵ','��׼��','�޳��ִ�����ƽ��ֵ','�޳��ִ������׼��',...
          '����ƽ��ֵ��׼��','���ݵ�Ȩ','��Ȩ����ƽ��ֵ','��Ȩ����ƽ��ֵ��׼��','���'};
a = num2str(get(obj(3),'Value'));
n = [20:-1:18 16:-1:9];
for i = 1:length(n)
    str{i} = get(obj(n(i)),'String');
end
values = {strcat('��',a,'������'),str{1:9},strcat(str{10},'��',str{11})};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('����ɹ�','��ʾ','warn');