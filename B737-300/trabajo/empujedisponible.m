function [Thrust, tau] = empujedisponible(Vel, h, Cp, R_g)


    if nargin <= 2
        Cp = 1004.5;
        R_g = 287;
    end
    
    % Inicialización de vectores
    tau = zeros(length(Vel), length(h));
    Thrust = zeros(length(Vel), length(h));
    
    for i = 1:length(h)
        M_N = calculadoramach(Vel, h(i), Cp, R_g);
        [rho, ~] = calculadoradensidad(h(i));
        [rho_0, ~] = calculadoradensidad(0);
        if h(i) > 11000
                
            s=1;
        else
            
            s=0.7;
        end
        
        sigma = rho / rho_0;
        
        
        for j = 1:length(Vel)
            if M_N(j) < 0.4
                K_1tau = 1;
                K_2tau = 0;
                K_3tau = -0.6;
                K_4tau = -0.04;
            else
                K_1tau = 0.88;
                K_2tau = -0.016;
                K_3tau = -0.3;
                K_4tau = 0;
            end
            
            if h<=11000
                tau(j, i) = (K_1tau + K_2tau * 5 + (K_3tau + K_4tau * 5) * M_N(j)) * sigma^s;
            else
                tau(j, i) = (K_1tau + K_2tau * 5 + (K_3tau + K_4tau * 5) * M_N(j)) * (calculadoradensidad(11000)/calculadoradensidad(0))^0.7*(calculadoradensidad(h(i))/calculadoradensidad(11000));
            end
        end
    end
    
    % Cálculo del empuje
    T_SL = 2*82292.1;
    
    for i = 1:length(h)
        for j = 1:length(Vel)
            Thrust(j, i) = T_SL * tau(j, i);
%             if h(i) <= 11000
%                 Thrust(j, i) = T_SL * tau(j, i);
%                 
%             else
%                 if flag==0
%                     flag=1;
%                 end
%                 [~, T_11km] = empujedisponible(Vel(j), 11000, Cp, R_g);
%                 
%                 Thrust(j, i) = T_11km * calculadoradensidad(h(i))/calculadoradensidad(11000);
                
            %end
        end
    end

end

