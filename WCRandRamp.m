function [ y ] = WCRandRamp( x, Fs, meangain, variance )
%WCRANDRAMP Implements the slow random ramping
%   x: input
%   Fs: sampling frequency
%   meangain: the value above and below which the gain varies
%   variance: the amount that the gain varies above and below the mean

maxgain = meangain + variance;
mingain = meangain - variance;
minlen = round(Fs*0.7); %minimum length for ramp
maxlen = round(Fs*3.0); %maximum length for ramp
y = zeros(length(x),1);
index = 1;

rampstate = maxgain;
goingup = false;
if randi(2)-1 == 1
    rampstate = mingain;
    goingup = true;
end

while index < length(x)
    %New random length for ramp:
    ramplen = minlen + randi(maxlen-minlen,1);
    if (index + ramplen)>length(x)
        if (length(x)-index)<minlen
            ramp = (rampstate*ones(length(x)-index+1,1));
            y(index:end) = ramp.*x(index:end);
            break
        else
            ramplen = length(x)-index;
        end
    end
    if goingup
        ramp = ((1:ramplen)./ramplen)';
        ramp = mingain + ramp*(maxgain-mingain);
    else
        ramp = ((1:ramplen)./ramplen)';
        ramp = maxgain - ramp*(maxgain-mingain);
    end
    y(index:index+ramplen-1) = ramp.*x(index:index+ramplen-1);
    goingup = ~goingup;
    index = index+ramplen;
    rampstate=ramp(end);
end

