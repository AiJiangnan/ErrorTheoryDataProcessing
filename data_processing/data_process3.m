% 等精度测量线性参数最小二乘法处理
%
% 输入参数：A、L
% 输出参数：逆矩阵结果、最小二乘法估计结果、残余误差结果、...
%          残余平方和、单次测量的标准差、待估计量相应的标准差
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