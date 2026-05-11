%% VELOCIDAD DE PERDIDA
v = linspace(0, 100, 1000);
h = linspace(0, 5000, 1000);
W = [46010.1*9.81, 50851*9.81, 56472*9.81];

figure;
hold on;
title('Velocidad de pérdida en despegue');
xlabel('Velocidad de pérdida [m/s]');
ylabel('Altitud [m]');
grid on;

for f = 1:length(W)
    
    rho = zeros(size(h));
    for j = 1:length(h)
        [rho(j), temp] = calculadoradensidad(h(j));
    end
    
    
    V_stall = Vstall(W(f), h, CL_to, S_ref);
    
   
    plot(V_stall,h, 'DisplayName', ['W = ' num2str(W(f)/9.81) ' kg']);
end

hold off;
legend;
figure;
hold on;
title('Velocidad de pérdida en aterrizaje');
xlabel('Velocidad de pérdida [m/s]');
ylabel('Altitud [m]');
grid on;

for f = 1:length(W)
    
    rho = zeros(size(h));
    for j = 1:length(h)
        [rho(j), temp] = calculadoradensidad(h(j));
    end
    
    
    V_stall = Vstall(W(f), h, CL_l, S_ref);
    
   
    plot(V_stall,h, 'DisplayName', ['W = ' num2str(W(f)/9.81) ' kg']);
end

hold off;
legend;
h = linspace(0, 14000, 1000);
figure;
hold on;
title('Velocidad de pérdida en crucero');
xlabel('Velocidad de pérdida [m/s]');
ylabel('Altitud [m]');
grid on;

for f = 1:length(W)
    
    rho = zeros(size(h));
    for j = 1:length(h)
        [rho(j), temp] = calculadoradensidad(h(j));
    end
    
    
    V_stall = Vstall(W(f), h, CL_max, S_ref);
    
   
    plot(V_stall,h, 'DisplayName', ['W = ' num2str(W(f)/9.81) ' kg']);
end

hold off;
legend;
