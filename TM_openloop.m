

%hot stream fluid temperature (Th) 350 (K)
Th=350;
%cold stream fluid temperature (Tc) 273 (K)
Tc=273;

tspan=[0 20];
ho=[310,8];
wh0=4;
wc0=6;
op=ho;
time=0:0.1:60;

[t,h]=ode15s(@(t,H)Thermal_mixing(t,H,wh0,wc0),tspan,ho);

subplot(2,1,1)
plot(t,h(:,2),'--b')
title('Temperature Vs Time')

subplot(2,1,2)
plot(t,h(:,1),'--r')
title('Water level in Tank Vs Time')

T_SS= h(length(h(:,1)),1)
H_SS=h(end,end)

function dHdt = Thermal_mixing(t,H,wh0,wc0)
    dHdt=zeros(2,1);
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
%     %steady-state hot stream input flow rate (wh0) 4 (kg/s)
%     wh0=4;
%     %steady-state cold stream input flow rate (wc0) 6 (kg/s)
%     wc0=6;

    w=sqrt(2*g*H(2));
    dHdt(1)= (wh0*Th+wc0*Tc-(wc0+wh0)*H(1))/(A*rho*H(2));
    dHdt(2)= (wh0+wc0-w)/(A*rho);

end