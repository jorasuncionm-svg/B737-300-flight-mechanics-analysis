function Mach=calculadoramach(Vel,h,Cp,R_g)
if nargin==2
    Cp=1004.5;
    R_g=287;
end
gamma=Cp/(Cp-R_g);
[~,Temp]=calculadoradensidad(h);
Mach=Vel./sqrt(gamma*R_g.*Temp);

end