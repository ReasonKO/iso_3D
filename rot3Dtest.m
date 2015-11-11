
figure(1)
clf
subplot(2,2,1)
[X,Y]=meshgrid(-100:100,-100:100);
Z=max(0,50^2-X.^2-Y.^2).^(1)/25;
Z(Z==0)=NaN;
mesh(X,Y,Z);

subplot(2,2,2)
al=pi/6;
Xn=X;
Yn=Y*cos(al)-Z*2*sin(al)-25;
Zn=Y*sin(al)+Z*2*cos(al)+80;
mesh(Xn,Yn,Zn);
hold on
Xn2=X;
Yn2=Y*cos(-al)-Z*2*sin(-al)+25;
Zn2=Y*sin(-al)+Z*2*cos(-al)+80;
mesh(Xn2,Yn2,Zn2);

subplot(2,2,3)

Xn3=X*sqrt(2);
Yn3=Y*2;
Zn3=Z*2;
Xn3=Xn3.*(1-0.3*min(1,max(0,(-0.5+(Zn3-40)/40))).*(abs(Yn3)<30).*(1-sin(abs(Yn3)/30*pi/2)));
Zn3(Zn3>100)=NaN;
mesh(Xn3,Yn3,Zn3);

subplot(2,2,4)
mesh(Xn,Yn,Zn);
hold on
mesh(Xn2,Yn2,Zn2);
mesh(Xn3,Yn3,Zn3);
colormap('copper');
shading interp

figure(1234)
surf(Xn,Yn,Zn,'EdgeColor','none');
hold on
surf(Xn2,Yn2,Zn2,'EdgeColor','none');
surf(Xn3,Yn3,Zn3,'EdgeColor','none');
colormap('copper');
shading interp

%Z(


