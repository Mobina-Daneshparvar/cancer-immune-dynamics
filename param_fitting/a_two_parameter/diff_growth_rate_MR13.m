
function V = diff_growth_rate_MR13(x,xdata)
global a;
a = x;
global y;
z=ode45(@growth_rate_MR13,[0 4],0.129 * 10^8);
V=interp1(z.x,z.y,xdata);
end