n_it = 150;
h = 1;
v1 = 3110;
v2 = 3110;
k10 = 0.0643 * 3600;
k12 = 0.3 * 3600;
k21 = 0.2455 * 3600;
delta = 1000;
c50 = 7.1903;
a= 0.09;
b= 1;
kt=10;

dc1(1:n_it)=zeros;
dc2(1:n_it)=zeros;
c1(1:n_it)=zeros;
c2(1:n_it)=zeros;
u(1:n_it)=zeros;
v(1:n_it)=zeros;
v(1)=1;

NEWD(1:(n_it/6))=3;
d=upsample(NEWD,6,0);

t(1:n_it) = zeros;

A = [1/v1 * (-k12-k10),1/v1 * k21; 1/v2 *k12 , -1/v2 *k21];
D = [1/v1;0] * delta;

for k=1:n_it
    change = A *[c1(k);c2(k)] + D*d(k);
    c1(k+1)=c1(k)+h*change(1);
    c2(k+1)=c2(k)+h*change(2);
    u(k) = c2(k) / (c50 + c2(k));
    v(k+1)=v(k)+h*a*v(k)*((1-v(k)/kt)-b*u(k)*v(k));
    t(k) = k * h;
end


figure(1)
plot(t,v(1:n_it))
hold on
plot(t,u(1:n_it))

%gg=plot(t,c1,c2);
%set(gg,'LineWidth',1.5)


