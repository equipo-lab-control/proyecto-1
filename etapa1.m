clear
clc
J=3.78E-3;
R=13.6;
K=0.044;
L=10.51E-3;
b=4E-3;

s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2)

P_motor / 3.973e-05

wn = sqrt(2.238e-6)

K = 0.044 / wn^2

zeta = 0.05145 / (2 * wn)

grid on 
rlocus(P_motor)
