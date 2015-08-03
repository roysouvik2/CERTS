function val = coeff(r)
if (r == 0)
    val = 1/(0.5*1.5);
else
    val = ((r+1)^1.5-2*r^1.5+(r-1)^1.5)/(0.5*1.5);
end