%% 误差的合成
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
    msgbox('数据长度不一样！','提示','warn');
    return;
end
y = 0;
for i=1:na
    y = y + a(i)*delta(i);
end