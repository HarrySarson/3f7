function [c,cl] = huffman_algorithm(p)
% huffman(p) implements the Huffman algorithm to determine the optimal
% prefix-free code for a random variable with probability distribution p.
% The input vector p must consist of non-negative numbers that sum to 1.
% The output is a tree in matrix form, each row is a node in the tree and
% the entries in a row are the "children" of the node. The first length(p)
% nodes are leaves (corresponding to the source alphabet) and the last node
% in the list is the root.
%
% Copyright Jossy Sayir, 2016

nz =find(p); % for now provide codewords only for non-zero probabilities
p_orig = p; % (we will introduce zero-length codewords for other symbols
p = p(nz); % at the end)


% The Huffman algorithm operates on two data structure:
% - a tree, built up by the algorithm
% - a list of probabilities and associated tree nodes 
%   (represented as an nx2 matrix where the first column contains the
%   probabilities and the second colum the index of the associated nodes)


% get length of input probability vector
n = length(p);
% initialise tree to the all-zero vector of length n, i.e.,
% one tree leaf per possible source symbol, all leaves are orphans for the
% moment until the algorithm connects them to the tree
t = zeros(1,n);
% replace the probability vector by a matrix with probabilities in its left
% column and the index of the corresponding tree nodes on the right
p = [p(:) (1:n)'];

%%%%%%%%%%%%%%%%%%%%%%%
% HUFFMAN ALGORITHM  %%
%%%%%%%%%%%%%%%%%%%%%%%
while (size(p,1) > 1) % while there are at least 2 probs in the list
    [pp,ii] = sort(p(:,1)); % sort the probabilities
    % re-order the probabilities cum index by order of increasing probs
    p = p(ii,:); 
    
    
    % 1) add a new "orphan" node to the end of the tree t (value 0)
    t(end+1) = 0;
    new_length = length(t);
    
    % 2) make this new node the parent of the two nodes with the smallest    
    % probabilities 
    t(p(1, 2)) = new_length;
    t(p(2, 2)) = new_length;
    
    % 3) replace the two smallest nodes in the "p" matrix by their new
    % parent nodes: for example, keep the second row of p and replace its
    % first entry by the sum of the two previous smallest probabilities,
    % and its second entry by the index of the new node you have created in
    % the tree, and then remove row 1 of p.
    
    p(2, :) = [p(1, 1) + p(2, 1), new_length];
    p = p(2 : end, :);
    
end

[c_nz,cl_nz] = tree2code(t);

% now introduce zero length codewords for zero probability symbols
cl = zeros(length(p_orig),1);
c = zeros(length(p_orig),size(c_nz,2));
cl(nz) = cl_nz;
c(nz,:) = c_nz;

return;


