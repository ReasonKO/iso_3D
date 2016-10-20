global Modul VIZ_9
t=Modul.T;
%-(cos(t/500)*2+cos(t/100)-3)*10,(sin(t/500)*2+sin(t/100))*10)
global field
Xm=field.Xm_save{1};
Ym=field.Ym_save{1};
Zm=field.Zm_save{1};

KOEF1=[38     3    59    73    65     6    15    76    50    38  ];
KOEF2=[46    33    86    61    20    14    77    65    34     6  ];
KOEF3=[46    54    83   100    38    19    99    68    93    64  ];

% CCC=[-sin(t/100)*100,50-cos(t/100)*50,t/10];
%CCC=[-sin(t/100)*100,50-cos(t/100)*50,0];



X=R_*sin(KOEF1*t/200);%+CCC(1);
Y=R_*sin(KOEF2*t/200);%+CCC(2);
Z=R_*sin(KOEF3*t/200);%+CCC(3);
normXYZ=sqrt(Y.^2+Z.^2+X.^2);

X(normXYZ>R_)=X(normXYZ>R_)./normXYZ(normXYZ>R_)*R_;
Y(normXYZ>R_)=Y(normXYZ>R_)./normXYZ(normXYZ>R_)*R_;
Z(normXYZ>R_)=Z(normXYZ>R_)./normXYZ(normXYZ>R_)*R_;


rotang=t/10;

M1=[1,0,0; 0,2,0;0,0,1];
M2=[1,0,0; 0,cos(pi/4),-sin(pi/4);0,sin(pi/4),cos(pi/4)];
M3=[cos(rotang),-sin(rotang),0; sin(rotang),cos(rotang),0;0,0,1];

X_=X;
Y_=Y;
Z_=Z;
for i=1:10
    V=M3*M2*M1*[X(i);Y(i);Z(i)];
    X(i)=V(1);
    Y(i)=V(2);
    Z(i)=V(3);
end
% R_p=normXYZ;
% for i=1:10
% ang1_p(i)=atan2(X(i),Y(i));
% ang2_p(i)=atan2(sqrt(X(i).^2+Y(i).^2),Z(i));
% end


% C=[
%     0.3160    0.8074    0.6782    1.0248
%     1.1064    2.6544    0.3411    0.4372
%     0.6469    0.1445    1.8006    2.6669
%     0.9989    0.0572    1.3197    2.1584
%     0.4617    0.7671    0.6326    0.8340
%     1.9868    0.9447    1.1966    1.8857
%     0.7123    1.7380    1.0178    2.2487
%     0.5489    2.8342    0.1893    2.5159
%     0.0306    0.2250    1.1113    1.2723
%     1.3734    0.5884    0.1685    2.9216];

% for i=1:N
%     eta=t*C(i,1)+C(i,2);
%     psi=t*C(i,3)+C(i,4);
%     field.Xm{1}(i)=R_*sin(eta)*cos(psi);
%     field.Ym{1}(i)=R_*sin(eta)*sin(psi);
%     field.Zm{1}(i)=R_*cos(eta);
% end

field.Xm{1}=X;
field.Ym{1}=Y;
field.Zm{1}=Z;

%setPlotData(VIZ_9.field,field.Xm{1},field.Ym{1},field.Zm{1});
for i=1:length(VIZ_9.field_2)
    setPlotData(VIZ_9.field_2(i),X(:),Y(:),Z(:));
end

global VIZ_8_2

[ang1,ang2]=meshgrid(-pi:pi/10:pi,-pi/2:pi/10:pi/2);
X2_=(R_+5)*sin(ang1).*cos(ang2);
Y2_=(R_+5)*sin(ang1).*sin(ang2);
Z2_=(R_+5)*cos(ang1);


for i=1:size(X2_,1)
for j=1:size(X2_,2)
V=M3*M2*M1*[X2_(i,j);Y2_(i,j);Z2_(i,j)];
X2(i,j)=V(1);
Y2(i,j)=V(2);
Z2(i,j)=V(3);
end
end

%Y2_=Y2_*2;
% Z2=cos(pi/4)*Y2_-sin(pi/4)*Z2_;
% Y2_=sin(pi/4)*Y2_+cos(pi/4)*Z2_;
% X2=cos(rotang)*X2_-sin(rotang)*Y2_;
% Y2=sin(rotang)*X2_+cos(rotang)*Y2_;
setPlotData(VIZ_8_2.field,X2,Y2,Z2);


%addPlotData(VIZ_9.field_3,X(end),Y(end),0);
