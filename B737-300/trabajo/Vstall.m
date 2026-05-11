function V_stall=Vstall(W,h,CL_max,S_ref)
[rho,~]=calculadoradensidad(h);
g=9.81;
V_stall=sqrt((2.*W*g)./(CL_max.*S_ref.*rho));

end