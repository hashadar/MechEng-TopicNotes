clc
clear
close all

v = zeros(3,1000);

for i = [1 2 3]
    %define vars
    x = linspace(0,8,1000);
    c = 1;
    p = 1;
    t = 2*i;

    %equation
    v(i,:) = exp(-(x-(1/sqrt(c*p)).*t).^2);
end

%plots 
subplot(3,1,1)
plot(x,v(1,:))
title('Graph to show flow velocity against distance along vessel with t=2s')
xlabel('Distance along vessel/[L]')
ylabel('Flow velocity/[LS^{-1}]')
grid on
subplot(3,1,2)
plot(x,v(2,:))
title('Graph to show flow velocity against distance along vessel with t=4s')
xlabel('Distance along vessel/[L]')
ylabel('Flow velocity/[LS^{-1}]')
grid on
subplot(3,1,3)
plot(x,v(3,:))
title('Graph to show flow velocity against distance along vessel with t=6s')
xlabel('Distance along vessel/[L]')
ylabel('Flow velocity/[LS^{-1}]')
grid on