clc
clear
load('data/funcion_transferencia_motor_datos')
load('data/samplingP')
P_motor_discrete=c2d(P_motor,samplingP,'zoh')
