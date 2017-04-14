function subsubpage4_2
clear
clc

%% ����������
hf = figure('Name','���Ⱦ��Ȳ������Բ�����С���˷�����',...
    'NumberTitle','off',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

% ��̬�ı���
t = 1:6;
t_string = {'A:','L:','P:','�м�����','���������','��С���˹��ƽ����'};
t_position = [
    20,420,50,25
    20,290,50,25
    20,160,50,25
    360,420,120,25
    360,290,100,25
    360,160,120,25
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
e = 1:6;
e_position = [
    70,320,260,125
    70,190,260,125
    70,60,260,125
    480,320,200,125
    480,190,200,125
    480,60,200,125
];

for i = 1:length(e)
    e(i) = uicontrol(hf,...
        'Style','edit',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',e_position(i,:),...
        'BackgroundColor','White',...
        'Min',1,'Max',3,...
        'HorizontalAlignment','left');
end
for i = 4:length(e)
    set(e(i),'Enable','inactive');
end

% ��ť
b = [uicontrol(hf,'CallBack',@run1),uicontrol(hf),uicontrol(hf,'CallBack','page_exit')];
b_string = {'����','����','����'};
b_position = [
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

% ����
% obj = findobj(gcf);
% for i = 5:10
%     set(obj(i),'String',i);
% end

function run1(~,~)
obj = findobj(gcf);
A = str2num(get(obj(10),'String'));
L = str2num(get(obj(9),'String'));
P = str2num(get(obj(8),'String'));
[C,D,EX] = data_process4(A,L,P);
set(obj(7),'String',num2str(C));
set(obj(6),'String',num2str(D));
set(obj(5),'String',num2str(EX));