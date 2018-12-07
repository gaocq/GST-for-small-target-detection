function result = reviseImageBoundary(I, dw)
% set the image boundary to 0
[m n] = size(I);
I = double(I);
result = zeros(m, n);
result(dw:m-dw, dw:n-dw) = I(dw:m-dw, dw:n-dw);