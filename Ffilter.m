function h = Ffilter(n,sigma, filterSize)
% compute the symmetry derivative filter of 2D Gaussian"
mdpt = ceil(filterSize/2);
[x y] = meshgrid(-mdpt:mdpt, -mdpt:mdpt);
if n > 0
    h = (-1/(sigma*sigma))^n /(2*pi*sigma*sigma) * ...
        (x+i*y).^n .* exp(-(x.*x+y.*y)/(2*sigma*sigma));
else
    n = -n;
    h = (-1/(sigma*sigma))^n /(2*pi*sigma*sigma) * ...
        (x-i*y).^n .* exp(-(x.*x+y.*y)/(2*sigma*sigma));
end
h = h/sum(abs(h(:)));
