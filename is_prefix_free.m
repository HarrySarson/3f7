function [ is_prefix_free ] = is_prefix_free( c, cl )
%IS_PREFIX_FREE test if code is prefix free.

    is_prefix_free = true;
    
    [lengths, indices] = sort(cl);
    
    codes = c(indices, :);
    
    l = length(lengths);
    
    for i = 1:l-1
        codeword_length = lengths(i);
        if (codeword_length > 0)
            code = codes(i, 1:codeword_length);
            for j = i+1:l
                if (code == codes(j, 1:codeword_length))
                   is_prefix_free = false;
                   return;
                end
            end
        end
    end
    
    
    
    

end

