
global Modul PAR
[~,~,I]=locI(Rang_);
while Modul.T<=Modul.Tend
    Iu=rul(R,I);
    R=R+I*Modul.dt*PAR.VSpeed;
    I=I+Modul.dt*PAR.USpeed*Iu;
    I=I/norm(I);
    if mod(Modul.N,floor(Modul.freq/Modul.dt))==0 
        MAP();
        drawnow();
        iso_save_map();
    end
    run(PAR.run_dynamic);
    Modul.T=Modul.T+Modul.dt;
    Modul.N=Modul.N+1;
end
MAP();
drawnow();
iso_save_map();
iso_save_param();
iso_save_map();
