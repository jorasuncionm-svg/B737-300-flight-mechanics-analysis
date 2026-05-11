function [T_necesario] = calculadora_empuje_necesario_mio(h,v,W,S_ref,k_polar_incompresible,CD0,AR_eff,type)

Mc = 0.8;
g=9.81;
M=calculadoramach(v,h);
rho=calculadoradensidad(h);

Lambda_BA = 28 * pi / 180;

n=3/(1+1/AR_eff);
CD_wave=0.35*10^-3*(10*(M-Mc)/(1/cos(Lambda_BA)-Mc)).^n;
D0=1/2*rho.*v.^2*S_ref*CD0;
D_ind=k_polar_incompresible*(W*g)^2/(1/2*rho*v.^2*S_ref);
D_wave=1/2*rho.*v.^2*S_ref.*CD_wave;

if M>=Mc & type==1
    D=D0+D_ind+D_wave;

else
    D=D0+D_ind;

end
T_necesario=D;
