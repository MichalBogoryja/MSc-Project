rng(1);     % For reproducibility
x1 = wblrnd(1,1,1,50);
x2 = wblrnd(1.2,2,1,50);

h = kstest2(x1,x2)

[h,p] = kstest2(x1,x2)

[h,p] = kstest2(x1,x2,'Alpha',0.01)