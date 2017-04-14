% �Ⱦ��Ȳ������Բ�����С���˷�����
%
% ���������A��L
% ��������������������С���˷����ƽ���������������...
%          ����ƽ���͡����β����ı�׼�����������Ӧ�ı�׼��
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