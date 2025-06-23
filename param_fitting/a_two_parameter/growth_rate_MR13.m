
function dp = growth_rate_MR13(t,p)
dp = zeros(1,1);
global a;
C_max = 10^10;%carring capacity for cancer cells
dp(1)= a.*p(1).* (1-(p(1))./C_max);%diffrential equation for dynamics of resistant subpopulation of cancer cells to MTX
end
