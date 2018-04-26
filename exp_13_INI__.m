clear all
close all
clc;
def_ini
%% Начальная позиция и ориентация робота.
ROBOT=[-80,-50,50]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %Угло отклонения от Z и угол отклонения от X;
[~,~,I]=locI(Rang_);
%% Параметры алгоритма и моделирования
global Modul
Modul.freq=0.1;  %Частота обновления картинки в секундах
Modul.Tend=820;
Modul.SaveExp=1;


global PAR
PAR.d0=10;        %Приследуемое значение
PAR.d0d=5;        %дельта в законе управления 5.5
PAR.Sgrad=0.8;    %Гамма в законе управления

PAR.Hspeed=0.05;   %Эта*

PAR.Hmax=145;    %H+
PAR.Hmin=55;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=10;  %Линейная скорость

PAR.Uh=0.01;    %u_h с чертой
PAR.Um=1;       %u с чертой

PAR.Tin=15;     %время процесса IN
PAR.WipeTime=[280,520];

%PAR.run_dynamic='exp_11_dyn';
%% Поле

figure(3000)
clf
hold on

dviz=0.05;

R_=[1:10]*10;
for i=1:length(R_)
R=R_(i);

[ang1,ang2]=meshgrid((-1:dviz:1)*pi,(0:dviz:1)*pi);

X=R*cos(ang1).*sin(ang2);
Y=R*sin(ang1).*sin(ang2);
Z=100+R*cos(ang2);

color=R/100;
viz1{i}=surf(X,Y,Z,'EdgeColor',[color,color,1-color]);%'%,'Color',[R/10,1-R/10,1]);

set(viz1{i},'CData',color*ones(size(Z)));
set(viz1{i},'FaceAlpha',0.1)
set(viz1{i},'EdgeAlpha',0.2)
end
axis equal
axis([-10,10,-10,10,-10,10])

R=50;
dviz=0.01;
[ang1,ang2]=meshgrid((-1:dviz:1)*pi,(0:dviz:1)*pi);
X=R*cos(ang1).*sin(ang2);
Y=R*sin(ang1).*sin(ang2);
Z=100+R*cos(ang2);

VIZ_12_1=surf(X,Y,Z,'EdgeColor','none');
%color=R/100;
%set(VIZ_12_1,'CData',color*ones(size(Z)));
set(VIZ_12_1,'FaceAlpha',0.5)
set(VIZ_12_1,'EdgeAlpha',0.5)


axis equal
axis([-100,100,-100,100,0,200])
hold on
%plot3(0
%[ang,R__]=meshgrid(-pi:pi/10:pi,0:0.1:1);
%R_2=vt(abs(ang)*2/pi).*R__*27;
%surf(R_2.*cos(ang),R_2.*sin(ang),100*ones(size(ang)));
%colormap('gray');
%colormap('copper');
%shading interp
%view([90,120,140]);
view(-37.2,18.8)

global field
field.l=1;
field.Xm={X};
field.Ym={Y};
field.Zm={Z};

field.Xsize=[-100,100];
field.Ysize=[-100,100];
field.Zsize=[-100,100];

field.Xm_save{1}=X;
field.Ym_save{1}=Y;
field.Zm_save{1}=Z;

for i=1:field.l
[~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
set(k2,'LineWidth',2);
[~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
set(k3,'LineWidth',2);
end
R=ROBOT;
%% 
%  return
PAR.viz_graph=false;%false;
iso_MODUL