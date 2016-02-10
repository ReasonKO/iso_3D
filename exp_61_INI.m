clear all
close all
clc;
def_ini
%% Начальная позиция и ориентация робота.
R=[80,40,15]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %Угло отклонения от Z и угол отклонения от X;
[~,~,I]=locI(Rang_);
%% Параметры алгоритма и моделирования
global Modul
Modul.freq=5;  %Частота обновления картинки в секундах
Modul.Tend=1040;%830;

global PAR
PAR.d0=10;        %Приследуемое значение
PAR.d0d=5;        %дельта в законе управления 5.5
PAR.Sgrad=0.8;    %Гамма в законе управления

PAR.Hspeed=0.05;   %Эта*

PAR.Hmax=135;    %H+
PAR.Hmin=5;    %H-
PAR.USpeed=10;   %Угловая скорость
PAR.VSpeed=10;  %Линейная скорость

PAR.Uh=0.01;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=15;     %время процесса IN
PAR.WipeTime=[345,675];%[280,530];

PAR.run_dynamic='exp_61_dyn';
%% Поле

[X,Y]=meshgrid(-100:100,-100:100);
figure(3000)
clf
%axis([-20,20,-20,20,0,10])
hold on
[ang1,ang2]=meshgrid(-pi:pi/200:pi,(-pi/2):pi/200:(pi/2));
vt=@(t)(1-(sin((abs(t)*2-1)*pi/2)))/2;
vt2=@(t1,t2)1+vt(t1).*vt(t2).*(abs(t1)<1).*(abs(t2)<1);
%figure(5)
%plot(-pi:pi/50:pi,vt((-pi:pi/50:pi)*2+pi/4));

figure(3000)
R_=80*ones(size(ang1))
R_=R_.*vt2(ang1,(abs(ang2)-0.50)*2.5);
%R=R.*vt((abs(ang2)-pi/6)/pi*12);
%R(or(abs(ang1*2)>=1,abs(abs(ang2)-pi/6)/pi*12>1))=1;
%R(or(abs(ang2*2+pi/4)>=1,abs(ang1*3)>=1))=1;
Z=R_.*cos(ang2);
X=R_.*cos(ang1).*sin(ang2);
Y=R_.*sin(ang1).*sin(ang2)*0.6;
L=(vt2(ang1,(abs(ang2)-0.50)*2.5)-1);
Sx=X;
Sy=Y;
Y=Y+40.*sign(X).*sin(L*3);
X=X-20.*sign(X).*sin(L*3);
Z(and(ang1==0,ang2==0.5))=101;



surf(X,Y,Z,'EdgeColor','none');
axis([-100,100,-100,100,0,150])
hold on
L2=R_/80-1;
Y=Sy+40.*sign(Sx).*sin(L2*3);
X=Sx-20.*sign(Sx).*sin(L2*3);
<<<<<<< HEAD
%mesh(X,Y,Z,'EdgeColor','none');
=======
mesh(X,Y,Z,'EdgeColor','none');
>>>>>>> origin/master
axis([-100,100,-100,100,0,150])
hold on


%[ang,R__]=meshgrid(-pi:pi/10:pi,0:0.1:1);
%R_2=vt(abs(ang)*2/pi).*R__*27;
%surf(R_2.*cos(ang),R_2.*sin(ang),100*ones(size(ang)));

colormap('gray');
shading interp
view([-330,120,140]);

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xsize=[-100,100];
field.Ysize=[-100,100];
field.Zsize=[-120,120];


for i=1:field.l
%[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
%set(k2,'LineWidth',2);
%[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
%set(k3,'LineWidth',2);
end
%%
%iso_MODUL
