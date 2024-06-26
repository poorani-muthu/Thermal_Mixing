xnom=[303.8 5.096];
ynom=xnom;
unom=[4 6];

%system setup
mpc1=mpc(TM_sys_discrete);
tplot=0:0.1:60;

%setting the prediction and control horizon
mpc1.PredictionHorizon=2;
mpc1.ControlHorizon=1;

% Minimum and maximum values of manipulated variable
mpc1.MV(1).Min=0-unom(1);
mpc1.MV(2).Min=0-unom(2);
mpc1.MV(1).Max=10-unom(1);
mpc1.MV(2).Max=10-unom(2);

% initializing weights
mpc1.Weights.OV(1)=1000;
mpc1.Weights.OV(2)=1000;
mpc1.Weights.MV(1)=10;
mpc1.Weights.MV(2)=10;

%control of rate of change of input variable
mpc1.Weights.ManipulatedVariablesRate(1)=0.01;
mpc1.Weights.ManipulatedVariablesRate(2)=0.01;

% %additional conditions for optimal change in the input variable
mpc1.ManipulatedVariables(1).RateMax = 0.1;
mpc1.ManipulatedVariables(2).RateMax = 0.5;
mpc1.ManipulatedVariables(1).RateMin = -0.1;
mpc1.ManipulatedVariables(2).RateMin = -0.5;

% setting extremum values of input and output variables.
mpc1.OV(1).Min=250-ynom(1);
mpc1.OV(2).Min=2-ynom(2);
mpc1.OV(1).Max=350-ynom(1);
mpc1.OV(2).Max=10-ynom(2);


runtime=60;
x0=xnom-xnom;
init=[308 6.5];
ref1=[303.8*ones(200,1);310*ones(200,1);315*ones(201,1)];
ref2=[5.096*ones(200,1); 6*ones(200,1);7.5*ones(201,1)];
ref=[ref1  ref2]-[xnom(1),xnom(2)];

xc=mpcstate(mpc1); %state 
xc.Plant=x0;
x=xc.Plant;
YY=[0 0];UU=[0 0];

tic
for i=1:(length(tplot)-1)
    
    tspan=[tplot(i) tplot(i+1)];
    wh_=UU(i,1)+unom(1);
    wc_=UU(i,2)+unom(2);
    [tmat,ymat]=ode45(@(t,H) TMM(t,H,wh_,wc_),tspan,init);
    y=ymat(end,:)-ynom;
    init=ymat(end,:);
    YY=[YY ;y];
    %PREDICTING FUTURE POSIBLE OUTPUT
    [u,info]=mpcmove(mpc1,xc,y,ref(i,:));
    UU=[UU; u'];
    x=xc.Plant;
end
toc

%plotting
subplot(2,2,1)
plot(tplot,YY(:,1)+ynom(1),'b','LineWidth',1.5) %+ynom(1)
hold on
plot(tplot,ref(:,1)+ynom(1),'r--','LineWidth',1.5)%+ynom(1)
hold off
box
grid on
title('Temperature Vs time','FontSize',10)
xlabel('time, sec','FontSize',10)
ylabel('Temperature','FontSize',10)
legend('Temperature','SP' )
ylim([300 320])

subplot(2,2,2)
plot(tplot,YY(:,2)+ynom(2),'b','LineWidth',1.5)%+ynom(2)
hold on
plot(tplot,ref(:,2)+ynom(2),'r--','LineWidth',1.5)%+ynom(2)
hold off
box
grid on
title('Height Vs time','FontSize',10)
xlabel('time, min','FontSize',10)
ylabel('Height','FontSize',10)
legend('Height','SP' )
ylim([2 10])

subplot(2,2,3)
plot(tplot,UU(:,1)+unom(1),'b','LineWidth',1.5)%+unom(1)
box
grid on
title('Hot water flowrate Vs time','FontSize',10)
xlabel('time, min','FontSize',10)
ylabel('Hot water flowrate, m3/min','FontSize',10)
ylim([0 10])

subplot(2,2,4)
plot(tplot,UU(:,2)+unom(2),'b','LineWidth',1.5)%+unom(2)
box
grid on
title('cold water temperature Vs time','FontSize',10)
xlabel('time, min','FontSize',10)
ylabel('cold water temperature, 1/min','FontSize',10)
ylim([0 10])

function dHdt = TMM(t,H,wh,wc)
    
    %cross-sectional area (A) 1 (m2)
    A=1;
    %hot stream fluid temperature (Th) 350 (K)
    Th=350;
    %cold stream fluid temperature (Tc) 273 (K)
    Tc=273;
    %density of fluid (ρ) 1 (kg/m3)
    rho=1;
    %acceleration due to gravity (g) 9.81 (m/s2)
    g=9.81;
       
    dHdt(1,1)= (wh*Th+wc*Tc-(wc+wh)*H(1))/(A*rho*H(2));
    dHdt(2,1)= (wh+wc-sqrt(2*g*H(2)))/(A*rho);

end