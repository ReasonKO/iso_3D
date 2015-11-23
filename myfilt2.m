function y=myfilt2(x)
filt_ln=5;
global filt2
if isempty(filt2)
    for i=1:filt_ln
        filt2.yold(i)=x;
    end
end


y=(x+sum(filt2.yold))/(filt_ln+1);

filt2.yold(1)=y;
for i=2:filt_ln
    filt2.yold(i)=filt2.yold(i-1);
end

end