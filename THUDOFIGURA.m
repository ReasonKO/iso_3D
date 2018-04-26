clear all
step=0.01;
[x,y,z]=meshgrid(-1:step:1,-1:step:1,-1:step:1);
rrange=...
  cos(4.0.*x./(x.*x+y.*y+z.*z+0.2)) .* sin(4.0*y./(x.*x+y.*y+z.*z+0.2)) ...
+ cos(4.0.*y./(x.*x+y.*y+z.*z+0.2)) .* sin(4.0.*z./(x.*x+y.*y+z.*z+0.2)) ...
+ cos(4.0.*z./(x.*x+y.*y+z.*z+0.2)) .* sin(4.0.*x./(x.*x+y.*y+z.*z+0.2))...
+ exp(0.5.*(x.*x+y.*y+z.*z - 0.1));
calc=1

pick=(rrange<=0.0);
figure(4)
clf
plot3(x(pick),y(pick),z(pick),'.K');
figure(3)
clf
hold all
% 
% ang=0.8
% X=x*cos(ang)-z*sin(ang);
% Z=x*sin(ang)+z*cos(ang);
% ang2=0.5
% Y=y*cos(ang2)-Z*sin(ang2);
% Z=y*sin(ang2)+Z*cos(ang2);
% 
X=x;
Y=y;
Z=z;


for zp=-1:step:1
    zp
    zin=(abs(Z-zp)<step/2)&pick;
%    if sum(sum(zin))>0
    plot3(X(zin),Y(zin),Z(zin),'.','color',[zp*0.5+0.5,0,0]);
%    end
end

view(44,10);
axis([-1,1,-1,1,-1,1])
