%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function : isEndPoint
% Input    : r, c, av, tav, randa, R, C
% Output   : Check if it is last poing on curve
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rlt = isEndPoint(r, c, av, tav, randa, R, C)

    rlt = 0;

    delta = randa / 2;
    d_ratio = 0.8;
    
    if(r < delta || c < delta || r > R - delta || c > C - delta)
        rlt = 1;
        return;
    end
    
    if(av > tav * d_ratio)
        rlt = 1;
        return;
    end



end