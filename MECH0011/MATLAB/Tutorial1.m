%Hasha Dar

[x,y]=meshgrid(-2:0.1:2,1:0.1:4);

u = zeros(40);
v = (4.*log(y) -2.*y + 10);

quiver(u, v)