
clear all
close all
clc

%% MASAS (en S.R.) DEL BOEING 737-300 V. CLASE MIXTA, PRIMERA COLUMNA %%

MTW=56699; %Maximum Taxi Weight [kg]
MTOW=56472; %Maximum TakeOff Weight [kg]
MPLW=16148; %Maximum Payload Weight [kg]
MLW=51710; %Maximum Landing Weight [kg]
OEW=31479; %Operating Empty Weight [kg]
UFW=16141; %Usable Fuel Weight [kg]
MZFW=47627; %Maximum Zero Fuel Weight [kg]

WEIGHTS = [56472, 46010.1, 50851]; %[kg]

% SELECCIÓN DE PESO
selected_weight = WEIGHTS(1); % Cambiar este índice (1, 2 o 3) para seleccionar el peso deseado

%% DATOS GEOMÉTRICOS Y AERODINÁMICOS (en S.R.) %%

b_alar=28.88; %[m]

S_ref=105.4; %[m^2]
S_hor=31.1; %[m^2]
S_ver=16.2; %[m^2]

n_motores=2;
d_fuselaje=3.76; %[m]
l_fuselaje=32.18; %[m]
d_gondola=2.44; %[m]
l_gondola=3; %[m]

CL_max=1.068;

%% CÁLCULO DE LA POLAR INCOMPRESIBLE
CDPI_ala=0.003;
CDPI_fuselaje=0.0024;
CDPI_gondola=0.006;
CDPI_cola=0.0025;

S_ala=2*S_ref; %[m^2]
S_fuselaje=0.75*pi*d_fuselaje*l_fuselaje; %[m^2]
S_gondola=pi*d_gondola*l_gondola; %[m^2]
S_cola=2*(S_hor+S_ver); %[m^2]

CD0=1.1/S_ref*sum([CDPI_ala,CDPI_fuselaje,n_motores*CDPI_gondola,CDPI_cola]*[S_ala,S_fuselaje,S_gondola,S_cola]');

AR=b_alar^2/S_ref;
AR_eff=1.2*AR;
e_others=1/0.05;
e_w=0.875; %Interpolado a ojo según AR
S_fuselaje_oswalt=pi*d_fuselaje^2/4;
e_fuselaje=S_ref/S_fuselaje_oswalt*1/0.75; %El 0.75 interpolado también a ojo según AR

e=1/(1/e_w+1/e_fuselaje+1/e_others);

k_polar_incompresible=1/(AR*e*pi);

%% ENVOLVENTE
clear W v h T_Necesario T_Disponible
num_h=100;
h=linspace(0,13000,num_h); %[m]
aux=0;
for i=1:num_h
    
    v_min_try(i)=fsolve(@(v)empujedisponible(v, h(i))-calculadora_empuje_necesario_mio(h(i),v,selected_weight,S_ref,k_polar_incompresible,CD0,AR_eff,1),1);
    v_max_try(i)=fsolve(@(v)empujedisponible(v, h(i))-calculadora_empuje_necesario_mio(h(i),v,selected_weight,S_ref,k_polar_incompresible,CD0,AR_eff,1),300);
    
    if imag(v_min_try(i))==0 && imag(v_max_try(i))==0 && v_max_try(i)>=v_min_try(i) && v_max_try(i)>=0 && v_min_try(i)>=0 
        v_min(i)=v_min_try(i);
        v_max(i)=v_max_try(i);
        new_h_num=i;
        
    else
        new_h_num=i;
        aux=1;
        break
    end
end

figure(1)
plot(v_min,h(1:new_h_num-aux),'b')
hold on
plot(v_max,h(1:new_h_num-aux),'b')
plot(Vstall(selected_weight,h(1:new_h_num),CL_max,S_ref),h(1:new_h_num),'b--')
hold off
xlabel('Velocidad [m/s]')
ylabel('Altitud [m]')
title(['Envolvente de vuelo. Peso: ', num2str(selected_weight), ' [kg]'])

figure(2)
m_min=calculadoramach(v_min,h(1:new_h_num-aux));
m_max=calculadoramach(v_max,h(1:new_h_num-aux));
plot(m_min,h(1:new_h_num-aux),'b')
hold on
plot(calculadoramach(Vstall(selected_weight,h(1:new_h_num),CL_max,S_ref),h(1:new_h_num)),h(1:new_h_num),'b--')
plot(m_max,h(1:new_h_num-aux),'b')

hold off
xlabel('Número de Mach')
ylabel('Altitud [m]')
title(['Envolvente (Mach). Peso: ', num2str(selected_weight), ' [kg]'])

figure(3)
hold on
xlabel('Velocidad [m/s]')
ylabel('Empuje disponible [N]')
title(['Empuje Disponible. Peso: ', num2str(selected_weight), ' [kg]'])

figure(4)
hold on
xlabel('Velocidad [m/s]')
ylabel('Factor de empuje')
title(['TAU. Peso: ', num2str(selected_weight), ' [kg]'])

clear v h
v=linspace(0,300,100); %[m/s]
h=linspace(0,1200,10); %[m]
num_h=length(h);
for i=1:num_h
[Thrust, tau] = empujedisponible(v, h(i));
figure(3)
plot(v,Thrust)
figure(4)
plot(v,tau)
end
hold off

clear v h
h=linspace(0,11500,10); %[m]
v=linspace(0,350,200); %[m/s]

figure(5)
hold on
xlabel('Velocidad [m/s]')
ylabel('Empuje necesario [N]')
title(['Empuje Necesario Compresible. Peso: ', num2str(selected_weight), ' [kg]'])

figure(50)
hold on
xlabel('Velocidad [m/s]')
ylabel('Empuje necesario [N]')
title(['Empuje Necesario Incompresible. Peso: ', num2str(selected_weight), ' [kg]'])
for i=1:10
    for j=1:length(v)
        T_necesario_compresible(j) = calculadora_empuje_necesario_mio(h(i),v(j),selected_weight,S_ref,k_polar_incompresible,CD0,AR_eff,1);
        T_necesario_incompresible(j) = calculadora_empuje_necesario_mio(h(i),v(j),selected_weight,S_ref,k_polar_incompresible,CD0,AR_eff,0);
    end
figure(5)
plot(v,T_necesario_compresible)
axis([0 v(end) 0 9e5])
figure(50)
plot(v,T_necesario_incompresible)
axis([0 v(end) 0 9e5])
end
hold off


%% VIRAJE %%
clear v h
v=linspace(1,300,200);
h=0;
for j=1:length(v)

    n_thrust(j) = calculadora_nmax_empuje(v(j),h, k_polar_incompresible, CD0, selected_weight, S_ref);
    
    if isnan(n_thrust(j))
        
        break
    end

end
num_v=j;
figure(6)
plot(v(1:num_v),n_thrust(1:num_v))
hold on


for j=1:length(v)
    n_vstall(j) = calculadora_nmax_vstall(v(j),h, CL_max, selected_weight, S_ref);
    if n_vstall(j)>=n_thrust(j)
        n_vstall=n_vstall(1:j);
        
        break
    end
end
num_v2=j;
plot(v(1:num_v2),n_vstall(1:num_v2))
hold off
k_in=1;
k_end=num_v;
aux2=0;

for j=1:num_v

    if n_thrust(j)<1 

        k_in=k_in+1;

    end

    

    mu(j)=acos(1/n_thrust(j));

end

for j=num_v:-1:1

    if n_thrust(j)<1 

        k_end=k_end-1;

    end

    

    mu(j)=acos(1/n_thrust(j));

end

figure(7)
plot(v(k_in:k_end),mu(k_in:k_end))
hold on
hold off

figure(6)
xlabel('Velocidad [m/s]')
ylabel('Factor de carga')
title(['Factor de carga máximo. Peso: ', num2str(selected_weight), ' [kg]'])
figure(7)
xlabel('Velocidad [m/s]')
ylabel('Ángulo de inclinación [rad]')
title(['Ángulo de inclinación. Peso: ', num2str(selected_weight), ' [kg]'])


%% Despegue y aterrizaje



