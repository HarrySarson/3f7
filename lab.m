
fid = fopen('hamlet.txt', 'r');
hamlet = fread(fid)';
fclose(fid);

% hamlet = double(upper(char(hamlet)));

[full_p, edges] = histcounts(hamlet, 0:2^8, 'Normalization', 'pdf');

nonzeros = find(full_p);
labels = cellstr(strrep(char(find(full_p) - 1), 'a', '^')')';
p = full_p(nonzeros);



[c, cl] = huffman(full_p);

pty_c = pretty_code(c, cl);

hamlet_bin = vl_encode(hamlet, c, cl, 0:255);
hamlet_decoded = vl_decode(hamlet_bin, c, cl);

assert(isequal(hamlet_decoded, hamlet));

figure;

subplot(2,1,1);
bar(categorical(labels), p');
xtickangle(0);
set(gca,'YScale','log');

subplot(2,1,2);
bar(categorical(labels), [-log2(p'), cl(nonzeros)]);
xtickangle(0);

