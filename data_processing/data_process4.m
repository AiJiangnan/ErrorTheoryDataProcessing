% 不等精度测量线性参数最小二乘法处理
%
% 输入参数：A、L、P
% 输出参数：中间结果、逆矩阵结果、最小二乘法估计结果
%

function [C,D,EX] = data_process4(A,L,P)
C = A'*P*A;
D = inv(C);
EX = D*A'*P*L;