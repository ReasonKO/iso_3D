clear all
close all
clc;
def_ini
%% Начальная позиция и ориентация робота.
R=[30,80,2]; %[x,y,z]
Rang_=[pi/2-0.15,-1.7]; %Угло отклонения от Z и угол отклонения от X;
[~,~,I]=locI(Rang_);
%% Параметры алгоритма и моделирования
global Modul
Modul.freq=1;  %Частота обновления картинки в секундах
Modul.Tend=700;%865;

Modul.SaveExp=true;

global PAR
PAR.d0=40^2;        %Приследуемое значение
PAR.d0d=10^2;        %дельта в законе управления 5.5

%PAR.Sgrad=0.6;    %Гамма в законе управления
PAR.Sgrad=30;

PAR.Hspeed=0.03;   %Эта*
PAR.Hmax=30;    %H+
PAR.Hmin=-30;    %H-
PAR.USpeed=5;   %Угловая скорость
PAR.VSpeed=10;  %Линейная скорость
PAR.Uh=0.1;    %u_h с чертой
PAR.Um=1;       %u с чертой
PAR.Tin=30;     %время процесса IN
PAR.WipeAuto=1;
PAR.dHmax=3;
PAR.run_dynamic='exp_8_1_dyn';
%PAR.AngH=true;
%PAR.accumH=true;
%PAR.accumH_def=-20;
PAR.ExpName='Anny_1';
PAR.Dfunction=@(R)exp_8_D(R);


%% Дизайн
PAR.COLOR.R=[0,0,0];
PAR.COLOR.RL=[0,0,0];
PAR.COLOR.RH=[0,0,1];
%% Поле
[ang1,ang2]=meshgrid(-pi:pi/100:pi,-pi/2:pi/100:pi/2);
R_=50;

ang=-pi:pi/10:pi;
X1=sin(ang)*20;
Y1=cos(ang)*15;
Z1=-sin(ang)*20;

X2=sin(ang)*20;
Y2=cos(ang)*30;
Z2=-cos(ang)*20;

figure(3000)
clf
axis([-50,50,-50,50,-50,50])
hold on
%mesh(X,Y,Z,'EdgeColor','none');
%mesh(X1,Y1,Z1,'FaceAlpha',0.85);
global VIZ_8_1
colormap('gray');
VIZ_8_1.field_1=plot3(X1,Y1,Z1,'.--','color',[0,0.7,0],'MarkerSize',15);
VIZ_8_1.field_2=plot3(X2,Y2,Z2,'.--','color',[0.7,0,0],'MarkerSize',15);
%shading interp
view([70,80,50]);

%% Сохранение поля
global field
field.l=1;
field.Xm={X1,X2};
field.Ym={Y1,Y2};
field.Zm={Z1,Z2};

field.Xsize=[-50,50];
field.Ysize=[-50,50];
field.Zsize=[-50,50];

% 
% for i=1:field.l
% [~,k2]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmax*[1,1],'R');
% set(k2,'LineWidth',2);
% [~,k3]=contour3(field.Xm{i},field.Ym{i},field.Zm{i},PAR.Hmin*[1,1],'R');
% set(k3,'LineWidth',2);
% end
%%
PAR.d_noise=0;
PAR.h_noise=0.00;
PAR.filtON=false;
iso_MODUL