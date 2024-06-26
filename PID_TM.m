clear all
%PID controlled thermal mixing 

%controller parameters for T,wH
KpT =0.01;%0.007/2;
TiT =15.62*4;
TdT =2.86*1.5;

%controller parameters for H,wC
KpH = 0.1;%0.1508;
TiH = 100;%89.67;
TdH = 2.86*1.5;

x=60;
time=0:0.1:x;
delt=0.1;

init(1,:)=[306,6]; %initial concentraion and temerarutre of outlet stream
spT=304.5; %set point for temp
spH=6.1672; %setpoint for height

%initial error
eT=abs(init(1,1)-spT);
eH=abs(init(1,2)-spH);

Hmatf(1,:)=init(1,:);
wc(1)=6.5;
wh(1)=4.5;
TF(1)=0;

for i=2:length(time)
    if i<=x*5
        spT=304.5;
        spH=6.1672;
        
    else 
        spT=303.8;
        spH=5.096;        
    end

    wc_new=wc(i-1);
    wh_new=wh(i-1);

    t(i,:)=[time(i-1) time(i)]; %loop runs for every 0.1 sec and last value is stored in Cmatf

    [tmat,Hmat]=ode15s(@(t,H)TMM(t,H,wc_new,wh_new),t(i,:),init);

    TF(i)=tmat(end);
    Hmatf(i,:)=Hmat(end,:); 
       
    init=Hmat(end,:); 
    eT(i)=abs(Hmatf(i,1)-spT); 
    eH(i)=abs(Hmatf(i,2)-spH);

    wc(i)=wc(1)+KpH*(eH(i)+((delt/TiH)*(sum(eH)))+((TdH/delt)*(eH(i)-eH(i-1))));
    wh(i)=wh(1)+KpT*(eT(i)+((delt/TiT)*(sum(eT)))+((TdT/delt)*(eT(i)-eT(i-1))));

    vec = [i wh(i) TF(i) eH(i)]
end

Hnew=Hmatf(:,2);
Tnew=Hmatf(:,1);

tplot=0:0.1:TF(end);

Hsp1=6.1672.*ones(1,x*5);
Hsp2=5.096.*ones(1,x*5+1);
Hsp=[Hsp1 Hsp2];
Tsp1=304.5.*ones(1,x*5);
Tsp2=303.8.*ones(1,x*5+1);
Tsp=[Tsp1 Tsp2];

%plotting
subplot(2,2,1)
plot(tplot,Hsp,'k')
hold on
plot(tplot,Hmatf(:,2),'b')
xlabel('time sec')
ylabel('H')
title(' actual H and set point')
ylim([4 7])

subplot(2,2,2)
plot(tplot,Tsp,'k')
hold on
plot(tplot,Hmatf(:,1),'b')
xlabel('time sec')
ylabel('T')
title(' actual Temperature and set point')
ylim([300 310])

subplot(2,2,3)
plot(tplot,wc,'r')
xlabel('time sec')
ylabel('m^3/s')
title('Manipulated variable wh Vs. time')
ylim([4 8])

subplot(2,2,4)
plot(tplot,wh,'r')
xlabel('time sec')
ylabel('m^3/s')
title('Manipulated variable wc Vs. time')
ylim([2 6])
hold off

function dHdt = TMM(t,H,wc,wh)
    
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
