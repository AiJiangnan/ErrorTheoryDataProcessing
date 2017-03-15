function subpage
clear
clc

%% 创建主界面
hf = figure('Name','基于GUI的误差理论与数据处理系统',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% 更改界面左上角图标
icon;

%% 二级界面菜单
%创建文字项
t = [uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf)];
menu_string = {'测量数据基本处理','误差的合成','测量不确定度','最小二乘法处理','回归分析','返回'};
menu_position = [0,240,230,25
                            240,240,230,25
                            480,240,230,25
                            0,10,230,25
                            240,10,230,25
                            480,10,230,25];
%创建图片项
p1 = axes('CreateFcn',@plot1);
p2 = axes('CreateFcn',@plot2);
p3 = axes('CreateFcn',@plot3);
p4 = axes('CreateFcn',@plot4);
p5 = axes('CreateFcn',@plot5);
p = [p1,p2,p3,p4,p5];
axes_position = [50,290,150,150
                          290,290,150,150
                          530,290,150,150
                          50,60,150,150
                          290,60,150,150];
%设置文字项属性
for i = 1:length(t)
    set(t(i),...
        'Style','text',...
        'String',menu_string(i),...
        'FontName','微软雅黑',...
        'FontSize',14,...
        'FontWeight','bold',...
        'enable','inactive',...
        'Units','pixels',...
        'Position',menu_position(i,:),...
        'ButtonDownFcn',strcat('subsubpage',num2str(i)));
end
%设置图片项属性
for i = 1:length(p)
    set(p(i),...
        'Units','pixels',...
        'Position',axes_position(i,:));
end

% 图片项显示绘图
function plot1(~,~)
bar([2,1,3,5,3]);

function plot2(~,~)
imshow('image/photo_2.jpg');

function plot3(~,~)
imshow('image/photo_3.jpg');

function plot4(~,~)
x = 0:0.1:1;
y = [-0.447,1.978,3.28,6.16,7.08,7.34,7.66,9.56,9.48,9.3,11.2];
plot(x,y,'k.','markersize',12);
hold on;
axis([0 1.3 -2 16]);
p3 = polyfit(x,y,3);
t=0:0.1:1.2;
s3=polyval(p3,t);
plot(t,s3,'r');

function plot5(~,~)
imshow('image/photo_1.jpg');