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

P_motor_simplify = P_motor / 3.973e-05

wn = sqrt(2.238e-6)

ganancia = 0.044 / wn^2;

zeta = 0.05145 / (2 * wn)

polos = pole(P_motor)
zero = zero(P_motor)


% Tiempo de muestreo

% todo: hacer grafica de rlocus
% todo: sacar ferecuencia de la grafica de rlocus

frecuencia = 1.29e+03;
frecuenciaNyquist = frecuencia * 2;
samplingP = 1/frecuenciaNyquist;


save('data/polos', 'polos')
save('data/zeros', 'zero')
save('data/funcion_transferencia_motor_datos', 'P_motor', 'wn', 'ganancia', 'zeta')
save('data/samplingP', 'samplingP')
