clf
x=-1:0.001:1;
y=x.^2;
A=area(x,y);
set(A(1),'FaceColor','red');
axis('image');
xlabel('-1 \leq x \leq 1')
ylabel('y-axis')
title('Plot of domain of integration where R: -1 \leq x \leq 1, 0 \leq y \leq x^2')
grid on
grid minor 