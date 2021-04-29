clc
clear
close all

v = zeros(3,1000);

for i = [1 2 3]
    %define vars
    x = linspace(0,8,1000);
    V0 = 1;
    l = 8;
    t = 2*i;

    %equation
    v(i,:) = V0.*(cos((pi.*x)./(2.*l))).*(exp(-t.*(1+(pi^2)./(4.*l.^2))));
end

%plots 
plot(x,v(1,:),'red',x,v(2,:),'blue',x,v(3,:),'green')
title('Graph to show flow velocity against position along vessel')
xlabel('Distance along vessel/[L]')
ylabel('Flow velocity/[LS^{-1}]')
grid on
axis auto
legend('t = 2s', 't = 4s', 't = 6s')