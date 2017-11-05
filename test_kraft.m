function [ fullfills_kraft, summation ] = test_kraft( cl )

    summation = sum(2 .^ -cl);
    
    fullfills_kraft = summation <= 1;
end
