function subsubpage5
clear all;
clc

%% ����������
s = get(0,'ScreenSize');% ��ȡ�������Ļ�ֱ���
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','�ع����',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Tag','figure',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

% ��̬�ı���
t = 1:5;
t_string = {'x:','y:','n�ζ���ʽ��ϣ�','�в���������','��Ͻ����'};
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
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% �ı���
e = 1:2;
e_tag = {'x','y'};
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
        'Tag',e_tag{i},...
        'Min',1,'Max',3,...
        'HorizontalAlignment','left');
end

uicontrol(hf,...
    'Style','popup',...
    'Position',[130,360,100,25],...
    'String','1|2|3|4|5|6|7|8',...
	'Value',2,...
    'Tag','list',...
    'FontSize',10,...
    'BackgroundColor','White');

% ��ť
b = [uicontrol(hf,'CallBack',@imp),...
     uicontrol(hf,'CallBack',@run1),...
     uicontrol(hf,'CallBack',@outp),...
     uicontrol(hf,'CallBack','page_exit')];
b_string = {'����','����','����','����'};
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
        'FontName','΢���ź�',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',b_position(i,:));
end

axes('Units','pixels',...
    'Position',[30,60,300,260],...
    'Tag','v_axes',...
    'Box','on');

axes('Units','pixels',...
    'Position',[370,60,300,260],...
    'Tag','r_axes',...
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
set(handles.x,'String',data(1,:));
set(handles.y,'String',data(2,:));
msgbox('����ɹ�','��ʾ','warn');

% ���㺯��
function run1(cbo,handles)
handles = guidata(cbo);
x = str2num(get(handles.x,'String'));
y = str2num(get(handles.y,'String'));
l = size(x);
if l(1)>1
    x = x';
    y = y';
end
n = get(handles.list,'Value');
if isempty(x)||isempty(y)
	warndlg('ȱ�����������');
	return;
end
I = ones(length(x),1);
for i=1:n
    b = x.^i;
    I = [I b'];
end
[b,bint,r,rint,stats]=regress(y',I);
axes(handles.v_axes);
rcoplot(r,rint);
title('');
xlabel('');
ylabel('');
Y = polyval(b(end:-1:1),x);
axes(handles.r_axes);
plot(x,y,'k+',x,Y,'r');

% �������ݺ���
function outp(cbo,handles)
handles = guidata(cbo);
f1 = getframe(handles.v_axes);
f2 = getframe(handles.r_axes);
imwrite(f1.cdata,'�в�������.jpg','jpg')
imwrite(f2.cdata,'��Ͻ��.jpg','jpg')
msgbox('����ͼ��ɹ�','��ʾ','warn');