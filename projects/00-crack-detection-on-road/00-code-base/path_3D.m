function [rlt] = path_3D(R, C, img, spoint, epoint, U_A, R_A)

EPS = 10;
chk = zeros(R, C);
len = 0;

dr = [0, -1, -1, -1, 0, 1, 1, 1];
dc = [-1, -1, 0, 1, 1, 1, 0, -1];

% dr = [0, -1, 0, 1];
% dc = [-1, 0, 1, 0];
eu = U_A(epoint(1), epoint(2));
cr = epoint(1);
cc = epoint(2);
cua = U_A(cr, cc);
cra = R_A(cr, cc);


%% Extract the path based on minimal action map U0

while(true)
    
%     [cr, cc, cra, spoint(1), spoint(2), getD(cr, cc, spoint(1), spoint(2))]
    
    if(getD(cr, cc, spoint(1), spoint(2)) < EPS)
        break;
    end
    
    r_val = cra;
    for ddr = - r_val: r_val
        r = cr + ddr;
        if(r < 1 || r > R)
            continue;
        end
        
        ddc = sqrt(r_val * r_val - ddr * ddr);        
        ddc = uint16(ddc);
        
        for tc = -ddc: ddc
            c = cc + tc;
            if(c < 1 || c > C)
                continue;
            end
            img(r,c) = 255;
        end
    end
    
    chk(cr, cc) = 1;
    
    pr = cr;
    pc = cc;
    pua = cua;
    
    for i = 1: 8
        
        r = pr + dr(i);
        c = pc + dc(i);
        
        if(r < 1 || c < 1 || r > R || c > C || chk(r, c) == 1)
            continue;
        end
        
        pd = getD(pr, pc, spoint(1), spoint(2));
        cd = getD(r, c, spoint(1), spoint(2));
        if(cd > pd)
            continue;
        end
        
        if(cr == pr && cc == pc)
            cr = r;
            cc = c;
            cua = U_A(cr,cc);
            cra = R_A(cr,cc);
        elseif(abs(U_A(r,c)-eu) < abs(cua - eu))
            cr = r;
            cc = c;
            cua = U_A(cr,cc);
            cra = R_A(cr, cc);
        end
    end
end

rlt = img;