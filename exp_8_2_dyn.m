global Modul VIZ_8_2
t=Modul.T;
%-(cos(t/500)*2+cos(t/100)-3)*10,(sin(t/500)*2+sin(t/100))*10)
global field
field.Xm={field.Xm_save{1}-(sin(t/500)*3+sin(t/100))*30};
field.Ym={field.Ym_save{1}+(cos(t/500)*3+cos(t/100)-4)*30};
X=field.Xm{1};
Y=field.Ym{1};
Z=field.Zm{1};
setPlotData(VIZ_8_2.field,field.Xm{1},field.Ym{1},field.Zm{1});
for i=1:length(VIZ_8_2.field_2)
setPlotData(VIZ_8_2.field_2(i),X(:,i),Y(:,i),Z(:,i));
end
addPlotData(VIZ_8_2.field_3,X(end),Y(end),0);
