clear 
clc

% Loads data
try 
    load('data/Ke.mat');
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
poles = P_motor_simplified.P{:};

denominator = conv([1 -poles(1)], [1 -poles(2)]);

wn2 = denominator(end);
wn = sqrt(wn2);
zeta = denominator(end-1) / (2 * wn)
ganancia = K / wn2;


% aqui salen las frecuencias de los diferentes polos<
% con esto sacas las frecuencias
damp(P_motor_simplified)
[wn_table, zeta_table, ~] = damp(P_motor_simplified)




%% Tiempo de muestreo

%% todo: hacer grafica de rlocus
%% todo: sacar ferecuencia de la grafica de rlocus

frecuencia = max(wn_table)
frecuenciaNyquist = frecuencia * 2;
samplingP = 1/frecuenciaNyquist;


save('data/polos', 'polos')
save('data/zeros', 'zero')
save('data/funcion_transferencia_motor_datos', 'P_motor', 'wn', 'ganancia', 'zeta')
save('data/samplingP', 'samplingP')
