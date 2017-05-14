% 等精度测量数据误差分析
%
% 输入参数：原始数据、置信系数
% 输出参数：剔除粗大误差后数据、剔除粗大误差后残余误差、平均值、...
%                 剔除粗大误差后平均值、标准差、剔除粗大误差后标准差、...
%                 算术平均值标准差、结果
%

function [data1,v1,a,a1,s,s1,s1_x,x] = data_process1(data,t_a)
a = mean(data);
s = std(data);
data1 = BlodBig(data);

a1 = mean(data1);
s1 = std(data1);
n1 = length(data1);
v1 = 1:n1;
for i=1:n1
    v1(i) = data1(i)-a1;
end
s1_x = s1/sqrt(n1);
sigama = t_a*s1_x;
x = roundn([a1 sigama],-3);