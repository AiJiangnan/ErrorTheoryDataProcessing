%% 测量不确定度
%
%
% 
% 
% 
% 
% 
% 

function [V_,u_c,v_,U,P_] = uncertainty(V,u,v,P,k)
V_ = mean(V);
u_c = roundn(sqrt(u(1)^2+u(2)^2+u(3)^3),0);
v_ = floor((u_c^4)/((u(1)^4)/v(1)+(u(2)^4)/v(2)+(u(3)^4)/v(3)));
U = ceil(k*u_c);
P_ = P;