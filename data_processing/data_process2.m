% ���Ⱦ��Ȳ�������������
%
% ���������ԭʼ���ݡ�����ϵ��
% ����������޳��ִ��������ݡ��޳��ִ����������ƽ��ֵ��...
%                 �޳��ִ�����ƽ��ֵ����׼��޳��ִ������׼�...
%                 ����ƽ��ֵ��׼����
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

% p1 = 1/()% ��û���������
x = 1;