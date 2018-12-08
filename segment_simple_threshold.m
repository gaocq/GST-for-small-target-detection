function bw = segment_simple_threshold(I)
% use simple threshold to segment the image
T_min = 0.000002;
T = max(T_min, 0.4 * max(I(:)));
bw = uint8( 255 * (I>T) );