clear
clc
% Etapa 1
% Obtener los parametros usando matlab

% Datos del problema
J=3.78E-3;
R=13.6;
L=10.51E-3;
b=4E-3;

table_motor_2 = readtable('motor_2.csv')



%clc
%J=3.78E-3;
%R=13.6;
%K=0.044;
%L=10.51E-3;
%b=4E-3;

%s = tf('s');

%P_motor = K/((J*s+b)*(L*s+R)+K^2)

%P_motor_simplify = P_motor / 3.973e-05

%wn = sqrt(2.238e-6)

%K = 0.044 / wn^2

%zeta = 0.05145 / (2 * wn)


%grid on 
%%rlocus(P_motor)
%hold off

%% Etapa 2

%polos = pole(P_motor)
%zero = zero(P_motor)

%grid on 
%hold on 
%bode(P_motor)

%hold off


