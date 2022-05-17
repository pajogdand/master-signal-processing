%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: isValid
% Input : ppoint, spoint, tr, tc)
% Output : Check if Valid
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rlt = isValid(ppoint, spoint, tr, tc)

rlt = 0;

psDist = getDist(spoint(1), spoint(2), ppoint(1), ppoint(2));
stDist = getDist(spoint(1), spoint(2), tr, tc);

D_Thres = pi / 2;

diff_D = abs(psDist - stDist);

if(diff_D > pi)
    diff_D = 2 * pi - diff_D;
end

if(diff_D > D_Thres)
    rlt = 1;
end