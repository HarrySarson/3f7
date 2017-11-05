n=207039;
lo=0.0;
hi=1.0;

for k = 1:n
    range = hi-lo;
    hi = lo + range * sum(full_p(1:(hamlet(k)+1)));
    lo = lo + range * sum(full_p(1:hamlet(k)));
end
