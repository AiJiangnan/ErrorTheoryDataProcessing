%% ���ĺϳ�
%
% 
% 
% 
% 
% 
% 
% 

function y = error_combination(a,delta)
na = length(a);
nd = length(delta);
if na~=nd
    msgbox('���ݳ��Ȳ�һ����','��ʾ','warn');
    return;
end
y = 0;
for i=1:na
    y = y + a(i)*delta(i);
end