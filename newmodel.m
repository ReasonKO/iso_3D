[X,Y]=meshgrid(-100:100,-100:100);

RB=50;
RM=15;

figure(3003)
clf
axis([-60,60,-60,60,-60,60])
hold on
[angin,angout]=meshgrid(0:pi/50:2*pi,0:pi/100:2*pi);
R=RB+RM*cos(angin);
Z=RM*sin(angin);
X=R.*cos(angout);
Y=R.*sin(angout);

mesh(X,Y,Z);
%% 
[X,Y]=meshgrid(-100:100,-100:100);
figure(3004)
clf
axis([-20,20,-20,20,0,10])
hold on
[ang,h]=meshgrid(0:pi/50:2*pi,0:100);
R=sqrt(h)+5;
Z=h/10;
X=R.*cos(ang);
Y=R.*sin(ang);

mesh(X,Y,Z);
[ang,R]=meshgrid(0:pi/10:2*pi,0:0.2:5);
mesh(R.*sin(ang),R.*cos(ang),zeros(size(ang)));