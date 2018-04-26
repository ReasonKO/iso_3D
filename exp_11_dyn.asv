global PAR Modul

global field
Xm=field.Xm_save{1};
Ym=field.Ym_save{1};
Zm=field.Zm_save{1};

X_=field.Xm_save{1};
Y_=field.Ym_save{1};
Z_=field.Zm_save{1};


T=Modul.T;
ang=T/100;
X=X_*cos(ang)-Y_*sin(ang);
Y=X_*sin(ang)+Y_*cos(ang);


global VIZ_11
setPlotData(VIZ_11,X,Y,Z);
setPlotData(k2,X,Y,Z);
setPlotData(k3,X,Y,Z);
field.Xm{1}=X;
field.Ym{1}=Y;
field.Zm{1}=Z;