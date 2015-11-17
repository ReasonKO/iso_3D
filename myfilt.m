function y=myfilt(x)
filt_ln=5;
global filt
if isempty(filt)
    for i=1:filt_ln
        filt.yold(i)=x;
    end
end


y=(x+sum(filt.yold))/(filt_ln+1);

filt.yold(1)=y;
for i=2:filt_ln
    filt.yold(i)=filt.yold(i-1);
end

end