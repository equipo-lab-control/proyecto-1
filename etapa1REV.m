clear
clc
% Etapa 1
% Obtener los parametros usando matlab

% Datos del problema
J=3.78E-3;
R=13.6;
L=10.51E-3;
b=4E-3;

table_motor_2 = readtable('./data/motor_2.csv' );
table_motor_2.Properties.VariableNames = { 'vel_rads', 'vel_rpm', 'volts' };

table_vel_rads_volts = removevars(table_motor_2,"vel_rpm");

model = fitlm(table_vel_rads_volts);

Ke = model.Coefficients{"vel_rads","Estimate"};


% todo: poner la funcion para guardar figura
% plot(model)

% Saving data
save('data/Ke', 'Ke');
save('data/initial', 'J', 'R', 'L', 'b');
save('data/table_motors', 'table_vel_rads_volts');