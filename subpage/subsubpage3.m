function subsubpage3
clear
clc

%% ����������
hf = figure('Name','������ȷ����',...
    'NumberTitle','off',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

% ���
uipanel(...
    'Title','��ȷ���ȱ���',...
    'FontSize',10,...
	'FontName','΢���ź�',...
    'Units','pixels',...
    'Position',[20,70,660,230],...
    'BackgroundColor','White');

% ��ȷ����
t = 1:18;
for i = 1:length(t)
    t(i) = uicontrol(hf);
end
t_string = {'���ݣ�','u1:','u2:','u3:','v1:','v2:','v3:',...
    'V:','u_c:','v:','�ϳɱ�׼��ȷ���ȣ�','չ�첻ȷ���ȣ�',...
    'V:','��','P:','v:','���Ÿ��ʣ�','�������ӣ�'};
t_position = [
    20,420,50,25
    20,370,50,25
    20,340,50,25
    20,310,50,25
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
    set(t(i),...
        'Style','text',...
        'String',t_string(i),...
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% ��ȷ�����ı���
e = 1:16;
for i = 1:length(e)
    e(i) = uicontrol(hf);
end
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
    set(e(i),...
        'Style','edit',...
        'FontName','΢���ź�',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'BackgroundColor','White');
    % set(e(i),'String',i);
end
for i = 10:length(e)
    set(e(i),'Enable','inactive');
end
set(e(1),'Min',1,'Max',3);

% ��ť
b = [uicontrol(hf,'CallBack',@imp),uicontrol(hf,'CallBack',@run1),uicontrol(hf,'CallBack',@outp),uicontrol(hf,'CallBack','page_exit')];
b_string = {'����','����','����','����'};
b_position = [20,400,50,25
              410,20,80,25
              500,20,80,25
              590,20,80,25];
                 
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
    'Position',[310,20,80,25],...
    'String','����',...
	'Value',1,...
	'CallBack',@data_cho,...
	'UserData',1,...
    'FontSize',10);

% obj = findobj(gcf);
% for i = 7:22
%     set(obj(i),'String',i);
% end

function data_cho(~,~)
global data_cell;
obj = findobj(gcf);
val = get(obj(2),'Value');
set(obj(22),'String',data_cell{val});

function imp(~,~)
global data_cell;
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
tip_num = 1;
for i=2:(s(1))
	tip = strcat(tip,'|��',num2str(i),'������');
	tip_num = [tip_num,i];
end
obj = findobj(gcf);
set(obj(2),'String',tip);
set(obj(2),'UserData',tip_num);
set(obj(22),'String',data(1,:));
msgbox('����ɹ�','��ʾ','warn');

function run1(~,~)
obj = findobj(gcf);
for i = 14:22
    s = str2num(get(obj(i),'String'));
    if isempty(s)
	    warndlg('ȱ�����������');
	    return;
    end
end

x = str2num(get(obj(22),'String'));
P = str2num(get(obj(21),'String'));
k = str2num(get(obj(20),'String'));
u1 = str2num(get(obj(19),'String'));
u2 = str2num(get(obj(18),'String'));
u3 = str2num(get(obj(17),'String'));
v1 = str2num(get(obj(16),'String'));
v2 = str2num(get(obj(15),'String'));
v3 = str2num(get(obj(14),'String'));
u = [u1 u2 u3];
v = [v1 v2 v3];

[V_,u_c,v_,U,P_] = uncertainty(x,u,v,P,k);

set(obj(13),'String',V_);
set(obj(12),'String',u_c/1000000);
set(obj(11),'String',v_);
set(obj(10),'String',V_);
set(obj(9),'String',U/1000000);
set(obj(8),'String',P_);
set(obj(7),'String',v_);

function outp(~,~)
% obj = findobj(gcf);
% header = {'����','����ϵ��','ƽ��ֵ','��׼��','�޳��ִ�����ƽ��ֵ','�޳��ִ������׼��','����ƽ��ֵ��׼��','���'};
% a = num2str(get(obj(3),'Value'));
% b = num2str(get(obj(17),'String'));
% c = num2str(get(obj(16),'String'));
% d = num2str(get(obj(15),'String'));
% e = num2str(get(obj(13),'String'));
% f = num2str(get(obj(12),'String'));
% g = num2str(get(obj(11),'String'));
% h = num2str(get(obj(10),'String'));
% i = num2str(get(obj(9),'String'));
% values = {strcat('����',a),b,c,d,e,f,g,strcat(h,'��',i)};
xlswrite(strcat(datestr(now,30),'.xls'),[header;values]);
msgbox('����ɹ�','��ʾ','warn');