global Modul 
Modul.T

ang=(-pi:pi/10:pi)+Modul.T/50;
X1=sin(ang)*20;
Y1=cos(ang)*15;
Z1=-sin(ang)*20;

X2=sin(ang)*20;
Y2=cos(ang)*30;
Z2=-cos(ang)*20;
global VIZ_8_1
setPlotData(VIZ_8_1.field_1,X1,Y1,Z1);
setPlotData(VIZ_8_1.field_2,X2,Y2,Z2);

global field
field.Xm={X1,X2};
field.Ym={Y1,Y2};
field.Zm={Z1,Z2};
