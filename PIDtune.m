systf=tf(TM_sys) 
C0 = pidstd(1,1,1); 
pidtune(systf(1,1),C0)
pidtune(systf(2,2),C0)