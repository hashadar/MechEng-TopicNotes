%% plots
%{
bar(disp1)
xlabel('Node')
ylabel('Displacement/m')
grid on
legend('u_i','v_i')
bar(S')
xlabel('Element no.')
ylabel('Elemental strain')
grid on
legend('\tau_x','\tau_y','\tau_{xy}')
%}
% coordinate
%{
disp = [disp1(:,2),disp2(:,2),disp3(:,2),disp4(:,2)];
bar(disp)
xlabel('Node')
ylabel('Displacement/m')
grid on
legend('\alpha = 30','\alpha = 60','\alpha = 90','\alpha = 135')
title('y-coordinate displacement')
%}

% strain
S = [S1;S2;S3;S4];
bar(S)
ylabel('Elemental strain')
grid on
legend('\alpha = 30','\alpha = 60','\alpha = 90','\alpha = 135')
title('Comparison of strain for different values of \alpha')
xticklabels({'\epsilon x1', '\epsilon y1', '\epsilon xy1','\epsilon x2', '\epsilon y2', '\epsilon xy2','\epsilon x3', '\epsilon y3', '\epsilon xy3','\epsilon x4', '\epsilon y4', '\epsilon xy4'})