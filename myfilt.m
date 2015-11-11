function y=myfilt(x)
global filt
if isempty(filt)
    filt.yold=x;
    filt.yoldold=x;
end
y=(x+filt.yold+2*filt.yoldold)/4;
filt.yoldold=filt.yold;
filt.yold=y;
end