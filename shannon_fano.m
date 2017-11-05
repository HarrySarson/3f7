function [c,cl] = shannon_fano(p)
% shannon_fano(p) computes the Shannon-Fano code based
% on the probabilities p. 
%
% Copyright Jossy 2016

% THIS IS A "SHELL" FUNCTION ONLY WHOSE ROLE IS TO CHECK THE INPUTS, SORT
% THE PROBABILITIES AND GET RID OF ZERO PROBABILITIES BEFORE CALLING THE
% "REAL" SHANNON-FANO FUNCTION SF FURTHER DOWN. SCROLL DOWN TO THE SF
% FUNCTION AND COMPLETE IT.

% check format and validity of input
if (nargin ~= 1 || abs(sum(p)-1.0) > 1e-5 || any(p<0))
    error('Argument of shannon_fano must be a probability ditribution');
end

% there may be zero probabilities. These will just be ignored and no
% codeword provided for them.
p = p(:); % turns p into a column vector if not already
np = length(p);
[ps, index] = sort(p, 'descend');
nz = find(ps); % first nz indexed probabilities are non-zero

% call the true Shannon Fano function
[cnz, clnz] = sf(ps(nz));

cl = zeros(np,1);
c = zeros(np, max(clnz));

% assign the codewords found for symbols of non-zero probability
cl(index(nz)) = clnz;
c(index(nz),:) = cnz;

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%   SHANNON-FANO CODE: PLEASE COMPLETE THIS FUNCTION                   %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c, cl] = sf(p)
% This internal Shannon-Fano function assumes that its input probability
% vector is sorted in decreasing order and doesn't contain any zero
% probabilities.
%
% Copyright Jossy 2016

% compute the codeword lengths for the Shannon-Fano code
cl = ceil(-log2(p));


% 1) COMPUTE THE CUMULATIVE DISTRIBUTION f FROM p

f = cumsum(vertcat(0, p));

f = f(1:end-1);

% 2) CONVERT THE CUMULATIVE PROBABILITIES TO BINARY 

max_codeword_length = max(cl);
c = zeros(length(f), max_codeword_length);

for i = 1:length(f)
    initial_length = max_codeword_length + 1;
    codeword = int8(dec2bin(round(f(i) * 2^initial_length), initial_length)) - '0';
    codeword = codeword(1:cl(i));
    c(i, :) = [codeword zeros(1, max_codeword_length - cl(i))];
end


% Note that steps 2 and 3 could in principle be done as one, but there is a
% danger that the "round" operation may yield the wrong last digit. It is
% recommended to round at a higher precision than the maximum codeword
% length and then truncate the table to the maximum codeword length in a
% separate step.


return;
