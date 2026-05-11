h = [0, 1000, 3000, 5000, 7000, 9000, 11000, 12000];
W = [ 46010.1*9.81, 50851*9.81,56472*9.81];
M=[ 46010.1, 50851,56472]
v = linspace(0,350,350); 
num_figuras=3;
Cp = 1004.5;
R_g = 287;
Vamax=zeros(8,3);
for f = 1:num_figuras
    figure; 
    hold on; 
    title(['Velocidad ascensional. Peso: ', num2str(M(f)), ' [kg]']);
    xlabel('Velocidad [m/s]');
    ylabel('Velocidad ascensional [m/s]');
    grid on;

    
    v = linspace(0,350,250); 
    for i = 1:length(h)
        [rho,temp]=calculadoradensidad(h(i));
        [T, tau] = empujedisponible(v, h, Cp, R_g);
        D = (1/2) * rho .* v.^2 * S_ref .* (CD0 + k_polar_incompresible * (W(f) ./ (0.5 * rho .* v.^2 * S_ref)).^2);
        Vsubida=v.*(T(:,i)'-D)./W(f);
        [pks, locs] = findpeaks(Vsubida, v);
        axis([0 350 0 50]);
        plot(v, Vsubida);
        plot(locs, pks, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r');
        Vamax(i,f)=pks;
        Vangulosubida_max = sqrt((2 / rho) * (W(f) / S_ref) * sqrt(k_polar_incompresible / CD0));
        c=max(find(v<Vangulosubida_max));
        angulosubida_max = (T(c,i) / W(f)) - sqrt(4 * k_polar_incompresible * CD0);
        Vsubidaangulosubidamax = Vangulosubida_max*(T(c,i)'-D(c))./W(f);
        plot(Vangulosubida_max,Vsubidaangulosubidamax, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'g')
        plot(v, tan(angulosubida_max)*v,'--k')
    end

    hold off;
end


for f = 1:num_figuras
    figure; 
    hold on; 
    title(['Ángulo de ascenso. Peso: ', num2str(M(f)), ' [kg]']);
    xlabel('Velocidad [m/s]');
    ylabel('angulo de ascenso [rad]');
    grid on;

   
    v = linspace(0,350,250); 
    for i = 1:length(h)
        [rho,temp]=calculadoradensidad(h(i));
        [T , tau] = empujedisponible(v, h, Cp, R_g);
        D = (1/2) * rho .* v.^2 * S_ref .* (CD0 + k_polar_incompresible * (W(f) ./ (0.5 * rho .* v.^2 * S_ref)).^2);
        angulosubida=(T(:,i)'-D)./W(f);
        plot(v, angulosubida);
        axis([0 350 0 0.5]);
    end

    hold off;
end


figure
title(['Altitud frente a velocidad ascensional']);
xlabel('Velocidad  ascensional [m/s]');
ylabel('Altitud [m]');
hold on  
colors = lines(size(Vamax, 2));  

for f = 1:size(Vamax, 2)  
    p(f,:) = polyfit(Vamax(:,f), h, 1); 
    z = linspace(0, max(Vamax(:,f)), 100); 
    y_fit = polyval(p(f,:), z); 


    color = colors(f, :); 


    plot(Vamax(:,f), h, 'o', 'MarkerFaceColor', color, 'MarkerEdgeColor', 'k', 'MarkerSize', 6)

    plot(z, y_fit, '-', 'Color', color, 'LineWidth', 2)

end

hold off  

grid on
xlabel('Velocidad ascensional [m/s]')
ylabel('Altitud [m]')
axis([0 50 0 14000])
 



techo = zeros(num_figuras, 1); % Preasignar memoria

for f = 1:num_figuras
    figure
    hold on
    title(['Tiempo de subida. Peso: ', num2str(M(f)), ' [kg]']);
    xlabel('Tiempo [s]');
    ylabel('Altitud [m]');
    
    t = linspace(0, 3000, 3000); 
    
    techo(f) = p(f,2);
    z_max = techo(f) * ones(size(t)); 
    
    Vamax_sl(f) = -p(f,2) / p(f,1); 

    z = linspace(0, techo(f), 3000);
    
    
    valid_idx = (techo(f) - z) > 0;
    t_subida = NaN(size(z)); 
    t_subida(valid_idx) = (techo(f) / Vamax_sl(f)) .* log(techo(f) ./ (techo(f) - z(valid_idx)));
    
    plot(t_subida, z, 'b') 
    plot(t, z_max, 'r--') 
    axis([0 3000 0 14000])
    hold off
end