%MODUL_INI
%MODUL_INI_2
%MODUL_INI_3
%MODUL_INI_4

%global Modul PAR
[~,~,I]=locI(Rang_);
for i=1:10000
    %PAR.H=[0,sin(atan2(R(2),R(3))+pi/2),cos((atan2(R(2),R(3)))+pi/2)];

    Iu=rul(R,I);
    R=R+I*Modul.dt*PAR.VSpeed;
    I=I+Modul.dt*PAR.USpeed*Iu;
    I=I/norm(I);
    if (i==1)
        figure(3000)
    end
    if mod(Modul.N,floor(Modul.freq/Modul.dt))==0
        MAP
        drawnow
    end
    Modul.T=Modul.T+Modul.dt;
    Modul.N=Modul.N+1;
    %if Modul.T>PAR.Tin
    %    break
    %end
    %PAR.H=[0,sin(atan2(R(2),R(3))+pi/2),cos((atan2(R(2),R(3)))+pi/2)];
    
end
