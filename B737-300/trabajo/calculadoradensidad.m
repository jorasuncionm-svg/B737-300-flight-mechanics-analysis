function [rho,Temp]=calculadoradensidad(h)


for i=1:length(h)
    if h(i)<=11000
        rho(i)=(1.049-23.659e-6*h(i)).^(4.259);
        Temp(i)=288.15-6.5e-3*h(i);
    else 
        rho(i)=2.06214*exp(-0.158e-3*h(i));
        Temp(i)=288.15-6.5e-3*11000;
    
    end
end

