rng('default')  % For reproducibility
x1 = rand(5,1);
x2 = rand(10,1);
x3 = rand(15,1);
x = [x1; x2; x3];

g1 = repmat({'First'},5,1);
g2 = repmat({'Second'},10,1);
g3 = repmat({'Third'},15,1);
g = [g1; g2; g3];