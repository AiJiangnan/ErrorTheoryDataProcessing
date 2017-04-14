function subsubpage4_1
clear
clc

%% 创建主界面
hf = figure('Name','等精度测量线性参数最小二乘法处理',...
    'NumberTitle','off',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

% 静态文本框
t = 1:8;
t_string = {'A:','L:','逆矩阵结果：','最小二乘估计结果：','残余误差结果：','残余平方和：','单次测量标准差：','待估计量相应的标准差：'};
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
        'FontName','微软雅黑',...
        'HorizontalAlignment','left',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',t_position(i,:),...
        'BackgroundColor','White');
end

% 文本框
e = 1:8;
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
        'Min',1,'Max',3,...
        'HorizontalAlignment','left');
end
for i = 3:length(e)
    set(e(i),'Enable','inactive');
end
set(e(6),'Max',1);
set(e(7),'Max',1);

% 按钮
b = [uicontrol(hf,'CallBack',@run1),uicontrol(hf),uicontrol(hf,'CallBack','page_exit')];
b_string = {'计算','保存','返回'};
b_position = [
    430,10,80,25
    520,10,80,25
    610,10,80,25
];

for i = 1:length(b)
    set(b(i),...
        'Style','pushbutton',...
        'String',b_string(i),...
        'FontName','微软雅黑',...
        'FontSize',10,...
        'Units','pixels',...
        'Position',b_position(i,:));
end
% 测试
% obj = findobj(gcf);
% for i = 5:12
%     set(obj(i),'String',i);
% end

function run1(~,~)
obj = findobj(gcf);
A = str2num(get(obj(12),'String'));
L = str2num(get(obj(11),'String'));
[D,EX,V,V_,s,d_ux] = data_process3(A,L);
set(obj(10),'String',num2str(D));
set(obj(9),'String',num2str(EX));
set(obj(8),'String',num2str(V));
set(obj(7),'String',num2str(V_));
set(obj(6),'String',num2str(s));
set(obj(5),'String',num2str(d_ux));