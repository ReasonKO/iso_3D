global Modul VIZ_9
t=Modul.T;
%-(cos(t/500)*2+cos(t/100)-3)*10,(sin(t/500)*2+sin(t/100))*10)
global field
Xm=field.Xm_save{1};
Ym=field.Ym_save{1};
Zm=field.Zm_save{1};

RotationXang=t/100;
RotationYang=sin(t/10);
RotationZang=t/200;

RotationMatrixZ=[cos(RotationZang), -sin(RotationZang),0
                 sin(RotationZang), cos(RotationZang),0
                 0, 0, 1];
RotationMatrixY=[cos(RotationYang),0, -sin(RotationYang)
                                0, 1,0 
                 sin(RotationYang),0, cos(RotationYang)];
RotationMatrixX=[1,0,0
                 0,cos(RotationXang), -sin(RotationXang)
                 0, sin(RotationXang), cos(RotationXang)];

RotationMatrix=RotationMatrixX*RotationMatrixY*RotationMatrixZ;


field.Xm={RotationMatrix(1,1)*Xm+RotationMatrix(1,2)*Ym+RotationMatrix(1,3)*Zm};
field.Ym={RotationMatrix(2,1)*Xm+RotationMatrix(2,2)*Ym+RotationMatrix(2,3)*Zm};
field.Zm={RotationMatrix(3,1)*Xm+RotationMatrix(3,2)*Ym+RotationMatrix(3,3)*Zm};

X=field.Xm{1};
Y=field.Ym{1};
Z=field.Zm{1};

%setPlotData(VIZ_9.field,field.Xm{1},field.Ym{1},field.Zm{1});
for i=1:length(VIZ_9.field_2)
    setPlotData(VIZ_9.field_2(i),X(:,i),Y(:,i),Z(:,i));
end
%addPlotData(VIZ_9.field_3,X(end),Y(end),0);
