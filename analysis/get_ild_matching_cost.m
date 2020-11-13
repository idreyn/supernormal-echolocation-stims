function cost = get_ild_matching_cost(a,b)
    arguments
        a (1,180)
        b (1,180)
    end
    cost = 0;
    for i = 1:90
        cost = cost + (a(i) - b(i)) ^ 2;
    end
end