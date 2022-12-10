clear
%Constantes ja definidas
k12 = 0.3 * 3600;
k21 = 0.2455 * 3600;
k10 = 0.0643 * 3600;
v1 = 3110;
v2 = 3110;
delta = 1000;
h = 1;
c50 = 7.1903;

%Valores das varias posiçoes da matriz da equaçao (1)
mat_A = -1 * (k12 + k10)/v1;
mat_B = k21/v1;
mat_C = k12/v2;
mat_D = -1 * k21/v2;
A = [mat_A, mat_B; mat_C, mat_D];
%valores selecionados
dmax = 10;
d = 0:1:dmax-1;
c2 = delta * d * k12 / (k21 * k10);
du = (1:dmax);
du(1:dmax) = zeros;
u = (1:dmax);

%adquirir valores de u(d) e du/dd
for k = 1:dmax
u(k) = c2(k) / (c50 + c2(k));
if k > 1
    du(k) = u(k) - u(k-1);
else
    du(k)= 1;
end
end
figure(1)
plot(d,u,'Color','#4FB6F4','LineWidth',1.5)
hold on
plot(d,du,'Color','#F4A24F','LineWidth',1.5)
xlabel("Dose d (mg)");
ylabel("Efeito u e a sua Derivada du (sem unidades)");
legend('u(d)','du(d)')
grid on