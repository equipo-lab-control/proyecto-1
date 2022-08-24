clear 
clc

load('data/Ke.mat')
load('data/initial.mat')

% s

s = tf('s')


P_motor = Ke/((J*s+b)*(L*s+R)+Ke^2)

P_motor_simplify = P_motor / 3.973e-05

wn = sqrt(2.238e-6)

ganancia = 0.044 / wn^2;

zeta = 0.05145 / (2 * wn)


%grid on 
%%rlocus(P_motor)
%hold off

% Etapa 2

polos = pole(P_motor)
zero = zero(P_motor)

%grid on 
%hold on 
%bode(P_motor)

%hold off

% Tiempo de muestreo

% todo guardar grafica y poner frecuencia


% r locus 
frecuencia = 1.29e+03;
frecuenciaNyquist = frecuencia * 2;
samplingP = 1/frecuenciaNyquist;

save('data/polos', 'polos')
save('data/zeros', 'zero')
save('data/parametros_trans', 'P_motor', 'wn', 'ganancia', 'zeta')
save('data/samplingP', 'samplingP')



