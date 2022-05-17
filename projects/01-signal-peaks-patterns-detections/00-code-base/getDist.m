%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function : getDist
% Input    : r1, c1, r2, c2
% Output   : Get distance between two point
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rlt = getDist(r1, c1, r2, c2)

dr = r2 - r1;
dc = c2 - c1;
if(dc == 0 && dr == 0)
    rlt = 0; return;
end

if(dc == 0)
    if(dr > 0)
        rlt = pi * 1.5;
    else
        rlt = pi / 2;
    end
elseif(dr == 0)
    if(dc > 0)
        rlt = 0;
    else
        rlt = pi;
    end
else    
    rlt = atan2(abs(dr), abs(dc));
    if(dc > 0)
        if(dr > 0)
            rlt = 2 * pi - rlt;
        else
            rlt = rlt;
        end
    else
        if(dr > 0)
            rlt = pi + rlt;
        else
            rlt = pi - rlt;
        end
    end   
    
end
    

    