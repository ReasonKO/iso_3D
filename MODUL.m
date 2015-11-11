%MODUL_INI
%MODUL_INI_2
MODUL_INI_3
%MODUL_INI_4

%global Modul PAR

for i=1:10000
    Iu=rul(R,I);
    R=R+I*Modul.dt*PAR.VSpeed;
    I=I+Modul.dt*PAR.USpeed*Iu;
    I=I/norm(I);
    if (i==1)
        figure(3000)
    end
    if mod(Modul.N,Modul.freqN)==0
        MAP
        drawnow
    end
    Modul.T=Modul.T+Modul.dt;
    Modul.N=Modul.N+1;
    %if Modul.T>PAR.Tin
    %    break
    %end
end
