h = [0, 1000, 3000, 5000, 7000, 9000, 11000, 12000];
W = [ 46010.1*9.81, 50851*9.81,56472*9.81];
M=[ 46010.1, 50851,56472]
v = linspace(0,350,350);
num_figuras=3;
Cp = 1004.5;
R_g = 287;

for f = 1:num_figuras
    figure;
    hold on; 
    title(['Velocidad de planeo. Peso: ', num2str(M(f)), ' [kg]']);
    xlabel('Velocidad [m/s]');
    ylabel('Velocidad de planeo [m/s]');
    grid on;

    
    v = linspace(0,350,250); 
    for i = 1:length(h)
        [rho,temp]=calculadoradensidad(h(i));
        [T, tau] = empujedisponible(v, h, Cp, R_g);
        D = (1/2) * rho .* v.^2 * S_ref .* (CD0 + k_polar_incompresible * (W(f) ./ (0.5 * rho .* v.^2 * S_ref)).^2);
        Vplaneo=v.*(D)./W(f);
        axis([0 350 0 50]);
        plot(v, Vplaneo);
    end

    hold off;
end