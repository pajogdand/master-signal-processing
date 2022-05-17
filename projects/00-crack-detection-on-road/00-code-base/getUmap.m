function [U, RADII] = getUmap(img, spoint, epoint, w, r_max, TH)

[R, C] = size(img);

U = zeros(R, C);
RADII = zeros(R, C);

img = double(img);

for i = 1: R
    for j = 1: C
        % Get the energy integrated along path from point p0 to p(img(i,j))
        [U(i,j), RADII(i,j)] = getPotential(R, C, img, img(spoint(1), spoint(2)), i, j, w, r_max, TH);
    end
end



