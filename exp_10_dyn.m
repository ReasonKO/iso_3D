global Modul VIZ_9
t=Modul.T;
%-(cos(t/500)*2+cos(t/100)-3)*10,(sin(t/500)*2+sin(t/100))*10)
global field
Xm=field.Xm_save{1};
Ym=field.Ym_save{1};
Zm=field.Zm_save{1};

C=[
    0.3160    0.8074    0.6782    1.0248
    1.1064    2.6544    0.3411    0.4372
    0.6469    0.1445    1.8006    2.6669
    0.9989    0.0572    1.3197    2.1584
    0.4617    0.7671    0.6326    0.8340
    1.9868    0.9447    1.1966    1.8857
    0.7123    1.7380    1.0178    2.2487
    0.5489    2.8342    0.1893    2.5159
    0.0306    0.2250    1.1113    1.2723
    1.3734    0.5884    0.1685    2.9216];

for i=1:N
    eta=t*C(i,1)+C(i,2);
    psi=t*C(i,3)+C(i,4);
    field.Xm{1}(i)=R_*sin(eta)*cos(psi);
    field.Ym{1}(i)=R_*sin(eta)*sin(psi);
    field.Zm{1}(i)=R_*cos(eta);
end

X=field.Xm{1};
Y=field.Ym{1};
Z=field.Zm{1};

%setPlotData(VIZ_9.field,field.Xm{1},field.Ym{1},field.Zm{1});
for i=1:length(VIZ_9.field_2)
    setPlotData(VIZ_9.field_2(i),X(:),Y(:),Z(:));
end
%addPlotData(VIZ_9.field_3,X(end),Y(end),0);
