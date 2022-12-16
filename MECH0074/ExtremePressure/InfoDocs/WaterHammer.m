%%
%%
%% This programme is to calculate the pressure and velocity evolution 
%% in a pipe due to value closure and reflection at a leaky valve
%% and reservoir
%% 
%% This is a 1D model
%% using a Lax-Wendroff method of solving problem 
%%
%% Used for CW1 MECH0074
%% Professor Ian Eames
%% 10th November 2022
%%

%%
%%
%%
clc
clear
close all
Linewidth=2;
Fontsize=18;

%%
%% Characteristics of the liquid
%%
smax=100;        %% (m) pipe length
frictionfactor=0.10;
diameter=0.79394;%% (m)      pipe diameter
V_0=1.5;         %% (m/s)    initial flow speed
p_0=1e6;         %% (Pa)     initial pressure 55 bar
rho_0=455;       %% (kg/m^3) initial density 
speed=1100;      %% (m/s)    speed of sound in the liquid
%% short system

Npts=1000;
%% boundary conditions
closuretime=0; %% seconds
powernumber=0.2;
deltat=0.5E-7;
resistancecoeff=1.5e3;
tperiod=1.0;
%%
%% location of the points to track to get the pressure at start
%% and end of the bend location
%%
%% U bend with 4 bends 
%%
%%
%%                          ppppppppppppppppppppppp
%%                          p                     p
%%                          p                     p
%%                          p                     p
%%                          p                     p
%%                          p                     p
%%                          p                     p
%%          ppppppppppppppppp                     ppppppppppppppppppppp 
%%

bendinitial=30;
bendheight=10;
bendlength=10;
datapointstrack=[0 smax bendinitial (bendinitial+bendheight) (bendinitial+bendheight+bendlength) (bendinitial+2*bendheight+bendlength)];
%%datapointstrack=[10 25 50]; %% points which are being tracked
trackdataM=[];
trackdatamu=[];
trackdatatime=[];
NData=1E3;
NCollated=1E2;
pfieldcollate=[];
ufieldcollate=[];
Ntimesteps=round(tperiod/deltat);
%%
%% initial conditions
%% Solves for the Area A
%%                     V velocity (m/s)
%%                     p pressure (Pa)
%%                   rho density  (kg /m^3)
%%
A=linspace(1,1,Npts)*pi*diameter^2/4;
V=linspace(1,1,Npts)*V_0;
p=linspace(1,1,Npts)*p_0;
rho=linspace(1,1,Npts)*rho_0;
s=linspace(0,smax,Npts);
%%
mu = rho.*A;
mustar =linspace(0,0,Npts); Mstar=linspace(0,0,Npts);
munext =linspace(0,0,Npts); Mnext=linspace(0,0,Npts);
M = mu.*V;
rho=mu./A;
p = p_0 + (speed^2).*(rho-rho_0);
F1 = M; F2 = A.*p + M.^2./mu; F=[F1; F2];
S1=0; S2 = -frictionfactor*M.^2./(2*diameter*mu);
%% Df/Du= Df_1/Du1 = Df_1/DMU = 0, Df_2/DMU_1 =     speed%2
%% Df/Du= Df_1/Du1 = Df_1/DMU = 0, Df_2/DMU_1 =     speed%2
deltax=s(2)-s(1);

for jk=1:Ntimesteps%% time steps
    time=jk*deltat;
rho = mu./A;
p = p_0 + (speed^2).*(rho-rho_0);
F1= M; F2 = A.*p+ M.^2./(mu+1E-5); 
S1=0; S2 = 2*frictionfactor*M.^2./(diameter*mu);

%%
%% first step of Lax-Wendroff
%%
p(1)=p_0;
mustar(1:end-1) = mu(1:end-1) - (deltat/deltax)*( F1(2:end)-F1(1:end-1)) ; 
Mstar(1:end-1) = M(1:end-1) -   (deltat/deltax)*( F2(2:end)-F2(1:end-1)) +deltat*S2(1:end-1);
mustar(end) = mu(end) -deltat*resistancecoeff*heaviside(A(end)*rho_0-mu(end))*(mu(end)-A(end)*rho_0);
%% closure
if (time<closuretime)
Mstar(end)=mustar(end-1)*V_0*(1-time/closuretime)^powernumber;
else
    Mstar(end)=0;
    Mstar(end)=deltat*resistancecoeff*heaviside(mu(end)-A(end)*rho_0)*(mu(end)-A(end)*rho_0);
% ;
end

%%
%% second step of Lax-Wendroff
%%
rhostar = mustar./A;
p = p_0 + (speed^2).*(rhostar-rho_0);
p(1)=p_0;
F1 = Mstar;  F2 = A.*p + Mstar.^2./(mustar+1E-5); 
S1=0; S2star = 2*frictionfactor*Mstar.^2./(diameter*mustar);

munext(2:end) = 0.5*(mustar(2:end)+mu(2:end)) - (deltat/(2*deltax))*( F1(2:end)-F1(1:end-1));
Mnext(2:end) = 0.5*(Mstar(2:end)+M(2:end)) - (deltat/(2*deltax))*( F2(2:end)-F2(1:end-1)) +deltat*0.5*(S2(2:end)+S2star(2:end));
munext(1)=rho_0*A(1);
Mnext(1)=munext(1)*V_0;
munext(1)=munext(2);
Mnext(1)=Mnext(2);
munext(1)*V_0;


mu=munext;
M=Mnext;

if (time<closuretime)
M(end)=mustar(end-1)*V_0*(1-time/closuretime)^powernumber;
else
    M(end)=0;
end

M(find(M>20))=20;
M(M<-20)=-20;
mu(mu<0)=1E-3;


U = M./mu;
rho = mu./A;
p = p_0 + (speed^2).*(rho-rho_0);

%% plotout data
if (mod(jk,Ntimesteps/NCollated)==0)
pfieldcollate=[pfieldcollate ; p];
ufieldcollate=[ufieldcollate; U];
M=smooth(M)';
mu=smooth(mu)';
end

%% tracking data at specific points
%% tracking data at specific points
if (mod(jk,round(Ntimesteps/NData))==0)
trackdatatime=[trackdatatime jk*deltat];
trackdataM=[trackdataM ; interp1(s,M,datapointstrack)];
trackdatamu=[trackdatamu ; interp1(s,mu,datapointstrack)];
%% tracking data at specific points
%% tracking data at specific points
end


end

figure(1)
[c,h]=contourf(pfieldcollate);
set(h,'Linestyle','None')


%% start
%% convert tracked data to U and p
%%
Ndatastreams=size(trackdatamu,2);
trackdatap=[];
trackdataU=[];

for jk=1:Ndatastreams
U = trackdataM(:,jk)./trackdatamu(:,jk);
rho = trackdatamu(:,jk)./A(1);
p = p_0 + (speed^2).*(rho-rho_0);
trackdatap=[trackdatap p ];
trackdataU=[trackdataU  U];

end
%%
%%
figure(2)
plot(trackdatatime,trackdatap(:,1),'k-') ; hold on
plot(trackdatatime,trackdatap(:,2),'r-') ; hold on
plot(trackdatatime,trackdatap(:,3),'b-') ; hold on
legend('s=10','25','50')%%
set(gca,'Fontsize',Fontsize)
xlabel('$t (s)$','Interpreter','Latex')
ylabel('$p (Pa)$','Interpreter','Latex')
grid on
%% 
%% convert tracked data to U and p
%%
%%
figure(5)
F0_1=(smooth(trackdatap(:,3))-p_0)*pi*diameter^2/4;
F0_2=(smooth(trackdatap(:,4))-p_0)*pi*diameter^2/4;
F0_3=(smooth(trackdatap(:,5))-p_0)*pi*diameter^2/4;
F0_4=(smooth(trackdatap(:,6))-p_0)*pi*diameter^2/4;
F0_0=zeros(size(F0_4));
%%
%% The forces and orientation are specific to the problem
%%

Forcebend1 = [trackdatatime' F0_1 -F0_1 F0_0];
Forcebend2 = [trackdatatime' -F0_2 F0_2 F0_0];
Forcebend3 = [trackdatatime' F0_3 F0_3 F0_0];
Forcebend4 = [trackdatatime' F0_4 -F0_4 F0_0];

%%
%% Data saved to csv files
%% so easy to paste into ANSYS workbench
%%
outputfiledata('Fbend1.csv',Forcebend1);
outputfiledata('Fbend2.csv',Forcebend2);
outputfiledata('Fbend3.csv',Forcebend3);
outputfiledata('Fbend4.csv',Forcebend4);