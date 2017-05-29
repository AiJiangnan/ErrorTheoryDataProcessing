%% 用逖克逊准则判别粗大误差

function data1 = BlodBig(data)
% 临界值 a = 0.05
r0 = [0 0 0.941 0.765 0.642 0.560 0.507 0.554 0.512 0.447 0.576 0.546 0.521 0.548 0.525 0.507 0.490 0.475 0.462 0.450 0.440 0.430 0.421 0.413 0.406 0.399 0.393 0.387 0.381 0.378];

n = length(data);
data_ = sort(data);
if n<3
    msgbox('数据太少','提示','warn');
    data1 = data;
    return
elseif n>=3 && n<=7
    r = (data_(n)-data_(n-1))/(data_(n)-data_(1));
    r_ = (data_(1)-data_(2))/(data_(1)-data_(n));
elseif n>=8 && n<=10
    r = (data_(n)-data_(n-1))/(data_(n)-data_(2));
    r_ = (data_(1)-data_(2))/(data_(1)-data_(n-1));
elseif n>=11 && n<=13
    r = (data_(n)-data_(n-2))/(data_(n)-data_(2));
    r_ = (data_(1)-data_(3))/(data_(1)-data_(n-1));
else
    r = (data_(n)-data_(n-2))/(data_(n)-data_(3));
    r_ = (data_(1)-data_(3))/(data_(1)-data_(n-2));
end
if r>=r0(n)
    data(data==data_(n)) = [];
elseif r_>=r0(n)
    data(data==data_(1)) = [];
end
data1 = data;