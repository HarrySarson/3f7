function [ res ] = pretty_code( c, cl  )
%PRETTY_CODE returns a pretty to view verson of code

    res = strings(length(c), 1);
    
    for i = 1:length(res)
       res(i) = strjoin(string(c(i, 1:cl(i))));
    end

end

