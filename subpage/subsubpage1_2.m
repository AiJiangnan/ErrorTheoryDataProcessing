function subsubpage1_2
clear
clc

%% ����������
hf = figure('Name','���Ⱦ��Ȳ�������������',...
    'NumberTitle','off',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

%% ����ؼ�
%��������������(11)
t = [uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf)];
ui_string = {'���ݣ�','����ϵ����','ƽ��ֵ��','��׼�','���ݣ�','ƽ��ֵ��','��׼�','����ƽ��ֵ��׼�','�����','��','�������ֲ�ͼ'};
ui_position = [20,405,80,25%L1
                      20,350,80,25%L2
					  20,320,80,25%L2
                      20,290,80,25%L3
					  380,395,80,25%R1
                      380,340,80,25%R2
					  380,310,80,25%R3
                      20,260,130,25%L4
                      20,10,130,25%B1
                      205,10,10,25%B2
                      550,250,150,20];%R4

for i = 1:length(t)
    set(t(i),...
        'Style','text',...
        'String',ui_string(i),...
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',ui_position(i,:),...
        'BackgroundColor','White');
end

% ���������ı���(10)
e = [uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf)];
e_position = [100,380,240,50%L1
                     100,350,240,25%L2
					 100,320,240,25%L2
                     100,290,240,25%L3
                     450,370,240,50%R1
                     450,340,240,25%R2
                     450,310,240,25%R3
                     160,260,180,25%L4
                     100,10,100,25%B1
                     220,10,100,25];%B2

for i = 1:length(e)
    set(e(i),...
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
b = [uicontrol(hf,'CallBack',@imp),uicontrol(hf,'CallBack',@run1),uicontrol(hf,'CallBack',@outp),uicontrol(hf,'CallBack','page_exit')];
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
	'UserData',1,...
    'FontSize',10);

axes('Units','pixels',...
        'Position',[30,60,650,190],...
        'Box','on',...
        'Tag','axes');

function data_cho(~,~)
global data_cell;
obj = findobj(gcf);
val = get(obj(3),'Value');
set(obj(18),'String',data_cell{val});

function run1(~,~)
obj = findobj(gcf);
s1 = str2num(get(obj(18),'String'));
s2 = str2num(get(obj(17),'String'));
if isempty(s1)||isempty(s2)
	warndlg('ȱ�����������');
	return;
end

[data1,v1,a,a1,s,s1,s1_x,x] = data_process1(s1,s2);

axes(obj(2));
plot(v1,'-o');

set(obj(16),'String',a);
set(obj(15),'String',s);
set(obj(14),'String',data1);
set(obj(13),'String',a1);
set(obj(12),'String',s1);
set(obj(11),'String',s1_x);
set(obj(10),'String',x(1));
set(obj(9),'String',x(2));

function imp(~,~)
global data_cell;
[FileName,PathName,FilterIndex] = uigetfile(...
    {'*.txt','Text Data Files(*.txt)';...
     '*.xls','Excel ������(*.xls)'});
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
tip_num = 1;
for i=2:(s(1))
	tip = strcat(tip,'|����',num2str(i));
	tip_num = [tip_num,i];
end
obj = findobj(gcf);
set(obj(3),'String',tip);
set(obj(3),'UserData',tip_num);
set(obj(18),'String',data(1,:));

function outp(~,~)
obj = findobj(gcf);
header = {'����','����ϵ��','ƽ��ֵ','��׼��','�޳��ִ�����ƽ��ֵ','�޳��ִ������׼��','����ƽ��ֵ��׼��','���'};
a = num2str(get(obj(3),'Value'));
b = num2str(get(obj(17),'String'));
c = num2str(get(obj(16),'String'));
d = num2str(get(obj(15),'String'));
e = num2str(get(obj(13),'String'));
f = num2str(get(obj(12),'String'));
g = num2str(get(obj(11),'String'));
h = num2str(get(obj(10),'String'));
i = num2str(get(obj(9),'String'));
values = {strcat('����',a),b,c,d,e,f,g,strcat(h,'��',i)};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('����ɹ�','��ʾ','warn');