%Get the energy integrated along path from p0 to p and the radius of
%spheres centered at the point p

function [u_val, r_val] = getPotential(R, C, img, p0, cr, cc, w, r_max, TH)

pre_p = img(cr, cc) - p0;


%decide radius and path using mean and variance

for r_val = 1: r_max
    
    u_val = 0;
    cir_cnt = 0;
    
    for dr = - r_val: r_val
        dc = sqrt(r_val * r_val - dr * dr);
        dc = uint16(dc);
        
        r = cr + dr;
        if(r < 1 || r > R)
            continue;
        end
        
        c = cc + dc;
        if(c < 1 || c > C)
            continue;
        end
        
        u_val = u_val + img(r,c) - p0 + w;
        cir_cnt = cir_cnt + 1;
        
        if(dc == 0)
            continue;
        end
        
        c = cc - dc;
        if(c < 1 || c > C)
            continue;
        end
        
        u_val = u_val + img(r, c) - p0 + w;
        cir_cnt = cir_cnt + 1;
        
    end
    
    u_val = double(u_val) / double(cir_cnt);
%     [r_val, cir_cnt,  u_val, pre_p, TH]
    
    if(abs(u_val) > TH)
        break;
    end
    
    pre_p = u_val;
    
end

% u_val = pre_p;

if(r_val ~= r_max)
    r_val = r_val - 1;
end

u_val = 0;
u_cnt = 0;
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
        u_val = u_val + img(r,c);
        u_cnt = u_cnt + 1;
    end
end

u_val = double(u_val) / double(u_cnt);
