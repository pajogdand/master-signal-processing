%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function : get_ave
% Input    : img, R, C
% Output   : Get Average
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rlt = get_ave(img, R, C)

rlt = 0;
img = double(img);

for i = 1: R
    for j = 1: C
        rlt = rlt + img(i, j);
    end
end

rlt = rlt / (R * C);