clear

esp = [6, 6, 6, 6, 6, 6, 6, 6, 6];
%Plot dos graficos, sobrepostos
plotP5(esp, "#F4A24F");
esp = [3, 3, 3, 3, 6, 9, 9, 9, 9];
plotP5(esp, "#4FB6F4");
esp = [9, 9, 9, 9, 6, 3, 3, 3, 3];
plotP5(esp, "#3B208A");
legend('v_1(t)', 'v_2(t)', 'v_3(t)')

function plotP5(esp, color)
%Constantes ja definidas
k12 = 0.3 * 3600;
k21 = 0.2455 * 3600;
k10 = 0.0643 * 3600;
v1 = 3110;
v2 = 3110;
delta = 1000;
h = 1;
c50 = 7.1903;
a = 0.09;
kt = 10;
b = 1;

%Valores das varias posiçoes da matriz da equaçao (1)
mat_A = -1 * (k12 + k10)/v1;
mat_B = k21/v1;
mat_C = k12/v2;
mat_D = -1 * k21/v2;
A = [mat_A, mat_B; mat_C, mat_D];
%valores selecionados
xmax = 60;
d_val = 3;


%Definiçao dos vetores t, d, c1, c2, u, du, v, dv
t = 0:1:xmax-1;
%definir d com espaçamento variavel
esp = [esp, xmax]; %para garantir sempre a dimensao minima
d = zeros(1,xmax);
idx = 1;
for k = 1:length(esp)
    d(idx) = d_val;
idx = idx + esp(k);
end
d = d(1:xmax); %limitar o d para a dimensao a utilizar no grafico

c1(1:xmax-1) = zeros;
c2(1:xmax-1) = zeros;
du = (1:xmax);
du(1:xmax) = zeros;
u = (1:xmax);
dv = (1:xmax);
dv(1:xmax) = zeros;
v = (1:xmax);

%Obtenção dos vetores c1, c2 e as suas derivadas
for k = 1:xmax-1
    c1(h*(k+1)) = c1(h*k) + h * A(1,:) * [c1(h*k); c2(h*k)] + delta * d(h*k)/v1;
    c2(h*(k+1)) = c2(h*k) + h * A(2,:) * [c1(h*k); c2(h*k)];
end

%Obtenção do vetor u e a sua derivada
for k = 1:xmax
u(k) = c2(k) / (c50 + c2(k));
if k > 1
    du(k) = u(k) - u(k-1);
else
    du(k)= 1;
end
end

%Obtenção do vetor v e a sua derivada
for k = 1:xmax-1
    dv(k) = (a*v(k)*(1-(v(k)/kt))-(b*u(k)*v(k)));
    v(k+1) = v(k) + h * dv(k);
end
figure(1)
plot(t,v,'Color',color,'LineWidth',1.5)
hold on
title("Doses com Espaçamento Variável (nº de doses constante)");
xlabel("Tempo (dias)");
ylabel("Volume do Tumor (mm^3)");
grid on
end
