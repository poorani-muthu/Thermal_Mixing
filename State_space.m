
syms T H wh wc

A=jacobian(TM,[T,H]);
B=jacobian(TM,[wh,wc]);
C=[1 0;0 1];
D=0;

%steady-state hot stream input flow rate (wh0) 4 (kg/s)
wh=4;
%steady-state cold stream input flow rate (wc0) 6 (kg/s)
wc=6;
%steady-state temperature of fluid in tank (T0) 303.8 (K)
T=T_SS;
%steady-state height of fluid in tank (h0) 5.096 (m)
H=H_SS;

AA=eval(A);
BB=eval(B);
TM_sys=ss(AA,BB,C,D)
TM_sys_discrete=c2d(TM_sys,0.1);


function dHdt = TM()
    syms T H wh wc
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
       

    w=sqrt(2*g*H);
    dHdt(1)= (wh*Th+wc*Tc-(wc+wh)*T)/(A*rho*H);
    dHdt(2)= (wh+wc-w)/(A*rho);

end