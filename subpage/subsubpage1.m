function subsubpage1
clear
clc

%% ����������
hf = figure('Name','�������ݻ�������',...
    'NumberTitle','off',...
    'Position',[200,200,710,450],...
    'MenuBar','none',...
    'Color','White',...
    'Resize','off');

% ���Ľ������Ͻ�ͼ��
icon;

%% �Ⱦ��Ȳ�������������
axes('Units','pixels',...
    'Position',[0,70,350,400],...
    'CreateFcn',@plot1);
uicontrol(hf,...
    'Style','text',...
    'String','�Ⱦ��Ȳ�������������',...
    'FontSize',16,...
    'FontWeight','bold',...
    'enable','inactive',...
    'ButtonDownFcn','subsubpage1_1',...
    'Position',[0,30,300,25]);

%% ���Ⱦ��Ȳ�������������
axes('Units','pixels',...
    'Position',[300,70,400,400],...
    'CreateFcn',@plot2);
uicontrol(hf,...
    'Style','text',...
    'String','���Ⱦ��Ȳ�������������',...
    'FontSize',16,...
    'FontWeight','bold',...
    'enable','inactive',...
    'ButtonDownFcn','subsubpage1_2',...
    'Position',[310,30,300,25]);

%% ����
uicontrol(hf,...
    'Style','text',...
    'String','����',...
    'FontSize',16,...
    'FontWeight','bold',...
    'enable','inactive',...
    'ButtonDownFcn','page_exit',...
    'Position',[620,30,90,25]);

function plot1(~,~)
[I,~,alpha] = imread('image/photo_1_1.png');
h = imshow(I);
set(h,'AlphaData',alpha);

function plot2(~,~)
[I,~,alpha] = imread('image/photo_1_2.png');
h = imshow(I);
set(h,'AlphaData',alpha);