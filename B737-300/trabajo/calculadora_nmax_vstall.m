function n = calculadora_nmax_vstall(v,h, CL_max, W, S_ref)
g=9.81;
rho=calculadoradensidad(h);
n = (v^2 * rho * CL_max) / (2 * (W*g / S_ref));