clear 
clc

% Loads data
try 
    load('data/Ke.mat'); % rads^-1
    load('data/initial.mat');
catch ME 
    etapa_1;
    load('data/Ke.mat');
    load('data/initial.mat');
end


% Variable de laplace
s = tf('s')

% Funcion de transferencia;
P_motor = Ke/((J*s+b)*(L*s+R)+Ke^2)


P_motor_simplified = zpk(P_motor)

K = P_motor_simplified.K;
zero = P_motor_simplified.Z{:};
polos = P_motor_simplified.P{:}; % rads

denominator = conv([1 -polos(1)], [1 -polos(2)])

wn2 = denominator(end); 
wn = sqrt(wn2); % rads
wn_hz = rads2hz(wn);
zeta = denominator(end-1) / (2 * wn) % no tiene dimensiones
ganancia = K / wn2 % ~rad / sV~


% aqui salen las frecuencias de los diferentes polos<
% con esto sacas las frecuencias
damp(P_motor_simplified);
[wn_table, zeta_table, ~] = damp(P_motor_simplified) % rads




%% Tiempo de muestreo

%% todo: hacer grafica de rlocus
%% todo: sacar ferecuencia de la grafica de rlocus

frecuencia = max(wn_table) % rads
frecuencia_hz = rads2hz(frecuencia)
frecuenciaNyquist_hz = frecuencia_hz * 2; % hz
samplingP = 1/frecuenciaNyquist_hz; % s


save('data/polos', 'polos')
save('data/zeros', 'zero')
save('data/funcion_transferencia_motor_datos', 'P_motor', 'wn_hz',  'wn', 'ganancia', 'zeta')
save('data/samplingP', 'samplingP')
