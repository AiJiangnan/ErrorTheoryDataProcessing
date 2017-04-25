% ���Ⱦ��Ȳ�������������
%
% ���������ԭʼ���ݡ�����ϵ��
% ����������޳��ִ��������ݡ��޳��ִ����������ƽ��ֵ��...
%                 �޳��ִ�����ƽ��ֵ����׼��޳��ִ������׼�...
%                 ����ƽ��ֵ��׼����ݵ�Ȩ����Ȩ����ƽ��ֵ��...
%                 ��Ȩ����ƽ��ֵ��׼����
%

function [data1,v2,a1,a2,s1,s2,s2_x,p,x_,s_x_,x] = data_process2(data,t_a)
s = size(data);
for i = 1:s(1)
    a1(i) = mean(data{i});
    s1(i) = std(data{i});
    data1{i} = BlodBig(data{i});
end

for i = 1:s(1)
    a2(i) = mean(data1{i});
    s2(i) = std(data1{i});
    s2_x(i) = s2(i)/sqrt(length(data1{i}));
end
% �в�
n2 = size(data1);
for i=1:n2(2)
    a = [];
    b = data1{i};
    for j=1:length(b)
        a(j) = b(j)-a2(i);
    end
    v2{i} = a;
end
% Ȩ
for i = 1:s(1)
    p(i) = 1/(s2_x(i)*s2_x(i));
end
% ��Ȩ����ƽ��ֵ
[x_,s_x] = jiaquan(p,a2);
s_x_ = s2_x(1)*s_x;

sigama = t_a*s_x_;
x = roundn([x_ sigama],-3);

function [x_,s_x_] = jiaquan(p,x_)
n = length(p);
s1 = 0;
s2 = 0;
for i = 1:n
    s1 = s1+p(i)*x_(i);
    s2 = s2+p(i);
end
x_ = s1/s2;
s_x_ = sqrt(p(1)/s2);