function dummy = extract_curve(img, spoint)

dummy = 0;

[R, C] = size(img);
pixel_cnt = R * C;
randa = 30;

img_ave = get_ave(img, R, C);

%% Call FMM function
pr = -1;
pc = -1;

ppoint = [pr, pc];
[next_r1, next_c1, u_val, l_val] = FMM(R, C, img, ppoint, spoint, randa);

ppoint = [next_r1, next_c1];
[next_r2, next_c2, u_val, l_val] = FMM(R, C, img, ppoint, spoint, randa);

rlt1 = [];
rlt1 = [rlt1; spoint];

rlt2 = [];
rlt2 = [rlt2; spoint];


while(true)
    
    ppoint = spoint;
    spoint = [next_r1, next_c1];    
    rlt1 = [rlt1 ;spoint];
    [next_r1, next_c1, u_val, l_val] = FMM(R, C, img, ppoint, spoint, randa);
    
    if(isEndPoint(next_r1, next_c1, u_val / l_val, img_ave, randa, R, C))
        break;
    end
    
%     sdt = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    
end


while(true)
    
    ppoint = spoint;
    spoint = [next_r2, next_c2];    
    rlt2 = [rlt2 ;spoint];
    [next_r2, next_c2, u_val, l_val] = FMM(R, C, img, ppoint, spoint, randa)
    
    if(isEndPoint(next_r2, next_c2, u_val / l_val, img_ave, randa, R, C))
        break;
    end
    
    sdt = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    
end

d_ratio = 0.4;

[cnt1, dummy] = size(rlt1);
for i = 1: cnt1
    for j = 1: i - 1
        if(dist(rlt1(i,:), rlt1(j,:)) < randa * d_ratio)
            break;
        end
    end
    
    if j < (i - 1)
        break;
    end
end

if i < cnt1    
    if i > 2
        cnt1 = i - 2;
        rrlt1 = zeros(cnt1, 2);
        for i = 1: cnt1
            for j = 1: 2
                rrlt1(i, j) = rlt1(i,j);
            end
        end
    else
        cnt1 = 0;
        rrlt1 = [];
    end
else
    rrlt1 = zeros(cnt1, 2);
    for i = 1: cnt1
        for j = 1: 2
            rrlt1(i,j) = rlt1(i,j);
        end
    end
            
end


[cnt2, dummy] = size(rlt2);

for i = 1: cnt2
    for j = 1: i - 1
        if(dist(rlt2(i,:), rlt2(j,:)) < randa * d_ratio)
            break;
        end
    end
    
    if j < (i - 1)
        break;
    end
end

if i < cnt2    
    if i > 2
        str = '000000000000000000000000000000000000000000000'
        cnt2 = i - 2;
        rrlt2 = zeros(cnt2, 2);
        for i = 1: cnt2
            for j = 1: 2
                rrlt2(i, j) = rlt2(i,j);
            end
        end
    else
        cnt2 = 0;
        str = '11111111111111111111111111111111111111111'
        rrlt2 = [];
    end
else
    str = '2222222222222222222222222222222'
    rrlt2 = zeros(cnt2, 2);
    for i = 1: cnt2
        for j = 1: 2
            rrlt2(i,j) = rlt2(i,j);
        end
    end
            
end


imshow(img);
hold on;
if(cnt1 >= 2)
%     plot(rrlt1(:,2), rrlt1(:,1), '-r', 'LineWidth', 1);
end

cnt2
for i = 1: cnt2
    [rrlt2(i,1), rrlt2(i,2)]
end

if(cnt2 >= 2)
      
%     plot(rrlt2(:,2), rrlt2(:,1), '-r', 'LineWidth', 1);
end
plot(rlt1(:,2), rlt1(:,1), '-g', 'LineWidth', 1);
plot(rlt2(:,2), rlt2(:,1), '-g', 'LineWidth', 1);

hold off;
