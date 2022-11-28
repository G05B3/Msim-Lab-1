
n_it = 150;
h = 1;
v1 = 3110;
v2 = 3110;
k10 = 0.0643 * 3600;
k12 = 0.3 * 3600;
k21 = 0.2455 * 3600;
delta = 1000;
c50=7.1903;




for i=1:3:30  % Configurar as doses

dc1(1:n_it)=zeros;
dc2(1:n_it)=zeros;
c1(1:n_it)=zeros;
c2(1:n_it)=zeros;
newd(1:(n_it/6))=i;
d=upsample(newd,6,0);
u(1:n_it)=zeros;

t(1:n_it) = zeros;

A = [1/v1 * (-k12-k10),1/v1 * k21; 1/v2 *k12 , -1/v2 *k21];
D = [1/v1;0] * delta;

for k=1:n_it
    change = A *[c1(k);c2(k)] + D*d(k);
    c1(k+1)=c1(k)+h*change(1);
    c2(k+1)=c2(k)+h*change(2);
    u(k) = c2(k)/(c2(k)+c50); % u(t)
    t(k) = k * h;
end


figure(1)
plot(t,u)  % u(t)
hold on



end





















