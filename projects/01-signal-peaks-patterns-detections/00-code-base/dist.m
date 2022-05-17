%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: dist
% Input : p1, p1
% Output : rlt
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rlt = dist(p1, p2)

rlt = (p1(1) - p2(1)) * (p1(1) - p2(1));
rlt = rlt + (p1(2) - p2(2)) * (p1(2) - p2(2));
rlt = sqrt(rlt);