
clc
t=[0,1,2,3,4];
global a;
global y;
y = [0.129 * 10^8, 0.157 * 10^8, 0.317 * 10^8, 0.624 * 10^8, 1.380 * 10^8];
a0=[0.1];
[X,RESNORM]=lsqcurvefit(@diff_growth_rate_MR13,a0,t,y)
