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

%Zeta y wn hay que despejarlas de Ts y OT en PPT

zeta=sqrt((log(OS))^2/((log(OS))^2+pi^2)) %amortiguamiento deseado
wn=4/(zeta*Ts) %frecuencia natural deseada

Td=simplify(wn^2/(s^2+2*zeta*s+wn^2))    %transferencia deseada

syms ti td Kc C %ti td Kc son coeficientes de la funcion de transferencia del controlador
Gc=Kc*(1+1/(ti*s)+td*s) %Transferencia de controlador
H=C/C; %Parece redundante, es el sensor, C es la salida, sirve a la hora de hacerlo iterativo

T=simplify(Gc*Gp/(1+H*Gc*Gp))

polos=poles(Td); %polos FT deseada
polo1=double(polos(1)) %Polo1
polo2=double(polos(2)) %Polo2
a=10*real(polo1);%Polo agregado para igualar Td a T

Td=Td/(s+a); %TD con polo agregado
eq1=Td==T
pretty(eq1) %Hay que multiplicar T*s/s para tenerlo en terminos de s^3+s^2+s+A

%Igualando terminos de los denominadores se obtienen ti td y Kc 
