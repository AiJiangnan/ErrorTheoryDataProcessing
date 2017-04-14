% 等精度测量线性参数最小二乘法处理
%
% 输入参数：原始数据、置信系数
% 输出参数：剔除粗大误差后数据、剔除粗大误差后残余误差、平均值、...
%                 剔除粗大误差后平均值、标准差、剔除粗大误差后标准差、...
%                 算术平均值标准差、结果
%

function [D,EX,V,V_,s,d_ux] = data_process3(A,L)
B = A';
C = B*A;
D = inv(C);
EX = D*B*L;
V = L-A*EX;
V_ = V'*V;

s = size(A);
n = s(1);
t = s(2);
s = sqrt(V'*V./(n-t));

d = 1:t;
ux = 1:t;
for i = 1:t
    d(i) = D(i,i);
    ux(i) = s*sqrt(d(i));
end
d_ux = [d' ux'];