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
%PAR.re_h=@(R)
%  20*mod(pi+atan2(R(1)*R(3),abs(R(3))),pi);

% PAR.re_h=@(R)...
%   20*mod(pi+atan2(...
% cross(R,[0,1,0])*[0,0,1]'*...
% sign(cross(R,[0,1,0])*[1,0,0]'),...
% abs(cross(R,[0,1,0])*[1,0,0]')),pi);

%.sin(atan2(R(1),R(2)))*cos(atan2(R(3),sqrt(R(1)^2+R(2)^2))+pi/2),sin(atan2(R(3),sqrt(R(1)^2+R(2)^2))+pi/2));
%% Поле


vt=@(t)1;%(0.2+((sin((abs(t)*2-1)*pi/2))/2+0.5)*0.8).*(abs(t)<1)+1*(abs(t)>=1);
[ang1,ang2]=meshgrid(-pi:pi/100:pi,-pi/2:pi/100:pi/2);
R_=50;


%[]=meshgrid(pi:,1:3);
%[ANG,Z]=meshgrid([1,2,3,4,8,12,16,15,14,13,9,5,1],0:3);

ang=-pi:pi/10:pi;
X1=sin(ang)*20;
Y1=cos(ang)*15;
Z1=-sin(ang)*20;

X2=sin(ang)*20;
Y2=cos(ang)*30;
Z2=-cos(ang)*20;


%X1=[0,0,0,0;1,1,1,1;2,2,2,2;3,3,3,3]*10;
%Y1=[0,0,0,0;-0.5,-0.5,0.5, 0.5;-1,0,0,1;-1.5,-0.5,0.5,1.5]*10*2;
%Z1=[3,3,3,3;2,2,2,2;1,1,1,1;0,0,0,0]*10;



%X=mod(ANG-1,4)+1-2.5;
%Y=(ANG-rem(ANG-1,4)+1)/4-2;



%X=[-3,-3,-3,-3; -1,-1,-1,-1; 1,1,1,1; 3,3,3,3];
%Y=X';
%Z=zeros(size(X));
%R_*sin(ang1).*cos(ang2).*max(vt(azi(ang1-pi/3)),vt(ang2));
%Y=%R_*cos(ang1).*cos(ang2).*max(vt(azi(ang1-pi/3)),vt(ang2));
%Z=%R_*sin(ang2);
figure(3000)
clf
axis([-50,50,-50,50,-50,50])
hold on
%mesh(X,Y,Z,'EdgeColor','none');
%mesh(X1,Y1,Z1,'FaceAlpha',0.85);
global VIZ_8_1
colormap('gray');
 VIZ_8_1.field_1=plot3(X1,Y1,Z1,'G.--','MarkerSize',15);
 VIZ_8_1.field_2=plot3(X2,Y2,Z2,'R.--','MarkerSize',15);
%shading interp
view([70,80,50]);

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