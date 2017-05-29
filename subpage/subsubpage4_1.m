function subsubpage4_1
clear all;
clc

%% ����������
s = get(0,'ScreenSize');% ��ȡ�������Ļ�ֱ���
x = s(3)*0.15;
y = s(4)*0.26;
hf = figure('Name','�Ⱦ��Ȳ������Բ�����С���˷�����',...
    'NumberTitle','off',...
    'Position',[x,y,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

% ��̬�ı���
t = 1:8;
t_string = {'A:','L:','���������','��С���˹��ƽ����','�����������','����ƽ���ͣ�','���β�����׼�','����������Ӧ�ı�׼�'};
t_position = [
    20,420,50,25
    360,420,50,25
    20,290,100,25
    360,290,120,25
    20,160,100,25
    360,160,120,25
    360,130,120,25
    360,100,150,25
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
e = 1:8;
e_tag = {'A','L','inv_esult','result','v_result','v_power','standard','standard_'};
e_position = [
    70,320,280,125
    410,320,280,125
    120,190,230,125
    480,190,210,125
    120,60,230,125
    480,160,210,25
    480,130,210,25
    510,60,180,65
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
for i = 3:length(e)
    set(e(i),'Enable','inactive');
end
set(e(6),'Max',1);
set(e(7),'Max',1);

% ��ť
b = [uicontrol(hf,'CallBack',@run1),uicontrol(hf,'CallBack','page_exit')];
b_string = {'����','����'};
b_position = [
    430,10,80,25
    520,10,80,25
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

guidata(hf,guihandles);

% ���㺯��
function run1(cbo,handles)
handles = guidata(cbo);
A = str2num(get(handles.A,'String'));
L = str2num(get(handles.L,'String'));
if isempty(A)||isempty(L)
	warndlg('ȱ�����������');
	return;
end
[D,EX,V,V_,s,d_ux] = data_process3(A,L);
set(handles.inv_esult,'String',num2str(D));
set(handles.result,'String',num2str(EX));
set(handles.v_result,'String',num2str(V));
set(handles.v_power,'String',num2str(V_));
set(handles.standard,'String',num2str(s));
set(handles.standard_,'String',num2str(d_ux));