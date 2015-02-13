function [ y ] = WCHarmoniser( x, Fs )
%The Harmoniser for the Warm Chorus algorithm
%	x: input
%	y. output
%	Fs: sampling frequency

f = 20;
T = length(transpose(x))/Fs;
dt = 1/Fs;
t = 0:dt:T-dt;
p1 = (1+sawtooth(2*pi*f*t))/2;
p2 = (1+sawtooth(2*pi*f*t+pi/2))/2;
p3 = (1+sawtooth(2*pi*f*t+pi))/2;
p4 = (1+sawtooth(2*pi*f*t+3*pi/2))/2;

y =  WCHarmLoop(x,p1,f,Fs)...
    +WCHarmLoop(x,p2,f,Fs)...
    +WCHarmLoop(x,p3,f,Fs)...
    +WCHarmLoop(x,p4,f,Fs);
end

