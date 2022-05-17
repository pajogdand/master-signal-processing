function [next_r, next_c, u_val, l_val] = FMM(R, C, img, ppoint, spoint, randa)

img = double(img);

%% Initialize
Unvisit = 0;
Active = 1;
Solved = 2;

dr = [0, -1, 0, 1];
dc = [-1, 0, 1, 0];

state = zeros(R, C);
U = zeros(R, C);
L = zeros(R, C);

for i = 1: R
    for j = 1: C
        state(i, j) = Unvisit;
        U(i, j) = intmax;
        L(i, j) = 0;
    end
end

mh = MinHeap(20000);
mh = insertKey(mh, 0, spoint(1), spoint(2));

U(spoint(1), spoint(2)) = 0;
state(spoint(1), spoint(2)) = Active;

while(mh.getSize() > 0)
    [mh, tu, tr, tc] = mh.extractMin();
    state(tr, tc) = Solved;
%     [tr, tc]
    if(L(tr, tc) == randa)        
        if(ppoint(1) ~= -1 && isValid(ppoint, spoint, tr, tc) == 0)
%             [ppoint, spoint, tr, tc]
%             isValid(ppoint, spoint, tr, tc)
            continue;        
        else
            break;
        end
    end
    
    if(tu > U(tr, tc))
        continue;
    end
    
    
    
    for i = 1: 4
        r = tr + dr(i);
        c = tc + dc(i);
        if(r > R || c > C || r < 1 || c < 1 || state(r, c) == Solved)
            continue;
        end
        
        if(state(r, c) == Unvisit)
            U(r, c) = tu + img(r, c);
            L(r, c) = L(tr, tc) + 1;
            mh = insertKey(mh, U(r, c), r, c);
            state(r, c) = Active;
        else
            if(U(r, c) > (U(tr, tc) + img(r, c)))
                U(r, c) = U(tr, tc) + img(r, c);
                L(r, c) = L(tr, tc) + 1;
                mh = insertKey(mh, U(r, c), r, c);
                state(r, c) = Active;
            end
        end        
    end    
end

l_val = L(tr, tc);
u_val = U(tr, tc);
next_r = tr;
next_c = tc;