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
if (nargin ~= 1 | abs(sum(p)-1.0) > 1e-5 | ~isempty(find(p<0)))
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
% PLEASE COMPLETE
cl = ceil(-log(p)/log(2));

% You now have two options: either construct the extended tree with the
% given codeword lengths from the root, or use Shannon's method
% PLEASE DELETE THE OPTION YOU ARE NOT PURSUING.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPTION 1: CONSTRUCT TREE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hints: 
% 1) start with a tree xt consisting only of a root (a column of 3 zeros)
% 2) initialise a variable to hold the "current" node (initially 1), the
% current tree depth (initially zero), and the next codeword that needs to
% be assigned a leaf (initially 1)
% 3) start an infinite loop (this will be broken once the last codeword is
% assigned
% 4) check if the current node has any unassigned (zero) children
% 5) if not, move one level up the tree (don't forget to update the node
% AND the tree depth) and use the command "continue" to return to the start
% of the infinite loop
% 6) pick the first unassigned child, create a new node at the end of the
% tree and assign that node as a new child and the current node as its
% parent, then move to the new node (not forgetting to update the depth)
% 7) check if there is a need for a codeword whose length is the new depth
% 8) if there is AND it is the LAST codeword that needed assigning, break
% the infinite loop
% 9) otherwise, if there is a need for a codeword at this depth, simply
% crawl back up to the current node's parent. The node you've just left
% will never be visited again and will hence become a leaf. Update the
% codeword counter.
% 10) convert from xt to a code table

% COMPLETE STEPS 1 to 10 HERE
% 
% 
% 
%
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPTION 2: SHANNON'S METHOD %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1) COMPUTE THE CUMULATIVE DISTRIBUTION f FROM p
% 2) CONVERT THE CUMULATIVE PROBABILITIES TO BINARY 
% 3) TRUNCATE RESULTING CODE TABLE TO LENGTH OF LONGEST CODEWORD

% Note that steps 2 and 3 could in principle be done as one, but there is a
% danger that the "round" operation may yield the wrong last digit. It is
% recommended to round at a higher precision than the maximum codeword
% length and then truncate the table to the maximum codeword length in a
% separate step.

% COMPLETE STEPS 1 to 3 HERE
%
%
%

return;
