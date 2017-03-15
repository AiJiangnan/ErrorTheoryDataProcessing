% 不等精度测量数据误差分析
%
% 输入参数：原始数据、置信系数
% 输出参数：剔除粗大误差后数据、剔除粗大误差后残余误差、平均值、...
%                 剔除粗大误差后平均值、标准差、剔除粗大误差后标准差、...
%                 算术平均值标准差、结果
%

function [data1,v2,a1,a2,s1,s2,s2_x,x] = data_process2(data,t_a)
a1 = mean(data);
n1 = length(data);
s1 = std(data);
data1 = data;
a2 = mean(data1);
n2 = length(data1);
v2 = 1:n2;
for i=1:n2
    v2(i) = data1(i)-a2;
end
s2 = std(data1);

s2_x = s2/sqrt(n2);

% p1 = 1/()% 还没解决的问题
x = 1;