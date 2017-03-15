function subpage
clear
clc

%% ����������
hf = figure('Name','����GUI��������������ݴ���ϵͳ',...
    'NumberTitle','off',...
    'Units','pixels',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

%% ��������˵�
%����������
t = [uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf),uicontrol(hf)];
menu_string = {'�������ݻ�������','���ĺϳ�','������ȷ����','��С���˷�����','�ع����','����'};
menu_position = [0,240,230,25
                            240,240,230,25
                            480,240,230,25
                            0,10,230,25
                            240,10,230,25
                            480,10,230,25];
%����ͼƬ��
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
%��������������
for i = 1:length(t)
    set(t(i),...
        'Style','text',...
        'String',menu_string(i),...
        'FontName','΢���ź�',...
        'FontSize',14,...
        'FontWeight','bold',...
        'enable','inactive',...
        'Units','pixels',...
        'Position',menu_position(i,:),...
        'ButtonDownFcn',strcat('subsubpage',num2str(i)));
end
%����ͼƬ������
for i = 1:length(p)
    set(p(i),...
        'Units','pixels',...
        'Position',axes_position(i,:));
end

% ͼƬ����ʾ��ͼ
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