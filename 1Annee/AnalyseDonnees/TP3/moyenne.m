function M = moyenne(im)
    I= single(im);
    R = I(:,:,1);
    V = I(:,:,2);
    B = I(:,:,3);
    normeRVB =max(ones(size(R)),R+V+B);
    v = V./normeRVB;
    r = R./normeRVB;
    r_bar = mean(r(:));
    v_bar = mean(v(:));
    M =[r_bar v_bar]';
end