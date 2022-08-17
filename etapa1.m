clc
clear
J=3.78E-3;
R=13.6;
K=0.044;
L=10.51E-3;
b=4E-3;

OS=0.15; %porcentaje sobre impulso (no es porcentaje)
Ts=1.2; %Tiempo de asentamiento (s)
syms s
Gp=simplify(K/((J*s+b)*(L*s+R)+K^2))

A=sqrt((log(OS))^2/((log(OS))^2+pi^2))
wn=4/(A*Ts)

Td=simplify(wn^2/(s^2+2*A*s+wn^2))    %transferencia deseada

%Gc=K*(1+1/)