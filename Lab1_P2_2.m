
n_it = 150;
h = 1;
v1 = 3110;
v2 = 3110;
k10 = 0.0643 * 3600;
k12 = 0.3 * 3600;
k21 = 0.2455 * 3600;
delta = 1000;
c50=7.1903;



c2(1:n_it)=zeros;
u(1:n_it)=zeros;
du(1:n_it)=zeros;
d=(1:1:n_it);



for k=1:n_it
    c2(k)=k12/(k10*k21)*delta*d(k);
    u(k)=c2(k)/(c2(k)+c50);
    du(k+1)= u(k);  % dont know how to do it
end


figure(1)
plot(d,u)  % u(t)
hold on






















