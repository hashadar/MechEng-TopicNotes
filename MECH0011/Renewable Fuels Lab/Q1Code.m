clc;
clear;

%read out all Data from tests
Test1 = table2array(readtable('Test_1_Pressure_Yr2E6lab.txt'));
Test2 = table2array(readtable('Test_2_Pressure_Yr2E6lab.txt'));
Test3 = table2array(readtable('Test_3_Pressure_Yr2E6lab.txt'));
Test4 = table2array(readtable('Test_4_Pressure_Yr2E6lab.txt'));
Test5 = table2array(readtable('Test_5_Pressure_Yr2E6lab.txt'));
Test6 = table2array(readtable('Test_6_Pressure_Yr2E6lab.txt'));
Test7 = table2array(readtable('Test_7_Pressure_Yr2E6lab.txt'));
Test8 = table2array(readtable('Test_8_Pressure_Yr2E6lab.txt'));
Test9 = table2array(readtable('Test_9_Pressure_Yr2E6lab.txt'));

%%
%read out CAD
CAD = Test1(:,1);

%read out Pressure for each test
Pressure1 = mean(Test1(:,20:69),2,'omitnan');
Pressure2 = mean(Test2(:,20:69),2,'omitnan');
Pressure3 = mean(Test3(:,20:69),2,'omitnan');
Pressure4 = mean(Test4(:,20:69),2,'omitnan');
Pressure5 = mean(Test5(:,20:69),2,'omitnan');
Pressure6 = mean(Test6(:,20:69),2,'omitnan');
Pressure7 = mean(Test7(:,20:69),2,'omitnan');
Pressure8 = mean(Test8(:,20:69),2,'omitnan');
Pressure9 = mean(Test9(:,20:69),2,'omitnan');

%Calculat the Pressure for different CAD BTDC
Pressure10CAD = (Pressure1+Pressure2+Pressure3)/3;
Pressure13CAD = (Pressure4+Pressure5+Pressure6)/3;
Pressure16CAD = (Pressure7+Pressure8+Pressure9)/3;

%read out Volumen for each test
Volume = Test1(:,2);
Vd=506.8;

%calculate the Indicated Displacemnet Work:
Wi10CAD=trapz(Volume,Pressure10CAD);
Wi13CAD=trapz(Volume,Pressure13CAD);
Wi16CAD=trapz(Volume,Pressure16CAD);
%calculate the IMEP
IMEP10CAD=Wi10CAD/Vd;
IMEP13CAD=Wi13CAD/Vd;
IMEP16CAD=Wi16CAD/Vd;
%calculating IMEP for all tests
IMEP1=trapz(Volume,Pressure1)/Vd;
IMEP2=trapz(Volume,Pressure2)/Vd;
IMEP3=trapz(Volume,Pressure3)/Vd;
IMEP4=trapz(Volume,Pressure4)/Vd;
IMEP5=trapz(Volume,Pressure5)/Vd;
IMEP6=trapz(Volume,Pressure6)/Vd;
IMEP7=trapz(Volume,Pressure7)/Vd;
IMEP8=trapz(Volume,Pressure8)/Vd;
IMEP9=trapz(Volume,Pressure9)/Vd;

%plot the averaged in-cylinder pressure vs. CAD
figure
hold on
plot(CAD,Pressure10CAD,'r-','LineWidth',1);
plot(CAD,Pressure13CAD,'b-','LineWidth',1);
plot(CAD,Pressure16CAD,'g-','LineWidth',1);
set(gca,'fontsize', 12)
%plot the IMEP
yline(IMEP10CAD,'r--','IMEP');
yline(IMEP13CAD,'b--','IMEP');
yline(IMEP16CAD,'g--','IMEP');
hold off

%plot Setting
grid
title('In-Cylinder Pressure vs CAD (Gasoline)');
xlabel('Crank Angle Degree');
ylabel('In-Cylinder Pressure (Bar)');
xlim([0 720]);
legend('10 CAD BTDC','13 CAD BTDC','16 CAD BTDC');
%creat Gamma
Gamma=zeros(7200,1);
for ii=1:1:7200
    if ii>7200/4 &&ii<=2*7200/4 || ii>3*7200/4
     Gamma(ii)=1.35;
    else
     Gamma(ii)=1.28;
    end
end

%get dV/dTheta and dP/dTheta
dVdTheta=zeros(7200,1);
dPdTheta10CAD=zeros(7200,1);
dPdTheta13CAD=zeros(7200,1);
dPdTheta16CAD=zeros(7200,1);
for ii=1:1:7200-1
    dVdTheta(ii)=(Volume(ii+1)-Volume(ii))/0.1;
    dPdTheta10CAD(ii)=(Pressure10CAD(ii+1)-Pressure10CAD(ii))/0.1;
    dPdTheta13CAD(ii)=(Pressure13CAD(ii+1)-Pressure13CAD(ii))/0.1;
    dPdTheta16CAD(ii)=(Pressure16CAD(ii+1)-Pressure16CAD(ii))/0.1;
end
dVdTheta(7200)=(Volume(1)-Volume(7200))/0.1;
dPdTheta10CAD(7200)=(Pressure10CAD(1)-Pressure10CAD(7200))/0.1;
dPdTheta13CAD(7200)=(Pressure13CAD(1)-Pressure13CAD(7200))/0.1;
dPdTheta16CAD(7200)=(Pressure16CAD(1)-Pressure16CAD(7200))/0.1;

%change the unit to SI units (Pa and M^3)
SIdPdTheta10CAD=dPdTheta10CAD*100000;
SIdPdTheta13CAD=dPdTheta13CAD*100000;
SIdPdTheta16CAD=dPdTheta16CAD*100000;
SIPressure10CAD=Pressure10CAD*100000;
SIPressure13CAD=Pressure13CAD*100000;
SIPressure16CAD=Pressure16CAD*100000;
SIdVdTheta=dVdTheta/1000000;
SIVolume=Volume/1000000;

%calculate the dQndTheta
dQndTheta10CAD=Gamma./(Gamma-1).*SIPressure10CAD.*SIdVdTheta+1./(Gamma-1).*SIVolume.*SIdPdTheta10CAD;
dQndTheta13CAD=Gamma./(Gamma-1).*SIPressure13CAD.*SIdVdTheta+1./(Gamma-1).*SIVolume.*SIdPdTheta13CAD;
dQndTheta16CAD=Gamma./(Gamma-1).*SIPressure16CAD.*SIdVdTheta+1./(Gamma-1).*SIVolume.*SIdPdTheta16CAD;

%smooth the dQndTheta output 
SdQndTheta10CAD=smoothdata(dQndTheta10CAD,'sgolay',100);
SdQndTheta13CAD=smoothdata(dQndTheta13CAD,'sgolay',100);
SdQndTheta16CAD=smoothdata(dQndTheta16CAD,'sgolay',100);


%plot the averaged in-cylinder pressure vs. CAD

figure
hold on
plot(CAD,Pressure10CAD,'r-','LineWidth',1);
plot(CAD,Pressure13CAD,'b-','LineWidth',1);
plot(CAD,Pressure16CAD,'g-','LineWidth',1);
%plot 1 Setting
grid
title('In-Cylinder Pressure vs CAD (Gasoline)');
xlabel('Crank Angle Degree');
ylabel('In-Cylinder Pressure (Bar)');
xlim([350 410]);
legend('10 CAD BTDC','13 CAD BTDC','16 CAD BTDC');
hold off
set(gca,'fontsize', 12)
%plot the Heat Release Trace vs. CAD
figure
hold on
plot(CAD,dQndTheta10CAD,'r-','LineWidth',0.7);
plot(CAD,dQndTheta13CAD,'b-','LineWidth',0.7);
plot(CAD,dQndTheta16CAD,'g-','LineWidth',0.7);
plot(CAD,SdQndTheta10CAD,'k-','LineWidth',1.5);
plot(CAD,SdQndTheta13CAD,'k-','LineWidth',1.5);
plot(CAD,SdQndTheta16CAD,'k-','LineWidth',1.5);
hold off
set(gca,'fontsize', 12)
%plot 2 Setting
grid
title('Heat Release Trace vs. CAD (Gasoline)');
xlabel('Crank Angle Degree');
ylabel('Heat Release Trace (J/deg)');
xlim([350 410]);
ylim([-5 70]);
legend('10 CAD BTDC','13 CAD BTDC','16 CAD BTDC','Smoothed Data');
hold off

%find and locate the peak heat release rate
[Max10CAD,CADMax10] = max(SdQndTheta10CAD);
[Max13CAD,CADMax13] = max(SdQndTheta13CAD);
[Max16CAD,CADMax16] = max(SdQndTheta16CAD);

%print out Peak Heat Release Rate
fprintf('The Peak Heat Release Rate for 10 CAD BTDC is: %f J/deg\n',Max10CAD);
fprintf('The Peak Heat Release Rate for 13 CAD BTDC is: %f J/deg\n',Max13CAD);
fprintf('The Peak Heat Release Rate for 16 CAD BTDC is: %f J/deg\n',Max16CAD);
%print out Peak's CAD 
fprintf('The Peak''s CAD for 10 CAD BTDC is: %f degree\n',CADMax10/10);
fprintf('The Peak''s CAD for 13 CAD BTDC is: %f degree\n',CADMax13/10);
fprintf('The Peak''s CAD for 16 CAD BTDC is: %f degree\n',CADMax16/10);

%plot the Heat Release Trace vs. CAD
figure
hold on
plot(CAD,SdQndTheta10CAD,'r-','LineWidth',1.5);
plot(CAD,SdQndTheta13CAD,'b-','LineWidth',1.5);
plot(CAD,SdQndTheta16CAD,'g-','LineWidth',1.5);
plot(CADMax10/10,Max10CAD,'k*','MarkerSize',12)
plot(CADMax13/10,Max13CAD,'k*','MarkerSize',12)
plot(CADMax16/10,Max16CAD,'k*','MarkerSize',12)
set(gca,'fontsize', 12)
hold off
%plot 2 Setting
grid
title('Heat Release Trace vs. CAD (Gasoline))');
xlabel('Crank Angle Degree');
ylabel('Heat Release Trace (J/deg)');
xlim([350 410]);
ylim([-5 70]);
legend('10 CAD BTDC Smoothed Data','13 CAD BTDC Smoothed Data','16 CAD BTDC Smoothed Data','Peak Point');
hold off