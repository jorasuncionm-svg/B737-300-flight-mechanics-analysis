function n = calculadora_nmax_empuje(v,h, k_polar_incompresible, CD0, W, S_ref)

    g=9.81;
    
    T=empujedisponible(v,h);
    W_S = W*g / S_ref;  % Carga alar (W/S)
    T_W = T /(W*g);  % Relación empuje-peso
    rho=calculadoradensidad(h);
    q=1/2*rho*v^2;
      

    % Cálculo de n
    n = sqrt((q / (k_polar_incompresible * W_S)) * (T_W - q * (CD0 / W_S)));
    if imag(n)~=0
        n=NaN;
    end
end
