clc
clear

% Loads data
try 
    load('data/Ke')
    load('data/initial.mat')
    load('data/funcion_transferencia_motor_datos.mat')
    load('data/polos')
    load('data/samplingP.mat')
    load('data/zeros.mat')
catch ME 
    etapa_2;
    load('data/Ke')
    load('data/initial.mat')
    load('data/funcion_transferencia_motor_datos.mat')
    load('data/polos')
    load('data/samplingP.mat')
    load('data/zeros.mat')
end


% todo: cambiar el nombre de la variable
K = Ke;
%%%%%%%%%%%

% Datos del pid
OS=0.15; 
Ts=1.2; 

%%%%%%%%%%%

% Despeje de los parametros ideals

%amortiguamiento deseado
zeta_d = double(sqrt((log(OS))^2 / ((log(OS))^2 + pi^2)))

%frecuencia natural deseada
wn_d = double(4 / (zeta_d * Ts) )

%%%%%%%%%%%

% Polo adicional

% Parametros del controlado (presentacion)
syms ti td Kc s

Td = simplify( wn_d^2 / ( s^2 + 2 * zeta_d* s * wn_d +wn_d^2 ))    %transferencia deseada

polos_d = poles(Td); %polos FT deseada

% Si salen coeficientes negativos, alejalo mas
alejamiento = 1000;
polo_adicional = double(alejamiento * min(real(polos_d)))


Td_polo_extra = expand( wn_d^2 / ( ( s^2 + 2*zeta_d*s*wn_d+wn_d^2 ) * (s - polo_adicional) ))    

[num, den] = numden(Td_polo_extra)
den_coefs = coeffs(den);

num_simplified = double(num / den_coefs(end))

% estan en orden de s0, s1, s2 ...
den_simplified = double(den_coefs / den_coefs(end))

%%%%%%%%%%%% Sistemas de ecuaciones %%%%%%%%%%%%%%%%
syms ti td Kc 

eq1 = K * Kc / (J * L * ti) == den_simplified(1)
eq2 = (b * R + K^2 + K * Kc) / (J * L) == den_simplified(2)
eq3 = (J * R + b * L + K * Kc * td) / (J * L) == den_simplified(3)


results = solve(eq1, eq2, eq3);

% Coeficientes del pid
Kc = double(results.Kc)
ti = double(results.ti)
td = double(results.td)
Ki = double(Kc / ti)
Kd = double(Kc * td)

save("data/coeficientes_pid", 'Kc', 'ti', 'td', 'Ki', 'Kd')


