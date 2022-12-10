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
xmax = 100;
d_val = 3;


%Definiçao dos vetores t, d, c1, c2, u, du, v, dv
t = 0:1:xmax-1;
%definir d com espaçamento variavel
esp = zeros(1, xmax) + 6;
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
u0 = (1:xmax);
cTH = 0.4; %limiar
R = 1:xmax;
R(1:xmax) = 0;
R(1) = 0.15;
cfort = 0.7; %coeficiente de fortalecimento - determina o quao fortalecidas as celulas ficam (aumento max da resistência)
u(1) = 0;
for k = 1:xmax
    if c2(k) < cTH
        if k > 1
            u(k) = 0;
        end
        if k < xmax
            R(k+1) = R(k) + cfort*(cTH - c2(k))^2; %quadratico para se aproximar mais ao real; aumento tanto > quanto < c2
        end
   else
        u(k) = (c2(k) / (c50 + c2(k))) * 1/(1 + R(k));
        if k < xmax
            R(k+1) = R(k);
        end
    end
    u0(k) = (c2(k) / (c50 + c2(k)));
end

%Obtenção do vetor v e a sua derivada
v0 = (1:xmax);
dv0 = (1:xmax);
for k = 1:xmax-1
    dv(k) = (a*v(k)*(1-(v(k)/kt))-(b*u(k)*v(k)));
    v(k+1) = v(k) + h * dv(k);
    dv0(k) = (a*v0(k)*(1-(v0(k)/kt))-(b*u0(k)*v0(k)));
    v0(k+1) = v0(k) + h * dv0(k);
end

%Plot dos graficos, sobrepostos
figure(1)
plot(t,v,'Color','#F4A24F','LineWidth',1.5)
hold on
plot(t,u,'Color','#4FB6F4','LineWidth',1.5);
hold on
plot(t,R,'Color','#3B208A','LineWidth',1.5);
hold on
plot(t, v0,'Color','#FF5240','LineWidth',1.5);
title("Decréscimo de Volume");
xlabel("Tempo (dias)");
ylabel("Dimensão do Tumor");
legend('v(t)','u(t)','R(t)', 'v0(t)');