clc
clear
%datos motor
J=3.78E-3;
R=13.6;
K=0.044;
L=10.51E-3;
b=4E-3;

OS=0.15; %porcentaje sobre impulso (no es porcentaje)
Ts=1.2; %Tiempo de asentamiento (sec)
syms s
Gp=simplify(K/((J*s+b)*(L*s+R)+K^2)) %transferencia de motor

zeta=sqrt((log(OS))^2/((log(OS))^2+pi^2)) %amortiguamiento deseado
wn=4/(zeta*Ts) %frecuencia natural deseada

Td=simplify(wn^2/(s^2+2*zeta*s+wn^2))    %transferencia deseada

syms ti td Kc C %ti td Kc son coeficientes de la funcion de transferencia del controlador
Gc=Kc*(1+1/ti*s+td*s) %Transferencia de controlador
H=C/C; %Parece redundante, es el sensor, C es la salida, sirve a la hora de hacerlo iterativo
