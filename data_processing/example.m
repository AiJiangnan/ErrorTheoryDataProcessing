% 1-适应不同分辨率的电脑                               [1]
% 2-有必要的通知对话框                                 [0]
% 3-粗大误差处理算法                                   [0]
% 4-用循环来创建控件                                   [1]
% 5-退出确认窗口提示再次_bug                           [0]
% 6-axes控件为何放在控件最后才能更新                    [0]

cl
t = 1/30:1/30:14/30;
s = [11.86 15.67 20.60 26.69 33.71 41.93 51.13 61.49 72.90 85.44 99.08 113.77 129.54 146.48];

[p,S]=polyfit(t,s,2)
Y = polyconf(p,t,S)
plot(t,s,'k+',t,Y,'r')

% I = [ones(14,1) t' (t.^2)'];
% [b,bint,r,rint,stats]=regress(s',I);
% Y = polyval(b(end:-1:1),t);
% plot(t,s,'k+',t,Y,'r')