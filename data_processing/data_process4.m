% ���Ⱦ��Ȳ������Բ�����С���˷�����
%
% ���������A��L��P
% ����������м����������������С���˷����ƽ��
%

function [C,D,EX] = data_process4(A,L,P)
C  = A'*P*A;
D  = inv(C);
EX = D*A'*P*L;
C  = roundn(C,-4);
D  = roundn(D,-4);
EX = roundn(EX,-4);