
dviz=0.05;

R_=[1:10];
figure(4000)
clf
hold on
for i=1:length(R_)
R=R_(i);

[ang1,ang2]=meshgrid((-1:dviz:1)*pi,(0:dviz:1)*pi);

X=R*cos(ang1).*sin(ang2);
Y=R*sin(ang1).*sin(ang2);
Z=R*cos(ang2);

color=R/10;
viz{i}=surf(X,Y,Z,'EdgeColor',[color,color,1-color]);%'%,'Color',[R/10,1-R/10,1]);

set(viz{i},'CData',color*ones(size(Z)));
set(viz{i},'FaceAlpha',0.1)
set(viz{i},'EdgeAlpha',0.2)
end
axis equal
axis([-10,10,-10,10,-10,10])

a=0:0.1:2*pi
plot3(3*a.*sin(a),3*a.*cos(a),a,'B-')

