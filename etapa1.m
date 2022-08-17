clc
clear
J=3.78E-3;
R=13.6;
K=0.044;
L=10.51E-3;
b=4E-3;

syms s
G=K/((J*s+b)*(L*s+R)+K^2)
simplify(G)